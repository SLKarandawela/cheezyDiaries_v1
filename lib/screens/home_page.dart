import 'package:cheezy_diaries/widgets/cardNav.dart';
import 'package:flutter/material.dart';

import '../widgets/header.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      body: SafeArea(
        child: Column(children: [
          ScreenHeader(title: "Home"),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Container(
              height: 500,
              child: Padding(
                padding: const EdgeInsets.only(top: 100),
                child: Dashboard(),
              )),
          )
        ],),
      ),
      

      
    );
  }
}
