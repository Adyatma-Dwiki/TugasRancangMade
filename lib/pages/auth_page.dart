// ignore_for_file: use_key_in_widget_constructors, prefer_const_constructors, unused_import

import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'home_page.dart';
import 'login_or_register.dart';
import 'login_page.dart';

class AuthPage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: ((context, snapshot) {
          if(snapshot.hasData){
            return HomePage();
          }else
          {
            return LoginOrRegisterPage();
          }
        }),),
    );
  }
}