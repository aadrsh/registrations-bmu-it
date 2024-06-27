import 'package:flutter/material.dart';
import 'package:registrationhelper/newStudentDialog.dart';

class LeftNavigationPanel extends StatefulWidget {
  List<dynamic>? list;
  Function(int) onTap;
  Function(String) onTextChange;

  LeftNavigationPanel({
    super.key,
    this.list,
    required this.onTap,
    required this.onTextChange,
  });

  @override
  State<LeftNavigationPanel> createState() => _LeftNavigationPanelState();
}

class _LeftNavigationPanelState extends State<LeftNavigationPanel> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 300,
      height: double.infinity,
      color: const Color.fromARGB(255, 230, 230, 230),
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          children: [
            const Padding(
              padding: EdgeInsets.all(10.0),
              child: Text("Home"),
            ),
            TextButton(
                onPressed: () {
                  showDialog<int>(
                      context: context,
                      builder: (context) {
                        return const NewStudentDialog();
                      }).then((value) {
                    if (value != -1 && value != null) widget.onTap(value);
                  });
                },
                child: const Text("Add new Student")),
            const SizedBox(
              height: 10,
            ),
            TextField(
              decoration: const InputDecoration(
                  hintText: "Search", border: OutlineInputBorder()),
              onChanged: widget.onTextChange,
            ),
            Expanded(
              child: widget.list == null
                  ? const Text("Please wait")
                  : ListView.builder(
                      itemCount: widget.list!.length,
                      itemBuilder: (context, index) {
                        return ListTile(
                          onTap: () {
                            widget.onTap(widget.list![index]['id']);
                          },
                          leading: Image.asset(
                            'images/person.png',
                            height: 20,
                            width: 20,
                          ),
                          title: Text(
                              "${widget.list![index]['firstName']} ${widget.list![index]['lastName']}"),
                          subtitle:
                              Text("Roll No ${widget.list![index]['rollno']}"),
                        );
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }
}