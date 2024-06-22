import 'package:flutter/material.dart';
import 'package:registrationhelper/camera.dart';
import 'package:registrationhelper/client.dart';
import 'package:registrationhelper/profile.dart';

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
  int? _selectedUser;
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
          getLeftNavigationPanel(),
          getMainScreen()
          // : Text("Test"))
        ],
      ),
    );
  }

  Flexible getMainScreen() {
    return Flexible(
        flex: 2,
        child: _selectedUser == null
            ? Text("Please select a student")
            : DefaultTabController(
                length: 3,
                child: Column(
                  // Wrap TabBar and TabBarView in a Column
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
                      // Use Expanded to let TabBarView fill available space
                      child: TabBarView(
                        children: [
                          // Your content for each tab goes here
                          Profile(
                              studentId: _selectedUser!,
                              key: ValueKey("${_selectedUser!}profile")),
                          CameraApp(
                            studentId: _selectedUser!,
                            studentName: _selectedUsername!,
                          ),
                          const Center(child: Text("Changelog")),
                        ],
                      ),
                    ),
                  ],
                ),
              ));
  }

  getLeftNavigationPanel() {
    return Flexible(
      flex: 1,
      child: Container(
        color: const Color.fromARGB(255, 230, 230, 230),
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            children: [
              const Padding(
                padding: EdgeInsets.all(10.0),
                child: Text("Home"),
              ),
              const TextField(
                decoration: InputDecoration(
                    hintText: "Search", border: OutlineInputBorder()),
              ),
              Expanded(
                child: _listOfStudents == null
                    ? const Text("Please wait")
                    : ListView.builder(
                        itemCount: _listOfStudents!.length,
                        itemBuilder: (context, index) {
                          return ListTile(
                            onTap: () {
                              setState(() {
                                _selectedUser = _listOfStudents![index]['id'];
                                _selectedUsername =
                                    "${_listOfStudents![index]['firstName']} ${_listOfStudents![index]['lastName']}";
                              });
                              print(_selectedUser);
                            },
                            leading: Image.asset(
                              'images/person.png',
                              height: 20,
                              width: 20,
                            ),
                            title: Text(
                                "${_listOfStudents![index]['firstName']} ${_listOfStudents![index]['lastName']}"),
                            subtitle: Text("Roll No 24001$index"),
                          );
                        },
                      ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
