// ignore_for_file: use_key_in_widget_constructors, unused_import, prefer_typing_uninitialized_variables, non_constant_identifier_names, prefer_const_constructors

import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';
import 'package:tugasrancang/auth/auth_page.dart';
import 'firebase_options.dart';
import 'pages/login_page.dart';
import 'components/cupertino.dart';

void main() async {
   WidgetsBinding? widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding as WidgetsFlutterBinding);
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MyApp());
  FlutterNativeSplash.remove();
}



class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(

      
      debugShowCheckedModeBanner: false,
      home: AuthPage(),

    );
  }
}