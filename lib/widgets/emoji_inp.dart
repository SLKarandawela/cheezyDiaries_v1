import 'package:flutter/material.dart';

class EmojiButtonWidget extends StatefulWidget {
  final IconData iconData1;
  final IconData iconData2;
  final TextEditingController controller;

  const EmojiButtonWidget({
    Key? key,
    required this.iconData1,
    required this.iconData2,
    required this.controller,
  }) : super(key: key);

  @override
  _EmojiButtonWidgetState createState() => _EmojiButtonWidgetState();
}

class _EmojiButtonWidgetState extends State<EmojiButtonWidget> {
  int _selectedIndex = -1;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        IconButton(
          onPressed: () {
            setState(() {
              _selectedIndex = 0;
              widget.controller.text = "1";
            });
          },
          icon: Icon(widget.iconData1),
          color: _selectedIndex == 0 ? Colors.green : Colors.black,
        ),
        IconButton(
          onPressed: () {
            setState(() {
              _selectedIndex = 1;
              widget.controller.text = "2";
            });
          },
          icon: Icon(widget.iconData2),
          color: _selectedIndex == 1 ? Colors.green : Colors.black,
        ),
      ],
    );
  }
}
