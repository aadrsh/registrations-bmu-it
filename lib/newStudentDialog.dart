import 'package:flutter/material.dart';
import 'package:registrationhelper/client.dart';

class NewStudentDialog extends StatefulWidget {
  const NewStudentDialog({super.key});

  @override
  State<NewStudentDialog> createState() => _NewStudentDialogState();
}

class _NewStudentDialogState extends State<NewStudentDialog> {
  TextEditingController nameTextController = TextEditingController();
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
                controller: nameTextController,
                decoration: const InputDecoration(
                  labelText: "Full Name",
                  hintText: "John Doe",
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
              Navigator.pop(context, -1);
            },
            child: const Text("Cancel")),
        TextButton(
            onPressed: isProcessing
                ? null
                : () {
                    setState(() {
                      isProcessing = true;
                    });
                    var name = nameTextController.text;
                    DioHelper.addNewStudent(name, (data, error) {
                      if (!error) {
                        Navigator.pop(context, data['id']);
                      }
                    });
                  },
            child: const Text("Continue")),
      ],
    );
  }
}
