import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class PositiveIntegerField extends StatelessWidget {
  final String hintText;
  final TextEditingController textEditingController;

  PositiveIntegerField({
    required this.hintText,
    required this.textEditingController,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: TextField(
        controller: textEditingController,
        keyboardType: TextInputType.number,
        inputFormatters: <TextInputFormatter>[
          FilteringTextInputFormatter.digitsOnly,
        ],
        decoration: InputDecoration(
          hintText: hintText,
          border: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(5)),
          ),
        ),
        onChanged: (value) {
          if (value.isNotEmpty) {
            int number = int.parse(value);
            if (number < 0) {
              textEditingController.text = '';
            }
          }
        },
      ),
    );
  }
}
