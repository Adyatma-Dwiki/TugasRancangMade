import 'package:flutter/material.dart';

class SwitchState with ChangeNotifier {
  bool allDevices1On = false;
  bool allDevices2On = false;
  bool allDevices3On = false;
  bool allDevices4On = false;

  void setSwitchValue(int index, bool value) {
    if (index == 0) {
      allDevices1On = value;
    } else if (index == 1) {
      allDevices2On = value;
    } else if (index == 2) {
      allDevices3On = value;
    } else {
      allDevices4On = value;
    }
    notifyListeners();
  }
}