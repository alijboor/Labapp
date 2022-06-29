// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, avoid_print, deprecated_member_use, use_key_in_widget_constructors, camel_case_types, unused_local_variable
import 'package:flutter/material.dart';
import 'package:wakelock/wakelock.dart';
import 'package:firebase_core/firebase_core.dart';

// pages
import 'package:lapapp/splahs.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Wakelock.enable();
  await Firebase.initializeApp();
  runApp(LappApp());
}

class LappApp extends StatelessWidget {
  const LappApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Splashed(),
    );
  }
}
