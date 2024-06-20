import 'dart:typed_data';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';

List<CameraDescription>? _cameras;

/// CameraApp is the Main Application.
class CameraApp extends StatefulWidget {
  /// Default Constructor
  const CameraApp({super.key});

  @override
  State<CameraApp> createState() => _CameraAppState();
}

class _CameraAppState extends State<CameraApp> {
  CameraController? controller;
  CameraDescription? _selectedCamera;
  Uint8List? _capturedByteArray;

  void getAllAvailableCameras() async {
    WidgetsFlutterBinding.ensureInitialized();
    _cameras = await availableCameras();
    setState(() {});
    print(_cameras);
  }

  void initController() async {
    if (_selectedCamera != null) {
      controller = CameraController(_selectedCamera!, ResolutionPreset.max);
      controller!.initialize().then((_) {
        if (!mounted) {
          return;
        }
        setState(() {});
      }).catchError((Object e) {
        if (e is CameraException) {
          switch (e.code) {
            case 'CameraAccessDenied':
              // Handle access errors here.
              break;
            default:
              // Handle other errors here.
              break;
          }
        }
      });
    } else {
      print("Please select the camera first");
    }
  }

  @override
  void initState() {
    super.initState();
    getAllAvailableCameras();
  }

  @override
  void dispose() {
    if (controller != null) controller!.dispose();
    super.dispose();
  }

  void _captureImage() async {
    try {
      if (controller!.value.isTakingPicture) {
        // A capture is already pending, do nothing
        return null;
      }

      XFile file = await controller!.takePicture();

      // Get the bytecode of the captured image
      _capturedByteArray = await file.readAsBytes();
      setState(() {});
      // Optionally, you can delete the file after reading its content
      // await file.delete();
    } catch (e) {
      print(e);
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_cameras == null) {
      return const Text("Please wait while we processing the camera");
    }
    if (controller == null || !controller!.value.isInitialized) {
      return Container(
        child: Column(
          children: [
            DropdownMenu(
                hintText: "Select a Camera",
                onSelected: (value) {
                  _selectedCamera = value;
                },
                dropdownMenuEntries: [
                  for (CameraDescription _camera in _cameras!)
                    DropdownMenuEntry(value: _camera, label: _camera.name),
                ]),
            ElevatedButton(
                onPressed: () {
                  initController();
                },
                child: Text("Init Controller"))
          ],
        ),
      );
    }
    return Container(
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Row(
          children: [
            Flexible(
              flex: 1,
              child: Column(
                children: [
                  Text("Live Image"),
                  Flexible(
                      // child: AspectRatio(
                      // aspectRatio: 1 / controller!.value.aspectRatio,
                      child: CameraPreview(controller!)),
                  // ),
                  ElevatedButton(
                      onPressed: () {
                        print("Capturing Image");
                        _captureImage();
                      },
                      child: Text("Capture"))
                ],
              ),
            ),
            Flexible(
                flex: 1,
                child: Column(
                  children: [
                    Text("Captured Image"),
                    _capturedByteArray == null
                        ? Text("")
                        : Image.memory(_capturedByteArray!),
                  ],
                ))
          ],
        ),
      ),
    );
  }
}
