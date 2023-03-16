// ignore_for_file: prefer_const_constructors, use_key_in_widget_constructors, sort_child_properties_last, avoid_print, prefer_const_literals_to_create_immutables, empty_constructor_bodies

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:tugasrancang/components/my_button.dart';
import 'package:tugasrancang/components/my_textfield.dart';

class LoginPage extends StatefulWidget {
  final Function()? onTap;
  const LoginPage({super.key, required this.onTap});

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
        password: passwordcontroller.text);
      Navigator.pop(context);
    }on FirebaseAuthException catch(e){
      Navigator.pop(context);
      showErorMesaage(e.code);
    }
  
  }

  void showErorMesaage(String message){
    showDialog(
    context: context, 
    builder: (context){
      return  AlertDialog(
        backgroundColor: Colors.deepOrange,
        title: Center(
          child:Text(message, style: TextStyle(color: Colors.white)) ,));
    }
    );   
  }

  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color(0xFFDCCBA9),
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
                color: Color.fromARGB(255, 246, 230, 230),
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
              const SizedBox(height: 50),

              //login button
              MyButton(
                onTap: () {
                  signUserIn();
                }, text: 'Sign In',  
                ),
                
              const SizedBox(height: 80),
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
