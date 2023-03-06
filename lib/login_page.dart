// ignore_for_file: prefer_const_constructors, use_key_in_widget_constructors, sort_child_properties_last

import 'package:flutter/material.dart';
import 'package:tugasrancang/components/my_textfield.dart';

class LoginPage extends StatelessWidget {
  final usernameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordcontroller = TextEditingController();
  final ipaddresscontroller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color.fromARGB(200, 212, 199, 173),
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

              //username
              MyTextField(
                controller: usernameController,
                hintText: "Username",
                obscureText: false,
              ),

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

              //ipaddress
              const SizedBox(height: 20),
              MyTextField(
                controller: ipaddresscontroller,
                hintText: "IP Address",
                obscureText: false,
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
              const SizedBox(height: 20),
             Row(
              mainAxisAlignment: MainAxisAlignment.center,
               children: [
                 TextButton(
                  onPressed: (){}, 
                  child: Text("Login", style: TextStyle(color: Colors.white),),
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all<Color>(Colors.black),
                    padding: MaterialStateProperty.all<EdgeInsets>(EdgeInsets.symmetric(horizontal: 100, vertical: 20)),
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(18.0),
                        side: BorderSide(color: Colors.black)
                      )
                    )
                  ),
                ),
                
               ],
             ),
              const SizedBox(height: 40),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                // ignore: prefer_const_literals_to_create_immutables
                children: [
                  Text("Don't have an account?"),
                  TextButton(
                    onPressed: () {},
                    child: Text("Register Now"),
                  ),
                ],
              ),
            ],
        ))));
  }
}
