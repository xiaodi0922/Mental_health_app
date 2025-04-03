import 'package:flutter/material.dart';

class MyTextField extends StatelessWidget {
  final dynamic controller;
  final String hintText;
  final IconData icon;
  final bool obscureText;

  const MyTextField({
    super.key,
    required this.controller,
    required this.hintText,
    required this.icon,
    required this.obscureText,

  });

  @override
  Widget build(BuildContext context) {
    const border1 = OutlineInputBorder(
        borderSide:  BorderSide(
          width: 2,
          color: Colors.blue,
        ),
        borderRadius: BorderRadius.horizontal(
          right: Radius.circular(10),
          left: Radius.circular(10),
        )
    );
    const border2 = OutlineInputBorder(
        borderSide: BorderSide(
          width: 3,
          color: Colors.black,
        ),
        borderRadius: BorderRadius.horizontal(
          right: Radius.circular(10),
          left: Radius.circular(10),
        )
    );
    return  Padding(
      padding: EdgeInsets.symmetric(horizontal: 25.0),
      child: TextField(
        controller: controller,
        obscureText: obscureText,
        decoration: InputDecoration(
          prefixIcon: Icon(icon),
          border: border1,
          enabledBorder: border1,
          focusedBorder: border2,
          hintText: hintText,

          contentPadding: EdgeInsets.all(20.0),
        ),
      ),
    );
  }
}
