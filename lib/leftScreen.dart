import 'package:flutter/material.dart';
import 'package:registrationhelper/client.dart';
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
  String searchText = "";
  @override
  void initState() {
    super.initState();
    addOnCompleteOne((rollno, status) {
      print('called addOnCompleteOne inside leftScreen.dart');
      // Iterate over widget.list to find and update photoStatus
      int length = widget.list!.length;
      for (int i = 0; i < length; i++) {
        if (widget.list![i]['rollno'] == rollno) {
          print('list tile marked green');
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
              decoration: InputDecoration(
                  suffixIcon: IconButton(
                      onPressed: () {
                        _reloadCount();
                        widget.onTextChange(searchText);
                      },
                      icon: Icon(Icons.search)),
                  hintText: "Search",
                  border: OutlineInputBorder()),
              onChanged: (text) {
                searchText = text;
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
