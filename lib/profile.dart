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
            Image.asset("/images/person.png",height: 200,width: 200,),
            Column(children: [
              SizedBox(width:200, child: TextFormField(decoration: const InputDecoration(label: Text("Roll No."),hintText: "230XXX",border: OutlineInputBorder()),)),
              const SizedBox(height: 8,),
              SizedBox( width: 300, child: TextFormField(decoration: const InputDecoration(label: Text("First Name"),hintText: "First",border: OutlineInputBorder()),)),
              const SizedBox(height: 8,),
              SizedBox(width:300, child: TextFormField(decoration: const InputDecoration(label: Text("Last Name"),hintText: "Last",border: OutlineInputBorder()),)),
            ],)
          ],
        ),
         const SizedBox(height: 20,),
         SizedBox( child: TextFormField(decoration: const InputDecoration(label: Text("School"),hintText: "Scholl of ET/M/L/LS",border: OutlineInputBorder()),)),
         const SizedBox(height: 20,),
         SizedBox(child: TextFormField(decoration: const InputDecoration(label: Text("Branch"),hintText: "BBA/MBA",border: OutlineInputBorder()),)),
       ],
      )),
    );
  }
}