// ignore_for_file: prefer_const_constructors, use_key_in_widget_constructors, sort_child_properties_last, avoid_print, prefer_const_literals_to_create_immutables, empty_constructor_bodies, unused_element

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:tugasrancang/components/my_button.dart';
import 'package:tugasrancang/components/my_textfield.dart';

import 'home_page.dart';
import 'register_page.dart';

class LoginPage extends StatefulWidget {
  final Function()? onTap;
  const LoginPage({Key? key, required this.onTap}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

  final emailController = TextEditingController();

  final passwordcontroller = TextEditingController();

  void signUserIn()async{
    
    showDialog(context: context, 
    builder: (context){
      return const Center(
        child: CircularProgressIndicator());
    }
    );
  
    try{
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: emailController.text, 
        password: passwordcontroller.text)
          .then((result) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => HomePage(),
          ),
        );
      });
    } on FirebaseAuthException catch (e) {
      Navigator.pop(context);
      showErrorMessage(e.code);
    }
  }

  void showErrorMessage(String message){
    showDialog(
    context: context, 
    builder: (context){
      return  AlertDialog(
        backgroundColor: Color.fromARGB(255, 72, 69, 69),
        title: Center(
          child:Text(message, style: TextStyle(color: Colors.white)) ,));
    }
    );   
  }
  void _goToRegisterPage() {
  Navigator.push(
    context,
    MaterialPageRoute(builder: (context) => RegisterPage(onTap: _goToLoginPage)),
  );
}

void _goToLoginPage() {
  Navigator.pop(context);
}

  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color.fromARGB(255, 175, 174, 175),
        body: SafeArea(
            child: Center(
          child: Column(
            // ignore: prefer_const_literals_to_create_immutables
            children: [
              const SizedBox(height: 50),
              //logo
              Icon(
                Icons.home_filled,
                size: 100,
                color: Color.fromARGB(255, 4, 4, 4),
              ),

              //welcomeback
              Text(
                "Smart Home Application",
                style: TextStyle(
                  fontSize: 30,
                  color: Colors.black,
                  fontFamily: 'Inter',
                ),
              ),
              const SizedBox(height: 50),

              //email
              const SizedBox(height: 20),

              MyTextField(
                controller: emailController,
                hintText: "Email",
                obscureText: false,
              ),

              //password
              const SizedBox(height: 20),
              MyTextField(
                controller: passwordcontroller,
                hintText: "Password",
                obscureText: true,
              ),

              const SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  // ignore: prefer_const_literals_to_create_immutables
                  children: [
                    Text("Forgot Your Password?"),
                  ],
                ),
              ),
              const SizedBox(height: 100),

              //login button
              MyButton(
                onTap: () {
                  signUserIn();
                }, text: 'Sign In',  
                ),
                
              const SizedBox(height: 85),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Never create account?',
                  style: TextStyle(color: Colors.grey[700],),
                  ),
                  const SizedBox(width: 10),
                  GestureDetector(
                    onTap: widget.onTap,
                    child: const Text('Sign Up',
                    style: TextStyle(color: Colors.blue,
                       fontWeight: FontWeight.bold ),),
                  )
                ],
              ),
            ],
        ))));
  }
}
