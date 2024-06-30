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
        ? const Center(child: Text("OWU"))
        : DefaultTabController(
            length: 2,
            child: Column(
              children: [
                const TabBar(
                  tabs: [
                    Tab(text: "Picture"),
                    Tab(text: "Info"),
                  ],
                ),
                Expanded(
                  child: TabBarView(
                    children: [
                      CameraApp(
                        studentId: widget.selectedStudent!,
                      ),
                      Profile(
                        studentId: widget.selectedStudent!,
                        key: ValueKey("${widget.selectedStudent!}profile"),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
  }
}
