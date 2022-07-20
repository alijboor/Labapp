// ignore_for_file: avoid_print, prefer_const_literals_to_create_immutables, prefer_const_constructors, deprecated_member_use, unnecessary_string_interpolations, prefer_typing_uninitialized_variables

import 'dart:convert';
import 'dart:io';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:footer/footer.dart';
import 'package:footer/footer_view.dart';
import 'package:http/http.dart' as http;

// pages
import 'package:lapapp/aboutus.dart';
import 'package:lapapp/callus.dart';
import 'package:lapapp/data/image.dart';
import 'package:lapapp/developerpage.dart';
import 'package:lapapp/doctors.dart';
import 'package:lapapp/examinationhome.dart';
import 'package:lapapp/ourservice.dart';
import 'package:lapapp/resultofanalysis.dart';
import 'package:path_provider/path_provider.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:url_launcher/url_launcher.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List sliderimage = [];
  String about = '';
  String contact = '';
  String service = '';
  String servicePageContent = '';

  var items;
  Future<String> getLocalPath() async {
    var folder = await getApplicationDocumentsDirectory();
    return folder.path;
  }

  Future<File> getLocalFileabout() async {
    String path = await getLocalPath();
    return File('$path/about.txt');
  }

  Future<File> writeAbout(String data) async {
    File file = await getLocalFileabout();
    return file.writeAsString(data);
  }

  Future<String> readAbout() async {
    try {
      final file = await getLocalFileabout();
      String about = await file.readAsString();
      return about;
    } catch (e) {
      return "";
    }
  }

  //service
  Future<File> getLocalFileService() async {
    String path = await getLocalPath();
    return File('$path/service.txt');
  }

  Future<File> writeService(String data) async {
    File file = await getLocalFileService();
    return file.writeAsString(data);
  }

  Future<String> readService() async {
    try {
      final file = await getLocalFileService();
      String service = await file.readAsString();
      return service;
    } catch (e) {
      return "";
    }
  }

  //contact
  Future<File> getLocalFileContact() async {
    String path = await getLocalPath();
    return File('$path/contact.txt');
  }

  Future<File> writeContact(String data) async {
    File file = await getLocalFileContact();
    return file.writeAsString(data);
  }

  Future<String> readContact() async {
    try {
      final file = await getLocalFileContact();
      String content = await file.readAsString();
      return content;
    } catch (e) {
      return "";
    }
  }

  @override
  void initState() {
    super.initState();
    fechData();
    readAbout().then((data) {
      setState(() {
        about = data;
      });
    });
    readContact().then((datas) {
      setState(() {
        contact = datas;
      });
    });
    readService().then((dat) {
      setState(() {
        service = dat;
      });
    });
  }

  fechData() async {
    String links = 'http://145.14.157.127/apps/labsmobileapp/';
    final response = await http.get(Uri.parse(links));
    if (response.statusCode == 200) {
      items = json.decode(response.body);
      // print(items[2][1]);

      writeAbout(items[0][1]);
      writeContact(items[1][1]);
      writeContact(items[2][1]);

      sliderimage = json.decode(response.body)[2][1];
    }
  }

  addImage() {
    var i = 0;
    for (var element in sliderimage) {
      imageList[i] = element[1];
      i++;
    }
  }

  final List<Images> imageList = [
    Images("images/slider1.jpg", "http://google.com"),
    Images("images/slider2.jpg", "http://facebook.com"),
    Images("images/slider3.jpg", "")
  ];
  GlobalKey<ScaffoldState> scaffoldkey = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    // ignore: unnecessary_new
    return Scaffold(
      key: scaffoldkey,
      appBar: AppBar(
        title: Text(
          'Home Lab Group',
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.question_mark_sharp),
            onPressed: () {
              Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => DeveloperPage()));
            },
          ),
        ],
        centerTitle: true,
      ),
      body: FooterView(
        flex: 6,
        footer: Footer(
          child: Column(
            children: [
              Text(
                'Copyright ©2022, All Rights Reserved.',
                style: TextStyle(
                    fontWeight: FontWeight.w300,
                    fontSize: 12.0,
                    color: Color(0xFF162A49)),
              ),
              Text(
                'Powered by Itqan',
                style: TextStyle(
                    fontWeight: FontWeight.w300,
                    fontSize: 12.0,
                    color: Color(0xFF162A49)),
              ),
            ],
          ),
        ),
        children: [
          SizedBox(
            height: 400.0,
            child: CarouselSlider(
              options: CarouselOptions(
                  height: 400.0,
                  // enableInfiniteScroll: false,
                  enlargeCenterPage: true,
                  autoPlay: true,
                  viewportFraction: 1,
                  autoPlayAnimationDuration: Duration(milliseconds: 900),
                  autoPlayCurve: Curves.fastOutSlowIn,
                  autoPlayInterval: Duration(seconds: 3)),
              items: imageList
                  .map((e) => ClipRect(
                        child: Stack(
                          fit: StackFit.expand,
                          children: [
                            InkWell(
                              onTap: () {
                                print(sliderimage);
                                launch(e.link.toString());
                              }, // Image tapped
                              child: Ink.image(
                                image: AssetImage(e.name),
                                width: 100,
                                height: 300,
                                fit: BoxFit.fill,
                              ),
                            )
                          ],
                        ),
                      ))
                  .toList(),
            ),
          ),
          Divider(
            height: 0,
            thickness: 5,
            color: Colors.lightGreen,
          ),
          Container(
            height: 140,
            padding: EdgeInsets.all(0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Expanded(
                  flex: 2900,
                  child: Card(
                    elevation: 5,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20)),
                    shadowColor: Colors.lightGreen,
                    color: Colors.lightBlue,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: TextButton(
                            style: TextButton.styleFrom(
                              padding: const EdgeInsets.all(16.0),
                              primary: Colors.white,
                              textStyle: const TextStyle(fontSize: 15),
                            ),
                            onPressed: () {
                              Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => Directionality(
                                    textDirection: TextDirection.rtl,
                                    child: Doctors()),
                              ));
                            },
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Expanded(
                                  child: FaIcon(
                                    FontAwesomeIcons.userDoctor,
                                    size: 50,
                                  ),
                                ),
                                Expanded(
                                    child: Container(
                                  padding: EdgeInsets.fromLTRB(0, 15, 0, 15),
                                  child: Text(
                                    'المختبرات',
                                    textAlign: TextAlign.center,
                                  ),
                                )),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Expanded(
                  flex: 4000,
                  child: SizedBox(
                    width: 250,
                    child: Card(
                      elevation: 5,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20)),
                      shadowColor: Colors.lightGreen,
                      color: Colors.lightBlue,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: TextButton(
                              style: TextButton.styleFrom(
                                padding: const EdgeInsets.all(16.0),
                                primary: Colors.white,
                                textStyle: const TextStyle(fontSize: 15),
                              ),
                              onPressed: () {
                                Navigator.of(context).push(MaterialPageRoute(
                                    builder: (context) => Directionality(
                                        textDirection: TextDirection.rtl,
                                        child: ResultOfAnalysis())));
                              },
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Expanded(
                                    child: FaIcon(
                                      FontAwesomeIcons.clipboardList,
                                      size: 50,
                                    ),
                                  ),
                                  Expanded(
                                      child: Container(
                                    padding: EdgeInsets.fromLTRB(0, 15, 0, 15),
                                    child: Text(
                                      'نتائج التحليل',
                                      textAlign: TextAlign.center,
                                    ),
                                  )),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Expanded(
                  flex: 3000,
                  child: Card(
                    elevation: 5,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20)),
                    shadowColor: Colors.lightGreen,
                    color: Colors.lightBlue,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: TextButton(
                            style: TextButton.styleFrom(
                              padding: const EdgeInsets.all(16.0),
                              primary: Colors.white,
                              textStyle: const TextStyle(fontSize: 15),
                            ),
                            onPressed: () {
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => HomeTest()));
                            },
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Expanded(
                                  child: FaIcon(
                                    FontAwesomeIcons.houseMedicalCircleXmark,
                                    size: 50,
                                  ),
                                ),
                                Expanded(
                                    child: Container(
                                  padding: EdgeInsets.fromLTRB(0, 15, 0, 15),
                                  child: Text(
                                    'سحب منزلي',
                                    textAlign: TextAlign.center,
                                  ),
                                )),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.fromLTRB(0, 5, 0, 1),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              mainAxisSize: MainAxisSize.max,
              children: [
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) =>
                              OurService(content: items[2][2])));
                    },
                    child: CircleAvatar(
                      radius: 57,
                      backgroundColor: Colors.lightGreen,
                      child: CircleAvatar(
                        radius: 55,
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(0, 20, 0, 15),
                          child: Column(
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              FaIcon(
                                FontAwesomeIcons.flaskVial,
                                size: 40,
                              ),
                              service == ''
                                  ? Text('خدماتنا')
                                  : Text('$service'),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => CallUs(content: items[1][2])));
                    },
                    child: CircleAvatar(
                      radius: 57,
                      backgroundColor: Colors.lightGreen,
                      child: CircleAvatar(
                        radius: 55,
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(0, 20, 0, 15),
                          child: Column(
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              FaIcon(
                                FontAwesomeIcons.phone,
                                size: 40,
                              ),
                              contact == ''
                                  ? Text('اتصل بنا')
                                  : Text('$contact'),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => AboutUs(content: items[0][2])));
                    },
                    child: CircleAvatar(
                      radius: 57,
                      backgroundColor: Colors.lightGreen,
                      child: CircleAvatar(
                        radius: 55,
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(0, 20, 0, 15),
                          child: Column(
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              FaIcon(
                                FontAwesomeIcons.circleInfo,
                                size: 40,
                              ),
                              if (about == '')
                                Text('من نحن؟')
                              else
                                Text('$about'),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
