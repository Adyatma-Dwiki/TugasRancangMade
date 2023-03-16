// File generated by FlutterFire CLI.
// ignore_for_file: lines_longer_than_80_chars, avoid_classes_with_only_static_members
import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;

/// Default [FirebaseOptions] for use with your Firebase apps.
///
/// Example:
/// ```dart
/// import 'firebase_options.dart';
/// // ...
/// await Firebase.initializeApp(
///   options: DefaultFirebaseOptions.currentPlatform,
/// );
/// ```
class DefaultFirebaseOptions {
  static FirebaseOptions get currentPlatform {
    if (kIsWeb) {
      return web;
    }
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return android;
      case TargetPlatform.iOS:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for ios - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      case TargetPlatform.macOS:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for macos - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      case TargetPlatform.windows:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for windows - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      case TargetPlatform.linux:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for linux - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      default:
        throw UnsupportedError(
          'DefaultFirebaseOptions are not supported for this platform.',
        );
    }
  }

  static const FirebaseOptions web = FirebaseOptions(
    apiKey: 'AIzaSyB4vX_3tVaH_Jo6i2TArVNVC3xJUbpVE48',
    appId: '1:658632820153:web:603328674a0ac8c4a36268',
    messagingSenderId: '658632820153',
    projectId: 'flutterdemoapp-5b9c9',
    authDomain: 'flutterdemoapp-5b9c9.firebaseapp.com',
    databaseURL: 'https://flutterdemoapp-5b9c9-default-rtdb.asia-southeast1.firebasedatabase.app',
    storageBucket: 'flutterdemoapp-5b9c9.appspot.com',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyCdhp668BwAYNHbn8zHmWz2VqEzvL94Lgk',
    appId: '1:658632820153:android:510707e533acd0a0a36268',
    messagingSenderId: '658632820153',
    projectId: 'flutterdemoapp-5b9c9',
    databaseURL: 'https://flutterdemoapp-5b9c9-default-rtdb.asia-southeast1.firebasedatabase.app',
    storageBucket: 'flutterdemoapp-5b9c9.appspot.com',
  );
}
