import 'package:flutter/material.dart';

import 'navigatingHelper.dart';


class BottomNavWrapper extends StatefulWidget {
  final int initialIndex;
  final List<Widget> pages;

  BottomNavWrapper({required this.initialIndex, required this.pages});

  @override
  _BottomNavWrapperState createState() => _BottomNavWrapperState();
}

class _BottomNavWrapperState extends State<BottomNavWrapper> {
  int _currentIndex = 0;

  @override
  void initState() {
    super.initState();
    _currentIndex = widget.initialIndex;
  }

  void _onTap(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: widget.pages[_currentIndex],
            ),
            BottomNavBar(
              currentIndex: _currentIndex,
              onTap: _onTap,
            ),
          ],
        ),
      ),
    );
  }
}
