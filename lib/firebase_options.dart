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
        return ios;
      case TargetPlatform.macOS:
        return macos;
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
    apiKey: 'AIzaSyAcUYJWFGa3cKDRLgFQbW32g8kJUiUjeL0',
    appId: '1:565667019164:web:3c29ef0f34814fdf16b059',
    messagingSenderId: '565667019164',
    projectId: 'time-capsule-b9ad2',
    authDomain: 'time-capsule-b9ad2.firebaseapp.com',
    storageBucket: 'time-capsule-b9ad2.appspot.com',
    measurementId: 'G-P8S20ZPNYY',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyCTXf23_8W1eINZXe_UEQFBQm9rfWkUa0o',
    appId: '1:565667019164:android:92d314ffa658de0316b059',
    messagingSenderId: '565667019164',
    projectId: 'time-capsule-b9ad2',
    storageBucket: 'time-capsule-b9ad2.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyCkYJzf09xcdn1yZMX968sl91VKGwE8B5Y',
    appId: '1:565667019164:ios:b78785835b506b6416b059',
    messagingSenderId: '565667019164',
    projectId: 'time-capsule-b9ad2',
    storageBucket: 'time-capsule-b9ad2.appspot.com',
    iosClientId: '565667019164-g9b4q79e3strhh0o37tk396rcsjf78p5.apps.googleusercontent.com',
    iosBundleId: 'com.example.timeCapsuleFlutter',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyCkYJzf09xcdn1yZMX968sl91VKGwE8B5Y',
    appId: '1:565667019164:ios:b78785835b506b6416b059',
    messagingSenderId: '565667019164',
    projectId: 'time-capsule-b9ad2',
    storageBucket: 'time-capsule-b9ad2.appspot.com',
    iosClientId: '565667019164-g9b4q79e3strhh0o37tk396rcsjf78p5.apps.googleusercontent.com',
    iosBundleId: 'com.example.timeCapsuleFlutter',
  );
}
