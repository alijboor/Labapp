// ignore_for_file: prefer_const_constructors, unnecessary_new, unused_local_variable, import_of_legacy_library_into_null_safe, implementation_imports, no_leading_underscores_for_local_identifiers, prefer_final_fields, unused_field, avoid_unnecessary_containers, sized_box_for_whitespace, non_constant_identifier_names, deprecated_member_use, unnecessary_null_comparison

import 'dart:async';
// import 'dart:html';

// import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
// import 'package:lapapp/data/examination.dart';
import 'package:lapapp/home.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:intl/intl.dart' as intl;

class HomeTest extends StatefulWidget {
  const HomeTest({Key? key}) : super(key: key);

  @override
  State<HomeTest> createState() => _HomeTestState();
}

class _HomeTestState extends State<HomeTest> {
  static const _initialCameraPosition = CameraPosition(
      target: LatLng(31.757302779811123, 35.2495029804585), zoom: 6);

  void _showDialog() {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            backgroundColor: Colors.lightGreen,
            actions: [
              MaterialButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text(
                    'ادخل بياناتك للسحب',
                    textDirection: TextDirection.rtl,
                    style: TextStyle(
                        color: Colors.white, fontWeight: FontWeight.w700),
                  )),
              MaterialButton(
                  onPressed: () {
                    launch('tel://+970599969980');
                  },
                  child: Text(
                    'اتصل بنا',
                    textDirection: TextDirection.rtl,
                    style: TextStyle(
                        color: Colors.white, fontWeight: FontWeight.w700),
                  ))
            ],
          );
        });
  }

  @override
  void initState() {
    super.initState();
    Future(_showDialog);
    //   Timer.run(_showDialog); // Requires import: 'dart:async'
  }

  late GoogleMapController _googleMapController;
  Set<Marker> markers = {};

  @override
  void dispose() {
    _googleMapController.dispose();
    super.dispose();
  }

  // late String _name, _type, _date, _phone, _lab_name = "";
  // late int _nationID = 0;
  final _name = TextEditingController();
  final _phone = TextEditingController();
  final _type = TextEditingController();
  final _dates = TextEditingController();
  final _nationId = TextEditingController();
  final _lab_name = TextEditingController();
  double lat = 0;
  double lon = 0;

  @override
  Widget build(BuildContext context) {
    // Future.delayed(Duration.zero, () => PopUps(context));

    return Scaffold(
      appBar: AppBar(
          actions: [
            IconButton(
                onPressed: () {
                  createExamination();
                },
                icon: Icon(Icons.add_chart))
          ],
          title: Center(
            child: Text(
              'سحب منزلي',
            ),
          )),
      body: Directionality(
        textDirection: TextDirection.rtl,
        child: Column(
          // ignore: prefer_const_literals_to_create_immutables
          children: [
            Container(
              height: 400,
              child: Column(
                children: [
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(2, 10, 2, 5),
                      child: TextField(
                        // onChanged: (String name) {
                        //   _name = name;
                        // },
                        controller: _name,
                        decoration: InputDecoration(
                          // hintText: 'علي',
                          labelText: 'ادخل اسمك',
                          border: OutlineInputBorder(),
                        ),
                        keyboardType: TextInputType.name,
                        textInputAction: TextInputAction.done,
                      ),
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(2, 10, 2, 5),
                      child: TextField(
                        // onChanged: (String phone) {
                        //   _phone = phone;
                        // },
                        controller: _phone,
                        decoration: InputDecoration(
                          labelText: 'ادخل رقم الهاتف',
                          border: OutlineInputBorder(),
                        ),
                        keyboardType: TextInputType.name,
                        textInputAction: TextInputAction.done,
                      ),
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(2, 10, 2, 5),
                      child: TextField(
                        // onChanged: (String type) {
                        //   _type = type;
                        // },
                        controller: _type,
                        decoration: InputDecoration(
                          labelText: ' نوع الفحص',
                          border: OutlineInputBorder(),
                        ),
                        keyboardType: TextInputType.name,
                        textInputAction: TextInputAction.done,
                      ),
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(2, 10, 2, 5),
                      child: TextField(
                        // onChanged: (String lab) {
                        //   _lab_name = lab;
                        // },

                        controller: _lab_name,
                        decoration: InputDecoration(
                          labelText: ' المختبر',
                          border: OutlineInputBorder(),
                        ),
                        keyboardType: TextInputType.name,
                        textInputAction: TextInputAction.done,
                      ),
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(2, 10, 2, 5),
                      child: TextField(
                        // onChanged: (String nationid) {
                        //   _nationID = int.parse(nationid);
                        // },

                        controller: _nationId,
                        decoration: InputDecoration(
                          labelText: 'رقم الهوية',
                          border: OutlineInputBorder(),
                        ),
                        keyboardType: TextInputType.name,
                        textInputAction: TextInputAction.done,
                      ),
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(2, 10, 2, 5),
                      child: TextField(
                        readOnly: true,
                        // onChanged: (String date) {
                        //   _date = date;
                        // },
                        controller: _dates,
                        decoration: InputDecoration(
                          labelText: ' اختر التاريخ',
                          border: OutlineInputBorder(),
                          icon: FaIcon(FontAwesomeIcons.calendarCheck),
                        ),
                        keyboardType: TextInputType.name,
                        textInputAction: TextInputAction.done,
                        onTap: () async {
                          DateTime dateTime = DateTime.now();
                          final pickedate = await showDatePicker(
                              context: context,
                              initialDate: dateTime,
                              firstDate: DateTime(2020),
                              lastDate: DateTime(2050));

                          final time = await showTimePicker(
                              context: context,
                              initialTime: TimeOfDay(
                                  hour: dateTime.hour,
                                  minute: dateTime.minute));
                          final dateTimes = DateTime(
                              pickedate!.year,
                              pickedate.month,
                              pickedate.day,
                              time!.hour,
                              time.minute);
                          if (pickedate == null) {
                            return;
                          } else {
                            setState(() {
                              _dates.text = intl.DateFormat('yyyy-MM-dd HH:mm')
                                  .format(dateTimes);
                            });
                          }
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
                child: Container(
              height: 200,
              padding: EdgeInsets.all(4),
              child: GoogleMap(
                myLocationEnabled: true,
                initialCameraPosition: _initialCameraPosition,
                zoomControlsEnabled: false,
                myLocationButtonEnabled: true,
                onMapCreated: (GoogleMapController controller) =>
                    _googleMapController = controller,
                markers: markers,
              ),
            )),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.center_focus_strong),
        onPressed: () async {
          Position position = await _getPosition();

          _googleMapController.animateCamera(CameraUpdate.newCameraPosition(
              CameraPosition(
                  target: LatLng(position.latitude, position.longitude),
                  zoom: 16)));
          markers.clear();
          markers.add(Marker(
              markerId: const MarkerId('موقعك الحالي'),
              position: LatLng(position.latitude, position.longitude)));
          setState(() {
            lat = position.latitude;
            lon = position.longitude;
          });
        },
      ),
    );
  }

  Future<Position> _getPosition() async {
    bool serviceEnable;
    LocationPermission permission;
    serviceEnable = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnable) {
      return Future.error('Location services are disable');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('error');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return Future.error('خطا في البيرمشن');
    }

    Position position = await Geolocator.getCurrentPosition();

    return position;
  }

  Future createExamination() async {
    // final docExam = FirebaseFirestore.instance
    //     .collection('Examination')
    //     .doc(_nationId.text);
    final json = {
      'lab_name': _lab_name.text,
      'date': _dates.text,
      'phone': _phone.text,
      'nation_id': _nationId.text,
      'type_exam': _type.text,
      'name_patient': _name.text,
      'gps_patient': {'Latitude': lat, 'Longitude': lon},
    };
    // await docExam
    //     .set(json)
    //     .then((value) => Done(context))
    //     .catchError((error) => notDone(context));
  }

  // Future<String?> PopUps(BuildContext context) => showDialog<String>(
  //     context: context,
  //     builder: (context) => AlertDialog(
  //           // title: Text(""),
  //           actions: [
  //             TextButton(
  //                 onPressed: () {
  //                   Navigator.of(context).pop();
  //                 },
  //                 child: Text('ادخل بياناتك للسحب')),
  //             TextButton(
  //                 onPressed: () {
  //                   launch('tel://+970599969980');
  //                 },
  //                 child: Text('اتصل بنا'))
  //           ],
  //         ));

  Future<String?> Done(BuildContext context) => showDialog<String>(
      context: context,
      builder: (context) => AlertDialog(
            title: Text(
              "تم استقبال طلبك سيتم التواصل معك قريباً.",
              textDirection: TextDirection.rtl,
            ),
            // content: Text(''
            // ),
            actions: [
              TextButton(
                  onPressed: () {
                    Navigator.of(context).pushAndRemoveUntil(
                        MaterialPageRoute(
                            builder: (context) => Directionality(
                                textDirection: TextDirection.rtl,
                                child: HomePage())),
                        (Route<dynamic> route) => false);
                  },
                  child: Text('تم'))
            ],
          ));

  Future<String?> notDone(BuildContext context) => showDialog<String>(
      context: context,
      builder: (context) => AlertDialog(
            title: Text(
              "حدثت مشكلة حاول مرة اخرى",
              textDirection: TextDirection.rtl,
            ),
            // content: Text(''
            // ),
            actions: [
              TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text('تم'))
            ],
          ));
}
