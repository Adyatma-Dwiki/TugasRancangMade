// ignore_for_file: prefer_const_constructors, prefer_interpolation_to_compose_strings, unused_import, deprecated_member_use, prefer_const_constructors_in_immutables, depend_on_referenced_packages, unused_element, duplicate_import, unused_local_variable

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:provider/provider.dart';
import 'package:tugasrancang/pages/room_page.dart';
import 'package:tugasrancang/pages/settings_page.dart';
import '../components/cupertino.dart';
import '../firebase_options.dart';
import '../main.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  HomePage({super.key});
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late User? user;
  String displayName = 'Unknown User';

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

  final double horizontalPadding = 40;
  final double verticalPadding = 25;
  final dbR = FirebaseDatabase.instance.reference();
  final databaseRef = FirebaseDatabase.instance.reference();
  bool lampuRuangan1 = false;
  bool pintuRuangan1 = false;
  bool allDevices1On = false;
  bool lampuRuangan2 = false;
  bool pintuRuangan2 = false;
  bool allDevices2On = false;
  bool lampuRuangan3 = false;
  bool pintuRuangan3 = false;
  bool allDevices3On = false;
  bool lampuRuangan4 = false;
  bool pintuRuangan4 = false;
  bool allDevices4On = false;
  double temperature = 0.0;
  double humidity = 0.0;

  Stream<DataSnapshot> getDataSnapshotStream(DatabaseReference reference) {
    return reference.onValue.map((event) => event.snapshot);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color.fromARGB(255, 175, 174, 175),
        body: RefreshIndicator(
          onRefresh: () async {
            _getTemperatureAndHumidity();
          },
          child: SafeArea(
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
                            style: TextStyle(
                                fontSize: 20, color: Colors.grey[1000])),
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
                    )),
                const SizedBox(height: 25),
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
                  child: Text("Smart Room",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 24,
                        color: Colors.grey[800],
                      )),
                ),
                const SizedBox(height: 10),
                // Inside your Widget build method:

                Expanded(
                  child: ListView.builder(
                      itemCount: 4,
                      itemBuilder: (context, index) {
                        return StreamBuilder<DataSnapshot>(
                          stream: getDataSnapshotStream(dbR
                              .child('All Devices/Ruangan ${index + 1}/Light')),
                          builder: (context, snapshot) {
                            bool lampuRuangan = snapshot.hasData &&
                                snapshot.data!.value == true;

                            return Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: horizontalPadding, vertical: 5.0),
                              child: Card(
                                elevation: 2.0,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20.0),
                                ),
                                color: index == 0
                                    ? allDevices1On
                                        ? Colors.black
                                        : Color.fromARGB(255, 205, 204, 204)
                                    : index == 1
                                        ? allDevices2On
                                            ? Colors.black
                                            : Color.fromARGB(255, 205, 204, 204)
                                        : index == 2
                                            ? allDevices3On
                                                ? Colors.black
                                                : Color.fromARGB(
                                                    255, 205, 204, 204)
                                            : allDevices4On
                                                ? Colors.black
                                                : Color.fromARGB(
                                                    255, 205, 204, 204),
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 40.0, vertical: 10.0),
                                  child: Column(
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            index == 0
                                                ? "Ruangan 1"
                                                : index == 1
                                                    ? "Ruangan 2"
                                                    : index == 2
                                                        ? "Ruangan 3"
                                                        : "Ruangan 4",
                                            style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 20,
                                              color: index == 0
                                                  ? allDevices1On
                                                      ? Colors.white
                                                      : Colors.grey[800]
                                                  : index == 1
                                                      ? allDevices2On
                                                          ? Colors.white
                                                          : Colors.grey[800]
                                                      : index == 2
                                                          ? allDevices3On
                                                              ? Colors.white
                                                              : Colors.grey[800]
                                                          : allDevices4On
                                                              ? Colors.white
                                                              : Colors
                                                                  .grey[800],
                                            ),
                                          ),
                                          CupertinoSwitch(
                                            value: index == 0
                                                ? allDevices1On
                                                : index == 1
                                                    ? allDevices2On
                                                    : index == 2
                                                        ? allDevices3On
                                                        : allDevices4On,
                                            onChanged: (newValue) {
                                              setState(() {
                                                if (index == 0) {
                                                  allDevices1On = newValue;
                                                  lampuRuangan1 = newValue;
                                                  pintuRuangan1 = newValue;
                                                  dbR.update({
                                                    'All Devices/Ruangan 1/Light':
                                                        lampuRuangan1,
                                                    'All Devices/Ruangan 1/Door':
                                                        pintuRuangan1,
                                                  });
                                                } else if (index == 1) {
                                                  allDevices2On = newValue;
                                                  lampuRuangan2 = newValue;
                                                  pintuRuangan2 = newValue;
                                                  dbR.update({
                                                    'All Devices/Ruangan 2/Light':
                                                        lampuRuangan2,
                                                    'All Devices/Ruangan 2/Door':
                                                        pintuRuangan2,
                                                  });
                                                } else if (index == 2) {
                                                  allDevices3On = newValue;
                                                  lampuRuangan3 = newValue;
                                                  pintuRuangan3 = newValue;
                                                  dbR.update({
                                                    'All Devices/Ruangan 3/Light':
                                                        lampuRuangan3,
                                                    'All Devices/Ruangan 3/Door':
                                                        pintuRuangan3,
                                                  });
                                                } else {
                                                  allDevices4On = newValue;
                                                  lampuRuangan4 = newValue;
                                                  pintuRuangan4 = newValue;
                                                  dbR.update({
                                                    'All Devices/Ruangan 4/Light':
                                                        lampuRuangan4,
                                                    'All Devices/Ruangan 4/Door':
                                                        pintuRuangan4,
                                                  });
                                                }
                                              });
                                            },
                                          ),
                                        ],
                                      ),
                                      const SizedBox(height: 10),
                                      StreamBuilder<DataSnapshot>(
                                        stream: getDataSnapshotStream(dbR.child(
                                            'All Devices/Ruangan ${index + 1}/Light')),
                                        builder: (context, snapshot) {
                                          bool lampuRuangan =
                                              snapshot.hasData &&
                                                  snapshot.data!.value == true;

                                          return Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(
                                                "Light",
                                                style: TextStyle(
                                                  fontSize: 16,
                                                  color: lampuRuangan
                                                      ? (allDevices1On
                                                          ? Colors.white
                                                          : Colors.grey[800])
                                                      : Colors.grey[800],
                                                ),
                                              ),
                                              CupertinoSwitch(
                                                value: lampuRuangan,
                                                onChanged: (newValue) {
                                                  dbR
                                                      .child(
                                                          'All Devices/Ruangan ${index + 1}/Light')
                                                      .set(newValue);
                                                },
                                              ),
                                            ],
                                          );
                                        },
                                      ),
                                      const SizedBox(height: 10),
                                      StreamBuilder<DataSnapshot>(
                                        stream: getDataSnapshotStream(dbR.child(
                                            'All Devices/Ruangan ${index + 1}/Door')),
                                        builder: (context, snapshot) {
                                          bool doorLock = snapshot.hasData &&
                                              snapshot.data!.value == true;

                                          return Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(
                                                "Door Lock",
                                                style: TextStyle(
                                                  fontSize: 16,
                                                  color: doorLock
                                                      ? (allDevices1On
                                                          ? Colors.white
                                                          : Colors.grey[800])
                                                      : Colors.grey[800],
                                                ),
                                              ),
                                              CupertinoSwitch(
                                                value: doorLock,
                                                onChanged: (newValue) {
                                                  dbR
                                                      .child(
                                                          'All Devices/Ruangan ${index + 1}/Door')
                                                      .set(newValue);
                                                },
                                              ),
                                            ],
                                          );
                                        },
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            );
                          },
                        );
                      }),
                ),
              ],
            ),
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
                  Text('Home'),
                ],
              ),
              Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => Alldevices()));
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
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => LogOutPage()));
                      },
                      icon: Icon(Icons.settings)),
                  Text("Settings")
                ],
              ),
            ],
          ),
        ));
  }
}
