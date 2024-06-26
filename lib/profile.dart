import 'package:flutter/material.dart';
import 'package:registrationhelper/client.dart';

class Profile extends StatefulWidget {
  final int studentId;
  Profile({
    Key? key,
    required this.studentId,
  }) : super(key: key);

  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  dynamic student;

  TextEditingController rollNoTextEditingController = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    DioHelper.getStudentById(widget.studentId, (data, error) {
      if (!error) student = data;
      print(student['rollno']);
      rollNoTextEditingController.text = '${student['rollno'] ?? ""}';
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(50.0),
      child: Form(
          child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // Padding(
          //   padding: const EdgeInsets.all(10.0),
          //   child: Image.asset(
          //     "images/person.png",
          //     height: 200,
          //     width: 200,
          //   ),
          // ),
          TextFormField(
            controller: rollNoTextEditingController,
            decoration: const InputDecoration(
                label: Text("Roll No."),
                hintText: "240XXX",
                border: OutlineInputBorder()),
          ),
          const SizedBox(height: 10),
          Row(children: [
            Expanded(
                flex: 1,
                child: TextFormField(
                  decoration: const InputDecoration(
                      label: Text("First Name"),
                      hintText: "John",
                      border: OutlineInputBorder()),
                )),
            const SizedBox(width: 10),
            Expanded(
                flex: 1,
                child: TextFormField(
                  decoration: const InputDecoration(
                      label: Text("Last Name"),
                      hintText: "Doe",
                      border: OutlineInputBorder()),
                )),
          ]),
          const SizedBox(height: 10),
          const Row(
            children: [
              Expanded(
                  flex: 1,
                  child: DropdownMenu(
                      hintText: "Department",
                      dropdownMenuEntries: [
                        DropdownMenuEntry(
                            value: "som", label: "School of Management"),
                        DropdownMenuEntry(
                            value: "soet",
                            label: "School of Engineering and Technology"),
                        DropdownMenuEntry(value: "sol", label: "School of Law"),
                        DropdownMenuEntry(
                            value: "sols", label: "School of Liberal Studies")
                      ])),
              Expanded(
                  flex: 1,
                  child: DropdownMenu(
                    dropdownMenuEntries: [
                      DropdownMenuEntry(value: "mba", label: "MBA"),
                      DropdownMenuEntry(value: "btech", label: "B.Tech"),
                      DropdownMenuEntry(value: "bba", label: "BBA"),
                      DropdownMenuEntry(value: "bmi", label: "BMI"),
                    ],
                  ))
            ],
          ),
          const SizedBox(height: 10),
          TextFormField(
            decoration: const InputDecoration(
                label: Text("School"),
                hintText: "SOET/SOM/SOL/SOLS",
                border: OutlineInputBorder()),
          ),
          const SizedBox(height: 10),
          TextFormField(
            decoration: const InputDecoration(
                label: Text("Branch"),
                hintText: "BBA/MBA",
                border: OutlineInputBorder()),
          ),
        ],
      )),
    );
  }
}
