import 'package:flutter/material.dart';
import 'package:registrationhelper/client.dart';
import 'package:registrationhelper/newStudentDialog.dart';
import 'package:registrationhelper/utils.dart';

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
  int photoCount = 0;
  int bioCount = 0;

  @override
  void initState() {
    super.initState();
    addOnCompleteOne((rollno, status) {
      print('called addOnCompleteOne');

      // Iterate over widget.list to find and update photoStatus
      int length = widget.list!.length;
      for (int i = 0; i < length; i++) {
        print(widget.list![i]['rollno'].runtimeType);
        if (widget.list![i]['rollno'] == rollno) {
          print('matchfound');
          setState(() {
            widget.list![i]['photoStatus'] = true;
          });
          return;
        }
      }
    });
    _reloadCount();
  }

  _reloadCount() {
    DioHelper.getStatusCount((pc, bc, error) {
      setState(() {
        photoCount = pc;
        bioCount = bc;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: double.infinity,
      color: const Color(0xAAF9F9F9),
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          children: [
            Text("Photo Count $photoCount"),
            Text("Biometric Count $bioCount"),
            const SizedBox(
              height: 10,
            ),
            TextField(
              decoration: const InputDecoration(
                  hintText: "Search", border: OutlineInputBorder()),
              onChanged: (text) {
                _reloadCount();
                widget.onTextChange(text);
              },
            ),
            Expanded(
              child: widget.list == null
                  ? const Text("Please wait")
                  : ListView.builder(
                      itemCount: widget.list!.length,
                      itemBuilder: (context, index) {
                        return ListTile(
                          onTap: () {
                            _reloadCount();
                            widget.onTap(widget.list![index]['rollno']);
                          },
                          leading: Image.asset(
                            'images/person.png',
                            height: 20,
                            width: 20,
                          ),
                          title: Text("${widget.list![index]['name']}"),
                          subtitle:
                              Text("Roll No ${widget.list![index]['rollno']}"),
                          trailing: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              widget.list![index]['photoStatus']
                                  ? const Icon(
                                      Icons.circle,
                                      color: Colors.green,
                                      size: 10,
                                    )
                                  : const SizedBox(height: 10),
                              const SizedBox(
                                height: 10,
                              ),
                              widget.list![index]['biometricStatus']
                                  ? const Icon(
                                      Icons.circle,
                                      color: Colors.blue,
                                      size: 10,
                                    )
                                  : const SizedBox(height: 10),
                            ],
                          ),
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
