import 'package:cheezy_diaries/widgets/cardNav.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(items: const [
        BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
        BottomNavigationBarItem(icon: Icon(Icons.restaurant), label: 'Food'),
        BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Me'),
      ]),
      backgroundColor: Colors.grey[100],
      body: SafeArea(
        child: Column(children: [
          Container(
            height: 170,
            decoration: BoxDecoration(color: Colors.blue.shade800),
            child: Row(children: [
              Column(children: const [
                Padding(
                  padding: EdgeInsets.all(20.0),
                  child: Text("Cheezy Diaries", style: TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold) ,),
                ),
              ],)
            ]),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              height: 500,
              child: Dashboard()),
          )
        ],),
      ),

      
    );
  }
}
