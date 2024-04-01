import 'package:chat_app/screens/auth.dart';
import 'package:flutter/material.dart';

import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Chat Chat',
        theme: ThemeData().copyWith(
            colorScheme: ColorScheme.fromSeed(
                seedColor: const Color.fromARGB(225, 63, 17, 117))),
        home: const AuthScreen());
  }
}
