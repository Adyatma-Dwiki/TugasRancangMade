// ignore_for_file: prefer_const_constructors, prefer_interpolation_to_compose_strings

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
   HomePage({super.key});

  final user = FirebaseAuth.instance.currentUser;


  void signUserOut() async {
    await FirebaseAuth.instance.signOut();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFDCCBA9),
      appBar: AppBar(
        actions: [IconButton(onPressed: signUserOut , icon: Icon(Icons.logout))],
        title: Text("Home Page"),
        backgroundColor: Color.fromARGB(255, 147, 137, 118),
      ),
      body:SafeArea(
        child: Center(
          child: Text("Logged in!!",
          style: TextStyle(fontSize: 20),)
        ),
      ),
    );
  }
}