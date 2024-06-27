import 'package:flutter/material.dart';
import 'package:registrationhelper/client.dart';

class Profile extends StatefulWidget {
  final int studentId;

  Profile({Key? key, required this.studentId}) : super(key: key);

  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  dynamic student;

  TextEditingController applicationNoEditingController =
      TextEditingController();
  TextEditingController rollNoTextEditingController = TextEditingController();
  TextEditingController firstNameTextEditingController =
      TextEditingController();
  TextEditingController lastNameTextEditingController = TextEditingController();
  TextEditingController parentsNumberTextEditingController =
      TextEditingController();

  @override
  void initState() {
    super.initState();
    _loadStudentData();
  }

  void _loadStudentData() {
    DioHelper.getStudentById(widget.studentId, (data, error) {
      if (!error) {
        setState(() {
          student = data;
          applicationNoEditingController.text =
              student['applicationno'].toString();
          rollNoTextEditingController.text = student['rollno'].toString();
          firstNameTextEditingController.text = student['firstName'].toString();
          lastNameTextEditingController.text = student['lastName'].toString();
          parentsNumberTextEditingController.text =
              student['parentsNumber'] ?? "";
        });
      }
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
            Row(
              children: [
                Expanded(
                  flex: 1,
                  child: TextFormField(
                    controller: rollNoTextEditingController,
                    decoration: const InputDecoration(
                      label: Text("Roll No."),
                      hintText: "240XXX",
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
                Expanded(
                  flex: 1,
                  child: TextFormField(
                    controller: applicationNoEditingController,
                    decoration: const InputDecoration(
                      label: Text("Application No."),
                      hintText: "BMU/PG/20244XXX",
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            Row(
              children: [
                Expanded(
                  flex: 1,
                  child: TextFormField(
                    controller: firstNameTextEditingController,
                    decoration: const InputDecoration(
                      label: Text("First Name"),
                      hintText: "John",
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  flex: 1,
                  child: TextFormField(
                    controller: lastNameTextEditingController,
                    decoration: const InputDecoration(
                      label: Text("Last Name"),
                      hintText: "Doe",
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            Row(
              children: [
                Expanded(
                  flex: 1,
                  child: DropdownMenu(
                    initialSelection:
                        student != null ? student['department'] : null,
                    hintText: "Department",
                    dropdownMenuEntries: const [
                      DropdownMenuEntry(
                          value: "som", label: "School of Management"),
                      DropdownMenuEntry(
                          value: "soet",
                          label: "School of Engineering and Technology"),
                      DropdownMenuEntry(value: "sol", label: "School of Law"),
                      DropdownMenuEntry(
                          value: "sols", label: "School of Liberal Studies"),
                    ],
                    onSelected: (value) {
                      print(value);
                    },
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: DropdownMenu(
                    initialSelection:
                        student != null ? student['course'] : null,
                    dropdownMenuEntries: [
                      DropdownMenuEntry(value: "mba", label: "MBA"),
                      DropdownMenuEntry(value: "btech", label: "B.Tech"),
                      DropdownMenuEntry(value: "bba", label: "BBA"),
                      DropdownMenuEntry(value: "bmi", label: "BMI"),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            Row(
              children: [
                Expanded(
                  flex: 1,
                  child: TextFormField(
                    controller: parentsNumberTextEditingController,
                    decoration: const InputDecoration(
                      label: Text("Parent's Contact No"),
                      hintText: "+91-XXXXXXXXXX",
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
                Expanded(
                  flex: 1,
                  child: DropdownMenu(
                    initialSelection: student?['bloodGroup'].toString(),
                    // student != null ? student['course'] : null,
                    dropdownMenuEntries: const [
                      DropdownMenuEntry(value: "A+", label: "A+"),
                      DropdownMenuEntry(value: "A-", label: "A-"),
                      DropdownMenuEntry(value: "B+", label: "B+"),
                      DropdownMenuEntry(value: "B-", label: "B-"),
                      DropdownMenuEntry(value: "AB+", label: "AB+"),
                      DropdownMenuEntry(value: "AB-", label: "AB-"),
                      DropdownMenuEntry(value: "O+", label: "O+"),
                      DropdownMenuEntry(value: "O-", label: "O-"),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
