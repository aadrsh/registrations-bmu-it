import 'package:flutter/material.dart';

class Profile extends StatefulWidget {
  Profile({Key? key}) : super(key: key);

  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      
padding: const EdgeInsets.all(10.0),
      child: Form(child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
       children: [
        Row(
          children: [
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Image.asset("/images/person.png",height: 200,width: 200,),
            ),
            Expanded(
              child: Column(children: [
                  TextFormField(decoration: const InputDecoration(label: Text("Roll No."),hintText: "240XXX",border: OutlineInputBorder()),),
                  const SizedBox(height: 8,),
                  Row(children: [
                    Expanded(flex:1,child: TextFormField(decoration: const InputDecoration(label: Text("First Name"),hintText: "John",border: OutlineInputBorder()),)),
                    const SizedBox(width: 10,),
                    Expanded(flex:1,child: TextFormField(decoration: const InputDecoration(label: Text("Last Name"),hintText: "Doe",border: OutlineInputBorder()),)),
                    ]
                  ),
                ],
              )
            )
          ],
        ),
         const SizedBox(height: 20,),
         TextFormField(decoration: const InputDecoration(label: Text("School"),hintText: "SOET/SOM/SOL/SOLS",border: OutlineInputBorder()),),
         const SizedBox(height: 20,),
         TextFormField(decoration: const InputDecoration(label: Text("Branch"),hintText: "BBA/MBA",border: OutlineInputBorder()),),
       ],
      )),
    );
  }
}
