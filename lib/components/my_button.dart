// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

class MyButton extends StatelessWidget {
  const MyButton({super.key, required this.onTap, required this.text});

  final Function()? onTap;
  final String text;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.all(25),
        margin: EdgeInsets.symmetric(horizontal: 20),
        decoration: BoxDecoration(
          color: Color.fromARGB(255, 0, 0, 0),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Center(
          child: Text(
            text,
            style: const TextStyle(
            color: Colors.white, 
            fontSize: 20,
            fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
  }
}
