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
    return const Scaffold(
      body: Row(
  children: [
    const Flexible( // Wrap the left side with Flexible
      flex: 1, // Adjust flex value as needed
      child: Column(
        children: [
          Text("Hi"),
          Text("Hi2"),
          Text("Hi3"),
        ],
      ),
    ),
    Flexible( // Allow DefaultTabController to take remaining space
      flex: 2, // Adjust flex value as needed
      child: DefaultTabController(
        length: 3,
        child: Column( // Wrap TabBar and TabBarView in a Column
          children: [
            TabBar(
              tabs: [
                Tab(icon: Icon(Icons.directions_car)),
                Tab(icon: Icon(Icons.directions_transit)),
                Tab(icon: Icon(Icons.directions_bike)),
              ],
            ),
            Expanded( // Use Expanded to let TabBarView fill available space
              child: TabBarView(
                children: [
                  // Your content for each tab goes here
                  Center(child: Text("Car")),
                  Center(child: Text("Transit")),
                  Center(child: Text("Bike")),
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
