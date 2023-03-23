import 'package:flutter/material.dart';

class BottomNavBar extends StatefulWidget {
  final int currentIndex;
  final Function(int) onTap;

  BottomNavBar({required this.currentIndex, required this.onTap});

  @override
  _BottomNavBarState createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: widget.currentIndex,
      onTap: widget.onTap,
      selectedItemColor: Colors.blue,
      items: [
        BottomNavigationBarItem(
          icon: Icon(Icons.home),
          label: 'Home',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.search),
          label: 'Food',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.notifications),
          label: 'Workout',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.person),
          label: 'Places',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.settings),
          label: 'Journal',
        ),
      ],
    );
  }
}
