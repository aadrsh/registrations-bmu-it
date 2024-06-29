import 'package:flutter/material.dart';
import 'package:registrationhelper/client.dart';
import 'package:registrationhelper/leftScreen.dart';
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
    _loadStudents('');
  }

  void _loadStudents(String searchTerm) {
    DioHelper.prepareJar();
    DioHelper.getListOfStudents(searchTerm, (data, error) {
      if (!error) {
        _listOfStudents = data;
        setState(() {});
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
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
                onTextChange: (text) {
                  _loadStudents(text);
                }),
          ),
          Flexible(
            flex: 4,
            child: RightScreen(
              selectedStudent: _selectedUserId,
            ),
          )
        ],
      ),
    );
  }
}
