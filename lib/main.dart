import 'package:flutter/material.dart';
import 'package:registrationhelper/client.dart';
import 'package:registrationhelper/profile.dart';

void main() {
  runApp(const MaterialApp(
    home: Home(),
  ));
}

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {

  @override
  void initState() {
    super.initState();
    DioHelper.prepareJar();
    DioHelper.getListOfStudents((data,error){
      print('test');
      print(data);
    });

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Registrations 2024"),centerTitle: true,elevation: 2,),
      body: Row(
  children: [
    Flexible( // Wrap the left side with Flexible
      flex: 1, // Adjust flex value as needed
      child: Container(
        color: const Color.fromARGB(255, 230, 230, 230),
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            children: [
              const Padding(
                padding: EdgeInsets.all(10.0),
                child: Text("Home"),
              ),
              const TextField(
                decoration: InputDecoration(
                  hintText: "Search",
                  border: OutlineInputBorder()
                ),
              ),
              Expanded(
                child: ListView.builder(
                  itemCount: 20,
                  itemBuilder: (context, index) {
                    return ListTile(
                      leading: Image.asset('images/person.png',height: 20,width: 20,),
                      title: const Text("First Last Name"),
                      subtitle: Text("Roll No 2401$index"),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    ),
     Flexible( // Allow DefaultTabController to take remaining space
      flex: 3, // Adjust flex value as needed
      child: DefaultTabController(
        length: 3,
        child: Column( // Wrap TabBar and TabBarView in a Column
          children: [
            const TabBar(
              tabs: [
                Tab(icon: Icon(Icons.person), text: "Info"),
                Tab(icon: Icon(Icons.image), text: "Picture"),
                Tab(icon: Icon(Icons.history), text: "Changelog",),
              ],
            ),
            Expanded( // Use Expanded to let TabBarView fill available space
              child: TabBarView(
                children: [
                  // Your content for each tab goes here
                  Expanded(child: Profile()),
                  Center(child: Text("Picture")),
                  Center(child: Text("Changelog")),
                ],
              ),
            ),
          ],
        ),
      ),
    ),
  ],
),
    );
    
  }
}
