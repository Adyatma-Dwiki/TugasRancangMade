// ignore_for_file: prefer_const_constructors, avoid_print

import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:tugasrancang/components/my_button.dart';

class ForgetPassword extends StatefulWidget {
  const ForgetPassword({Key? key});

  @override
  State<ForgetPassword> createState() => _ForgetPasswordState();
}

class _ForgetPasswordState extends State<ForgetPassword> {
  TextEditingController _emailController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }



  void sendEmailMessage(BuildContext context, String email) {
    FirebaseAuth.instance
        .sendPasswordResetEmail(email: email)
        .then((_) {
      // Password reset email sent successfully
      print('Password reset email sent to $email');
      // Show the email verification dialog here
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Email Verification'),
            content: Text('An email verification link has been sent to $email.'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                  Navigator.of(context).pop(); // Navigates back to the login page
                },
                child: Text('OK'),
              ),
            ],
          );
        },
      );
    }).catchError((error) {
      // Error occurred while sending the password reset email
      print('Error sending password reset email: $error');
      // Handle the error accordingly (e.g., show an error message to the user)
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFAFAEAF),
      appBar: AppBar(
        backgroundColor: Color(0xFFAFAEAF),
        elevation: 0,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(Icons.arrow_back_ios_new),
          color: Colors.black,
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Forget Password",
              style: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 40),
              child: Text(
                "Enter your email address below to reset your password",
                style: TextStyle(
                  fontSize: 15,
                  color: Colors.grey[700],
                ),
                textAlign: TextAlign.center,
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 40),
              child: TextField(
                controller: _emailController,
                 decoration: InputDecoration(
                enabledBorder: const OutlineInputBorder(
                  borderSide: BorderSide(color: Color.fromARGB(255, 214, 212, 212)),
                  borderRadius: BorderRadius.all(Radius.circular(10.0)),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Color.fromARGB(255, 199, 197, 197)),
                  borderRadius: BorderRadius.all(Radius.circular(10.0)),
                ),
                fillColor: Color.fromARGB(255, 240, 238, 238),
                filled: true,
                hintText: "Email",
                 )
              ),
            ),
            SizedBox(
              height: 40,
            ),
            MyButton(
              onTap: () {
                String email = _emailController.text;
                sendEmailMessage(context, email);
              },
              text: "Send Request",
            ),
          ],
        ),
      ),
    );
  }
}
