import 'package:flutter/material.dart';
import 'package:registrationhelper/camera.dart';
import 'package:registrationhelper/client.dart';
import 'package:registrationhelper/leftNavPanel.dart';
import 'package:registrationhelper/profile.dart';
import 'package:registrationhelper/rightScreen.dart';

void main() {
  runApp(const MaterialApp(
    home: Home(),
  ));
}

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<dynamic>? _listOfStudents;
  int? _selectedUserId;
  String? _selectedUsername;

  @override
  void initState() {
    super.initState();
    DioHelper.prepareJar();
    DioHelper.getListOfStudents((data, error) {
      if (!error) {
        _listOfStudents = data;
        setState(() {});
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Registrations 2024"),
        centerTitle: true,
        elevation: 2,
      ),
      body: Row(
        children: [
          Flexible(
            flex: 1,
            child: LeftNavigationPanel(
              list: _listOfStudents,
              onTap: (id) {
                setState(() {
                  _selectedUserId = id;
                });
              },
            ),
          ),
          Flexible(
            flex: 2,
            child: RightScreen(
              selectedStudent: _selectedUserId,
            ),
          )
        ],
      ),
    );
  }
}
