import 'package:flutter/material.dart';
import 'package:registrationhelper/client.dart';

class NewStudentDialog extends StatefulWidget {
  const NewStudentDialog({super.key});

  @override
  State<NewStudentDialog> createState() => _NewStudentDialogState();
}

class _NewStudentDialogState extends State<NewStudentDialog> {
  TextEditingController firstNameTextController = TextEditingController();
  TextEditingController lastNameTextController = TextEditingController();
  bool isProcessing = false;
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text("New Student"),
      content: SingleChildScrollView(
        child: Form(
          child: Column(
            children: [
              const Text("Add Basic Details to Continue"),
              const SizedBox(
                height: 10,
              ),
              TextFormField(
                controller: firstNameTextController,
                decoration: const InputDecoration(
                  labelText: "First Name",
                  hintText: "John",
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 10),
              TextFormField(
                controller: lastNameTextController,
                decoration: const InputDecoration(
                  labelText: "Last Name",
                  hintText: "Doe",
                  border: OutlineInputBorder(),
                ),
              ),
            ],
          ),
        ),
      ),
      actions: [
        TextButton(
            onPressed: () {
              Navigator.pop(context, 2);
            },
            child: const Text("Cancel")),
        TextButton(
            onPressed: isProcessing
                ? null
                : () {
                    setState(() {
                      isProcessing = true;
                    });
                    var firstName = firstNameTextController.text;
                    var lastName = lastNameTextController.text;
                    DioHelper.addNewStudent(firstName, lastName, (data, error) {
                      if (!error) {
                        Navigator.pop(context, data);
                      }
                    });
                  },
            child: const Text("Continue")),
      ],
    );
  }
}
