// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, import_of_legacy_library_into_null_safe

import 'package:flutter/material.dart';
import 'package:lapapp/home.dart';
import 'package:splashscreen/splashscreen.dart';

class Splashed extends StatelessWidget {
  const Splashed({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SplashScreen(
      seconds: 6,
      navigateAfterSeconds:
          Directionality(textDirection: TextDirection.rtl, child: HomePage()),
      title: Text(
        'Home Lab Group',
        textScaleFactor: 2,
      ),
      image: Image.asset("images/logo.png"),
      loadingText: Text("تحميل ..."),
      photoSize: 100.0,
      loaderColor: Colors.blue,
    );
  }
}
