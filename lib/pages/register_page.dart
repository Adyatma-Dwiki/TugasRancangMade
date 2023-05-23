// ignore_for_file: prefer_const_constructors, use_key_in_widget_constructors, sort_child_properties_last, avoid_print, prefer_const_literals_to_create_immutables, empty_constructor_bodies, deprecated_member_use

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:tugasrancang/components/my_button.dart';
import 'package:tugasrancang/components/my_textfield.dart';
import 'package:tugasrancang/pages/login_page.dart';

class RegisterPage extends StatefulWidget {
  final Function() onTap;
  const RegisterPage({Key? key, required this.onTap}) : super(key: key);

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final usernameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordcontroller = TextEditingController();
  final confirmPassController = TextEditingController();

  void signUserUp() async {
    showDialog(
      context: context,
      builder: (context) {
        return const Center(child: CircularProgressIndicator());
      },
    );

    try {
      //check if password is confirmed
      if (passwordcontroller.text == confirmPassController.text) {
        await FirebaseAuth.instance
            .createUserWithEmailAndPassword(
          email: emailController.text,
          password: passwordcontroller.text,
        )
            .then((result) {
          // set user display name to username
          result.user?.updateProfile(displayName: usernameController.text);
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => LoginPage(onTap: widget.onTap),
            ),
          );
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text("Account created!"),
            ),
          );
        });
      } else {
        showErrorMessage("Passwords don't match");
      }
    } on FirebaseAuthException catch (e) {
      Navigator.pop(context);
      showErrorMessage(e.code);
    }
  }

  void showErrorMessage(String message) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: Colors.deepOrange,
          title: Center(
            child: Text(
              message,
              style: const TextStyle(color: Colors.white),
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return ScaffoldMessenger(
        child: Scaffold(
            backgroundColor: Color.fromARGB(255, 175, 174, 175),
            body: SafeArea(child: LayoutBuilder(
                builder: (BuildContext context, BoxConstraints constraints) {
              return SingleChildScrollView(
                child: ConstrainedBox(
                  constraints: BoxConstraints(
                    minHeight: constraints.maxHeight,
                  ),
                  child: IntrinsicHeight(
                    child: Center(
                      child: Column(
                        children: [
                          const SizedBox(height: 50),
                          //logo
                          Icon(
                            Icons.home_filled,
                            size: 100,
                            color: const Color.fromARGB(255, 0, 0, 0),
                          ),
                          const SizedBox(height: 3),
                          Text(
                            'Smart Home Application',
                            style: const TextStyle(
                              fontSize: 30,
                              color: Colors.black,
                              fontFamily: 'Inter',
                            ),
                          ),
                          const SizedBox(height: 20),
                          //email
                          const SizedBox(height: 20),
                          MyTextField(
                            controller: usernameController,
                            hintText: 'Username',
                            obscureText: false,
                          ),
                          const SizedBox(height: 20),
                          MyTextField(
                            controller: emailController,
                            hintText: 'Email',
                            obscureText: false,
                          ),
                          //password
                          const SizedBox(height: 20),
                          MyTextField(
                            controller: passwordcontroller,
                            hintText: 'Password',
                            obscureText: true,
                          ),
                          const SizedBox(height: 20),
                          MyTextField(
                            controller: confirmPassController,
                            hintText: 'Confirm Password',
                            obscureText: true,
                          ),
                          const SizedBox(height: 50),
                          //login button
                          MyButton(
                            onTap: signUserUp,
                            text: 'Sign Up',
                          ),
                          const SizedBox(height: 100),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Text(
                                'Already have an account?',
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 16,
                                ),
                              ),
                              TextButton(
                                onPressed: widget.onTap,
                                child: const Text(
                                  'Log In',
                                  style: TextStyle(
                                    color: Colors.blue,
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              )
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              );
            }),
    ),
    ),
    );
  }
}
