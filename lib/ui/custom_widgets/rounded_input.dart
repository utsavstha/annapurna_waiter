import 'package:annapurna/constants/colors.dart';
import 'package:annapurna/ui/custom_widgets/input_container.dart';
import 'package:flutter/material.dart';

class RoundedInput extends StatelessWidget {
  RoundedInput(
      {Key? key,
      required this.icon,
      required this.hint,
      required this.controller,
      required this.isPassword})
      : super(key: key);

  final IconData icon;
  final String hint;
  final TextEditingController controller;
  final bool isPassword;

  @override
  Widget build(BuildContext context) {
    return InputContainer(
        child: TextField(
      obscureText: isPassword,
      controller: controller,
      cursorColor: colorVacant,
      decoration: InputDecoration(
          icon: Icon(
            icon,
          ),
          hintText: hint,
          border: InputBorder.none),
    ));
  }
}
