// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

class CallUs extends StatelessWidget {
  const CallUs({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Center(
        child: Text(
          'اتصل بنا',
        ),
      )),
      body: Text("صفحة اتصل بنا "),
    );
  }
}
