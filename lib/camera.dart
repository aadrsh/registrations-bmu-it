import 'dart:typed_data';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:registrationhelper/client.dart';
import 'package:registrationhelper/utils.dart';

List<CameraDescription>? _cameras;
dynamic student;

/// CameraApp is the Main Application.
class CameraApp extends StatefulWidget {
  final int studentId;

  /// Default Constructor
  const CameraApp({
    Key? key,
    required this.studentId,
  }) : super(key: key);

  @override
  State<CameraApp> createState() => _CameraAppState();
}

class _CameraAppState extends State<CameraApp>
    with AutomaticKeepAliveClientMixin {
  CameraController? controller;
  CameraDescription? _selectedCamera;
  Uint8List? _capturedByteArray;

  @override
  bool get wantKeepAlive => true;

  void getAllAvailableCameras() async {
    WidgetsFlutterBinding.ensureInitialized();
    _cameras = await availableCameras();
    setState(() {});
    print(_cameras);
  }

  void _loadStudentData() {
    DioHelper.getStudentById(widget.studentId, (data, error) {
      if (!error) {
        setState(() {
          student = data;
        });
      }
    });
  }

  void initController() async {
    if (_selectedCamera != null) {
      controller = CameraController(_selectedCamera!, ResolutionPreset.max);
      try {
        await controller!.initialize();
        setState(() {});
      } catch (e) {
        print("Error initializing camera: $e");
        // Handle camera initialization error
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: Text('Camera Error'),
            content: Text('Failed to initialize camera.'),
            actions: <Widget>[
              TextButton(
                child: Text('OK'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          ),
        );
      }
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
    print("dispose method called");
    disposeController();
    super.dispose();
  }

  void disposeController() {
    if (controller != null) {
      controller!.dispose();
      controller = null;
    }
  }

  void _captureImage() async {
    try {
      if (controller!.value.isTakingPicture) {
        // A capture is already pending, do nothing
        return;
      }

      XFile file = await controller!.takePicture();

      // Get the byte data of the captured image
      _capturedByteArray = await file.readAsBytes();

      setState(() {});
      // Optionally, you can delete the file after reading its content
      // await file.delete();
    } catch (e) {
      print("Error capturing image: $e");
      // Handle capture error
    }
  }

  @override
  Widget build(BuildContext context) {
    super.build(
        context); // Ensure AutomaticKeepAliveClientMixin is used correctly

    if (_cameras == null) {
      return Center(child: CircularProgressIndicator());
    }

    if (controller == null || !controller!.value.isInitialized) {
      return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          DropdownButton<CameraDescription>(
            hint: Text("Select a Camera"),
            value: _selectedCamera,
            items: _cameras!.map((camera) {
              return DropdownMenuItem<CameraDescription>(
                value: camera,
                child: Text(camera.name),
              );
            }).toList(),
            onChanged: (value) {
              setState(() {
                _selectedCamera = value!;
              });
            },
          ),
          ElevatedButton(
            onPressed: () {
              initController();
            },
            child: Text("Init Controller"),
          ),
        ],
      );
    }

    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Expanded(
            child: Column(
              children: [
                Text("Live Image"),
                Flexible(
                  child: CameraPreview(controller!),
                ),
                ElevatedButton(
                  onPressed: () {
                    print("Capturing Image");
                    _captureImage();
                    print("ID of Student is ${widget.studentId}");
                  },
                  child: Text("Capture"),
                ),
              ],
            ),
          ),
          Expanded(
            child: Column(
              children: [
                Text("Captured Image"),
                _capturedByteArray == null
                    ? Text("No image captured")
                    : Flexible(
                        child: Image.memory(_capturedByteArray!),
                      ),
                ElevatedButton(
                  onPressed: () {
                    if (_capturedByteArray != null) {
                      uploadImage(
                          "${student['rollno']}.jpg", _capturedByteArray!);
                    } else {
                      print("No image captured to save.");
                    }
                  },
                  child: const Text("Save"),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
