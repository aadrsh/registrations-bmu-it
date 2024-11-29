import 'package:flutter/material.dart';
import 'package:registrationhelper/client.dart';

class Profile extends StatefulWidget {
  final int studentId;

  const Profile({super.key, required this.studentId});

  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  dynamic student;

  @override
  void initState() {
    super.initState();
    _loadStudentData();
  }

  void _loadStudentData() {
    print('loading Student Data');
    DioHelper.getStudentById(widget.studentId, (data, error) {
      if (!error) {
        setState(() {
          student = data;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(50.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          _buildField(
              "Roll No.", student != null ? student['rollno'].toString() : ""),
          _buildField("Application No.",
              student != null ? student['applicationno'].toString() : ""),
          _buildField(
              "Full Name", student != null ? student['name'].toString() : ""),
          _buildField("Department",
              student != null ? student['department'].toString() : ""),
          _buildField(
              "Course", student != null ? student['course'].toString() : ""),
          _buildField("Parent's Contact No",
              student != null ? student['parentsNumber'].toString() : ""),
          _buildField("Blood Group",
              student != null ? student['bloodGroup'].toString() : ""),
        ],
      ),
    );
  }

  Widget _buildField(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              value,
              style: const TextStyle(fontSize: 16),
            ),
          ),
        ],
      ),
    );
  }
}
