import 'dart:typed_data';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:registrationhelper/client.dart';
import 'package:registrationhelper/utils.dart';

List<CameraDescription>? _cameras;

/// CameraApp is the Main Application.
class CameraApp extends StatefulWidget {
  final int studentId;

  /// Default Constructor
  const CameraApp({
    super.key,
    required this.studentId,
  });

  @override
  State<CameraApp> createState() => _CameraAppState();
}

class _CameraAppState extends State<CameraApp>
    with AutomaticKeepAliveClientMixin {
  CameraController? controller;
  CameraDescription? _selectedCamera;
  Uint8List? _capturedByteArray;
  bool? uploadStatus;
  dynamic student;

  @override
  bool get wantKeepAlive => true;

  void getAllAvailableCameras() async {
    WidgetsFlutterBinding.ensureInitialized();
    _cameras = await availableCameras();
    setState(() {});
    print(_cameras);
  }

  void _loadStudentData() {
    print('loading student data for camera');
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
    addOnCompleteTwo((rollno, status) {
      if (rollno == widget.studentId) {
        setState(() {
          uploadStatus = status;
        });
      }
    });
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

  _loadImage() {
    DioHelper.getImage(widget.studentId, (array, error) {
      if (!error) {
        setState(() {
          _capturedByteArray = array;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    super.build(
        context); // Ensure AutomaticKeepAliveClientMixin is used correctly

    // Load student data whenever widget.studentId changes
    if (student == null || student['rollno'] != widget.studentId) {
      _capturedByteArray = null;
      uploadStatus = null;
      _loadStudentData();
      _loadImage();
    }

    if (_cameras == null) {
      return Center(child: CircularProgressIndicator());
    }

    if (controller == null || !controller!.value.isInitialized) {
      return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.all(10),
            child: DropdownButton<CameraDescription>(
              borderRadius: const BorderRadius.all(Radius.circular(5)),
              hint: const Padding(
                padding: EdgeInsets.all(8.0),
                child: Text("Select a Camera"),
              ),
              value: _selectedCamera,
              items: _cameras!.map((camera) {
                return DropdownMenuItem<CameraDescription>(
                  value: camera,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(camera.name),
                  ),
                );
              }).toList(),
              onChanged: (value) {
                setState(() {
                  _selectedCamera = value!;
                });
              },
            ),
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
      padding: const EdgeInsets.all(5.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Expanded(
            child: Column(
              children: [
                Flexible(
                  child: CameraPreview(controller!),
                ),
              ],
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("${widget.studentId}"),
              const SizedBox(height: 10),
              Text("${student['name']}"),
              const SizedBox(height: 10),
              ElevatedButton(
                onPressed: () {
                  print("Capturing Image");
                  _captureImage();
                  print("ID of Student is ${widget.studentId}");
                },
                child: Text("Capture"),
              ),
              const SizedBox(
                height: 10,
              ),
              ElevatedButton(
                onPressed: () {
                  if (_capturedByteArray != null) {
                    uploadImage(student['rollno'], "${student['rollno']}.jpg",
                        _capturedByteArray!);
                  } else {
                    print("No image captured to save.");
                  }
                },
                child: const Text("Save"),
              ),
              const SizedBox(
                height: 10,
              ),
              Text('<- Live Image'),
              const SizedBox(height: 10),
              Text("Captured Image ->"),
              const SizedBox(height: 10),
              if (uploadStatus == null)
                Text(
                  "Upload : Pending",
                  style: TextStyle(color: Colors.orange),
                )
              else if (uploadStatus!)
                Text(
                  "Upload : Success",
                  style: TextStyle(color: Colors.green),
                )
              else
                Text(
                  "Upload : Failed",
                  style: TextStyle(color: Colors.red),
                )
            ],
          ),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _capturedByteArray == null
                    ? Text("No image captured")
                    : Flexible(
                        child: Image.memory(_capturedByteArray!),
                      ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
