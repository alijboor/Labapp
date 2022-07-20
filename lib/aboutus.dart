// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

class AboutUs extends StatelessWidget {
  const AboutUs({Key? key, required this.content}) : super(key: key);
  final String content;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Center(
        child: Text(
          'من نحن؟',
        ),
      )),
      body: Center(child: Text(content)),
    );
  }
}
