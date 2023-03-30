import 'package:flutter/material.dart';

class MyTextField extends StatelessWidget {
  final controller;
  final String hintText;
  final bool obscureText;
  final Icon prefixIcon;

  const MyTextField(
      {super.key,
      required this.controller,
      required this.hintText,
      required this.obscureText,
      required this.prefixIcon});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25),
      child: TextField(
        style: TextStyle(color: Colors.white),
        cursorColor: Colors.white,
        controller: controller,
        obscureText: obscureText,
        decoration: InputDecoration(
            prefixIcon: prefixIcon,
            enabledBorder: const OutlineInputBorder(
                borderSide: BorderSide(color: Colors.white60)),
            hintText: hintText,
            hintStyle: TextStyle(color: Colors.white70),
            focusedBorder:
                OutlineInputBorder(borderSide: BorderSide(color: Colors.red))),
      ),
    );
  }
}
