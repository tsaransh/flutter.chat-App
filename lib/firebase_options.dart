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
    apiKey: 'AIzaSyCwwpSCHosuYmIpmUzWgPzDB0TmgpZ1dpw',
    appId: '1:373476148640:web:b90a96408d4ca2173690c5',
    messagingSenderId: '373476148640',
    projectId: 'flutter-chat-app-26cf7',
    authDomain: 'flutter-chat-app-26cf7.firebaseapp.com',
    storageBucket: 'flutter-chat-app-26cf7.appspot.com',
    measurementId: 'G-7YRRBMXQCL',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyCfURwmlgjPbpsYidNmINkxlTFi9XXDuaY',
    appId: '1:373476148640:android:baf80198552b32143690c5',
    messagingSenderId: '373476148640',
    projectId: 'flutter-chat-app-26cf7',
    storageBucket: 'flutter-chat-app-26cf7.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyBAzt3psLfOiLSFJZPpslVuPx6Bb5rRsKg',
    appId: '1:373476148640:ios:c7f733a46da65c873690c5',
    messagingSenderId: '373476148640',
    projectId: 'flutter-chat-app-26cf7',
    storageBucket: 'flutter-chat-app-26cf7.appspot.com',
    iosBundleId: 'com.example.chatApp',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyBAzt3psLfOiLSFJZPpslVuPx6Bb5rRsKg',
    appId: '1:373476148640:ios:1fca340b4d14366d3690c5',
    messagingSenderId: '373476148640',
    projectId: 'flutter-chat-app-26cf7',
    storageBucket: 'flutter-chat-app-26cf7.appspot.com',
    iosBundleId: 'com.example.chatApp.RunnerTests',
  );
}