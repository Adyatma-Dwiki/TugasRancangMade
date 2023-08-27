// ignore_for_file: prefer_const_constructors, duplicate_import

import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tugasrancang/pages/forget_pass.dart';
import 'package:tugasrancang/pages/login_page.dart';

import 'home_page.dart';
import 'room_page.dart';

class LogOutPage extends StatefulWidget {
  const LogOutPage({super.key});

  @override
  State<LogOutPage> createState() => _LogOutPageState();
}

class _LogOutPageState extends State<LogOutPage> {
  late User? user;
  String displayName = 'Unknown User';
  final double horizontalPadding = 40;
  final double verticalPadding = 25;
  final databaseRef = FirebaseDatabase.instance.reference();

  @override
  void initState() {
    super.initState();
    user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      displayName = user!.displayName ?? 'Unknown User';
    }
  }

  Future<void> signUserOut() async {
    await FirebaseAuth.instance.signOut();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color(0xFFAFAEAF),
        body: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 20),
              Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: horizontalPadding,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Icon(Icons.home),
                          SizedBox(width: 8), // Adjust the width as needed
                          Text(
                            displayName,
                            style: GoogleFonts.poppins(
                              fontSize: 20,
                            ),
                          ),
                        ],
                      ),
                    ],
                  )),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
                child: Divider(
                  color: Colors.black,
                  thickness: 1,
                ),
              ),
              const SizedBox(height: 20),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
                child: Row(
                  children: [
                    IconButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => ForgetPassword()),
                        );
                      },
                      icon: Icon(Icons.key),
                      iconSize: 45,
                    ),
                    SizedBox(
                        width:
                            8), // Adjust the width as needed for spacing between the icon and text
                    Text(
                      'Change Password',
                      style: GoogleFonts.poppins(
                        fontSize: 20,
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
                child: Row(
                  children: [
                    IconButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => LoginPage(
                              onTap: () {
                                Navigator.pop(context);
                              },
                            ),
                          ),
                        );
                        // Add log out logic here
                      },
                      icon: Icon(Icons.logout),
                      iconSize: 45,
                    ),
                    SizedBox(
                        width:
                            8), // Adjust the width as needed for spacing between the icon and text
                    Text(
                      'Log Out',
                      style: GoogleFonts.poppins(
                        fontSize: 20,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        bottomNavigationBar: BottomAppBar(
          child: Row(
    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
    children: [
      Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => HomePage()),
              );
            },
            icon: Icon(Icons.home),
          ),
          Text(
            'Home'
          ),
        ],
      ),
              Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(
                      onPressed: () {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) => Alldevices()));
                      },
                      icon: Icon(Icons.devices)),
                      Text("All Devices")
                ],
              ),
              Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(
                      onPressed: () {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) => LogOutPage()));
                      },
                      icon: Icon(Icons.settings)),
                      Text("Settings")
                ],
              ),
            ],
          ),
      )
    );
  }
}
