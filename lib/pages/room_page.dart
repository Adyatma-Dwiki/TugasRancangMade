// ignore_for_file: deprecated_member_use, prefer_const_declarations, prefer_const_constructors, unused_local_variable

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tugasrancang/pages/settings_page.dart';

import '../components/all_devices_box.dart';
import 'home_page.dart';

class Alldevices extends StatefulWidget {
  const Alldevices({Key? key}) : super(key: key);

  @override
  _AlldevicesState createState() => _AlldevicesState();
}

List mySmartDevices = [
  ["Smart Light", "lib/icons/light-bulb.png", false],
  ["Air Conditioner", "lib/icons/air-conditioner.png", false],
  ["Smart Door", "lib/icons/doorlock.png", false]
];

class _AlldevicesState extends State<Alldevices> {
  late User? user;
  String displayName = 'Unknown User';
  final double horizontalPadding = 40;
  final double verticalPadding = 25;
  double temperature = 0.0;
  double humidity = 0.0;
  final dbR = FirebaseDatabase.instance.reference();
  final databaseRef = FirebaseDatabase.instance.reference();

  @override
  void initState() {
    super.initState();
    _getTemperatureAndHumidity();
    user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      displayName = user!.displayName ?? 'Unknown User';
    }
  }

  Future<void> signUserOut() async {
    await FirebaseAuth.instance.signOut();
  }

  void _getTemperatureAndHumidity() {
    databaseRef.child('temperature').once().then((DatabaseEvent event) {
      double temp = double.parse(event.snapshot.value.toString());
      setState(() {
        temperature = temp;
      });
    });
    databaseRef.child('humidity').once().then((DatabaseEvent event) {
      double humid = double.parse(event.snapshot.value.toString());
      setState(() {
        humidity = humid;
      });
    });
  }

  void powerSwitchChanged(bool value, int index) {
    setState(() {
      mySmartDevices[index][2] = value;
    });

    String smartDeviceName = mySmartDevices[index][0];
    String firebasePath = '';

    switch (smartDeviceName) {
      case 'Smart Light':
        for (int i = 1; i <= 4; i++) {
          firebasePath = 'All Devices/Ruangan $i/Light';
          dbR.child(firebasePath).set(value);
        }
        break;
      case 'Smart Door':
        for (int i = 1; i <= 4; i++) {
          firebasePath = 'All Devices/Ruangan $i/Door';
          dbR.child(firebasePath).set(value);
        }
        break;
      case 'Air Conditioner':
        firebasePath = 'Air Conditioner/Switch';
        break;
      default:
        return;
    }

    dbR.child(firebasePath).set(value);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 175, 174, 175),
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
                  Text("Welcome Home,",
                      style: TextStyle(fontSize: 20, color: Colors.grey[1000])),
                  Text(
                    displayName,
                    style: GoogleFonts.poppins(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    'Temperature: ${temperature.toStringAsFixed(2)}°C\nHumidity: ${humidity.toStringAsFixed(2)}%',
                    style: GoogleFonts.poppins(
                      fontSize: 20,
                      color: Colors.grey[1000],
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
              child: Divider(
                color: Colors.black,
                thickness: 1,
              ),
            ),
            const SizedBox(height: 25),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
              child: Text("All Devices",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 24,
                    color: Colors.grey[800],
                  )),
            ),
            const SizedBox(height: 25),
            Expanded(
              child: GridView.builder(
                itemCount: mySmartDevices.length,
                physics: BouncingScrollPhysics(),
                padding: EdgeInsets.all(25),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 1 / 1.2,
                ),
                itemBuilder: (context, index) {
                  return smartDeviceBox(
                    smartDeviceName: mySmartDevices[index][0],
                    powerOn: mySmartDevices[index][2],
                    iconPath: mySmartDevices[index][1],
                    onChanged: (value) => powerSwitchChanged(value, index),
                  );
                },
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
