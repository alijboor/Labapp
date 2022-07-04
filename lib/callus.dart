// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:contactus/contactus.dart';

class CallUs extends StatelessWidget {
  const CallUs({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.black),
        title: Center(
          child: Text('',
              style: TextStyle(
                color: Colors.black,
                fontSize: 20.0,
              )),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      extendBodyBehindAppBar: true,
      backgroundColor: Colors.teal,
      body: ContactUs(
        cardColor: Colors.white,
        textColor: Colors.teal.shade900,
        logo: AssetImage('images/icon.png'),
        email: 'Itqan@gmail.com',
        companyName: 'شركة اتقان للبرمجة',
        companyColor: Colors.teal.shade100,
        dividerThickness: 2,
        phoneNumber: '+972599969980',
        // website: 'https://abhishekdoshi.godaddysites.com',
        // githubUserName: 'AbhishekDoshi26',
        // linkedinURL:
        //     'https://www.linkedin.com/in/abhishek-doshi-520983199/',
        tagLine: 'لتطوير البرمجيات',
        taglineColor: Colors.teal.shade100,
        // twitterHandle: 'AbhishekDoshi26',
        // instagram: '_abhishek_doshi',
        facebookHandle: 'itqanps',
      ),
      bottomNavigationBar: ContactUsBottomAppBar(
        companyName: 'شركة اتقان للبرمجة',
        textColor: Colors.white,
        backgroundColor: Colors.teal.shade300,
        email: 'Itqan@gmail.com',
      ),
    );
  }
}
