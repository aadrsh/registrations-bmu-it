import 'package:camera/camera.dart';
import 'package:flutter/material.dart';

late List<CameraDescription> _cameras;

/// CameraApp is the Main Application.
class CameraApp extends StatefulWidget {
  /// Default Constructor
  const CameraApp({super.key});

  @override
  State<CameraApp> createState() => _CameraAppState();
}

class _CameraAppState extends State<CameraApp> {
  CameraController? controller;

  void getAllAvailableCameras() async {
    WidgetsFlutterBinding.ensureInitialized();
    _cameras = await availableCameras();
    print(_cameras);
  }

  void initController() async {
    controller = CameraController(_cameras[0], ResolutionPreset.max);
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

  @override
  Widget build(BuildContext context) {
    if (controller == null || !controller!.value.isInitialized) {
      return Container(
        child: Column(
          children: [
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
            AspectRatio(
              aspectRatio: 1 / controller!.value.aspectRatio,
              child: Center(
                child: CameraPreview(
                  controller!,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
