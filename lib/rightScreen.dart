import 'package:flutter/material.dart';
import 'package:registrationhelper/camera.dart';
import 'package:registrationhelper/profile.dart';

class RightScreen extends StatefulWidget {
  int? selectedStudent;

  RightScreen({super.key, this.selectedStudent});

  @override
  State<RightScreen> createState() => _RightScreenState();
}

class _RightScreenState extends State<RightScreen> {
  @override
  Widget build(BuildContext context) {
    return widget.selectedStudent == null
        ? Text("OWU")
        : DefaultTabController(
            length: 3,
            child: Column(
              children: [
                const TabBar(
                  tabs: [
                    Tab(icon: Icon(Icons.person), text: "Info"),
                    Tab(icon: Icon(Icons.image), text: "Picture"),
                    Tab(
                      icon: Icon(Icons.history),
                      text: "Changelog",
                    ),
                  ],
                ),
                Expanded(
                  child: TabBarView(
                    children: [
                      Profile(
                        studentId: widget.selectedStudent!,
                        key: ValueKey("${widget.selectedStudent!}profile"),
                      ),
                      CameraApp(
                        studentId: widget.selectedStudent!,
                      ),
                      const Center(child: Text("Changelog")),
                    ],
                  ),
                ),
              ],
            ),
          );
  }
}
