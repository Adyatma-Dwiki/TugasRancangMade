// ignore_for_file: prefer_const_constructors, unused_field, deprecated_member_use, prefer_interpolation_to_compose_strings, camel_case_types

import 'dart:math';

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class smartDeviceBox extends StatelessWidget {
  final String smartDeviceName;
  final bool powerOn;
  final String iconPath;
  void Function(bool)? onChanged;

  smartDeviceBox({
    super.key,
    required this.smartDeviceName,
    required this.powerOn,
    required this.iconPath,
    required this.onChanged
  });

  final double horizontalPadding = 40;

  final double verticalPadding = 25;

  @override
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: Container(
        decoration: BoxDecoration(
          color: powerOn ? Colors.grey[900] : Colors.grey[200],
          borderRadius: BorderRadius.circular(20),
        ),
        padding: EdgeInsets.symmetric(vertical: 25),
        child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Image.asset(
                iconPath,
                height: 65,
                 color: powerOn ? Colors.white : Colors.black,
              ),
              Row(
                children: [
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(left: 25.0),
                      child: Text(smartDeviceName,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                            color: powerOn ? Colors.white : Colors.black,
                          )),
                    ),
                  ),
                  Transform.rotate(
                    angle: pi / 2,
                    child: CupertinoSwitch(
                      value: powerOn,
                      onChanged: onChanged,
                    ),
                  )
                ],
              )
            ]),
      ),
    );
  }
}
