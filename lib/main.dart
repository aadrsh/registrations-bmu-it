import 'package:flutter/material.dart';

void main() {
  runApp(const MaterialApp(
    home: Home(),
  ));
}

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Registrations 2024"),centerTitle: true,elevation: 2,),
      body: Row(
  children: [
    Flexible( // Wrap the left side with Flexible
      flex: 1, // Adjust flex value as needed
      child: Container(
        color: Color.fromARGB(255, 230, 230, 230),
        child: Padding(
          padding: EdgeInsets.all(10),
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.all(10.0),
                child: Text("Home"),
              ),
              TextField(
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
                      title: Text("First Last Name"),
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
            TabBar(
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
                  Center(child: Text("Info")),
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
