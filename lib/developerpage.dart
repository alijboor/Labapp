// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, sized_box_for_whitespace, avoid_unnecessary_containers

import 'package:flutter/material.dart';

class DeveloperPage extends StatefulWidget {
  const DeveloperPage({Key? key}) : super(key: key);

  @override
  State<DeveloperPage> createState() => _DeveloperPageState();
}

class _DeveloperPageState extends State<DeveloperPage> {
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
      body: Directionality(
        textDirection: TextDirection.rtl,
        child: Stack(
          children: [
            Column(
              children: [
                Expanded(
                  flex: 5,
                  child: Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage("images/itqan.png"),
                        fit: BoxFit.cover,
                      ),
                      gradient: LinearGradient(
                        colors: [
                          Color.fromARGB(255, 69, 39, 160),
                          Colors.deepPurpleAccent
                        ],
                      ),
                    ),
                    child: Column(children: [
                      SizedBox(
                        height: 110.0,
                      ),
                      CircleAvatar(
                        radius: 65.0,
                        backgroundImage: AssetImage('images/icon.png'),
                        backgroundColor: Colors.white,
                      ),
                      SizedBox(
                        height: 18.0,
                      ),
                      Text(' ',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 20.0,
                          )),
                      Text('شركة اتقان',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 20.0,
                          )),
                      SizedBox(
                        height: 10.0,
                      ),
                      Text(
                        'لتطوير ما يلزمك',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 15.0,
                        ),
                      )
                    ]),
                  ),
                ),
                Expanded(
                  flex: 5,
                  child: Container(
                    color: Colors.grey[200],
                    child: Center(
                        child: Card(
                            margin: EdgeInsets.fromLTRB(0.0, 45.0, 0.0, 0.0),
                            child: Container(
                                width: 360.0,
                                height: 270.0,
                                child: Padding(
                                  padding: EdgeInsets.all(10.0),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "معلومات",
                                        style: TextStyle(
                                          fontSize: 17.0,
                                          fontWeight: FontWeight.w800,
                                        ),
                                      ),
                                      Divider(
                                        color: Colors.grey[300],
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          Icon(
                                            Icons.home,
                                            color: Colors.blueAccent[400],
                                            size: 35,
                                          ),
                                          SizedBox(
                                            width: 20.0,
                                          ),
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                "عنواننا",
                                                style: TextStyle(
                                                  fontSize: 15.0,
                                                ),
                                              ),
                                              Text(
                                                "الخليل - مجمع بدر - الطابق الثاني",
                                                style: TextStyle(
                                                  fontSize: 12.0,
                                                  color: Colors.grey[400],
                                                ),
                                              )
                                            ],
                                          )
                                        ],
                                      ),
                                      SizedBox(
                                        height: 25.0,
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          Icon(
                                            Icons.auto_awesome,
                                            color: Colors.yellowAccent[400],
                                            size: 35,
                                          ),
                                          SizedBox(
                                            width: 20.0,
                                          ),
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                "ماذا نقدم؟",
                                                style: TextStyle(
                                                  fontSize: 15.0,
                                                ),
                                              ),
                                              Text(
                                                "نقدم خدمات برمجية حسب طلبك و تلبي جميع رغباتك.",
                                                style: TextStyle(
                                                  fontSize: 12.0,
                                                  color: Colors.grey[400],
                                                ),
                                              )
                                            ],
                                          )
                                        ],
                                      ),
                                      SizedBox(
                                        height: 20.0,
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          Icon(
                                            Icons.people,
                                            color: Colors.lightGreen[400],
                                            size: 35,
                                          ),
                                          SizedBox(
                                            width: 20.0,
                                          ),
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                "بإدارة:",
                                                style: TextStyle(
                                                  fontSize: 15.0,
                                                ),
                                              ),
                                              Text(
                                                "م. مـأمون ادعيـس",
                                                style: TextStyle(
                                                  fontSize: 12.0,
                                                  color: Colors.grey[400],
                                                ),
                                              )
                                            ],
                                          )
                                        ],
                                      ),
                                    ],
                                  ),
                                )))),
                  ),
                ),
              ],
            ),
            Positioned(
                top: MediaQuery.of(context).size.height * 0.45,
                left: 20.0,
                right: 20.0,
                child: Card(
                    child: Padding(
                  padding: EdgeInsets.all(16.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Container(
                          child: Column(
                        children: [
                          Text(
                            ' رقم الهاتف',
                            style: TextStyle(
                                color: Colors.grey[400], fontSize: 14.0),
                          ),
                          SizedBox(
                            height: 5.0,
                          ),
                          Text(
                            "+970599969980",
                            style: TextStyle(
                              fontSize: 15.0,
                            ),
                          )
                        ],
                      )),
                      Expanded(
                        child: Column(children: [
                          Text(
                            'برنامج اتقان للادارة و المحاسبة',
                            style: TextStyle(
                                color: Colors.grey[400], fontSize: 14.0),
                          ),
                          SizedBox(
                            height: 5.0,
                          ),
                          Text(
                            'برنامج يقدم كل ما يلزمك',
                            style: TextStyle(
                              fontSize: 15.0,
                            ),
                          )
                        ]),
                      ),
                    ],
                  ),
                )))
          ],
        ),
      ),
    );
  }
}
