// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

class ResultOfAnalysis extends StatelessWidget {
  const ResultOfAnalysis({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: const Center(
        child: Text(
          'نتائج التحليل',
        ),
      )),
      body: Center(child: Text("صفحة نتائج التحليل ")),
    );
  }
}
