// ignore_for_file: prefer_const_constructors, unnecessary_new, unused_local_variable, import_of_legacy_library_into_null_safe, implementation_imports, no_leading_underscores_for_local_identifiers, prefer_final_fields, unused_field, avoid_unnecessary_containers, sized_box_for_whitespace, non_constant_identifier_names, deprecated_member_use

import 'dart:async';
// import 'dart:html';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:lapapp/data/examination.dart';
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

  late GoogleMapController _googleMapController;
  Set<Marker> markers = {};

  @override
  void dispose() {
    _googleMapController.dispose();
    super.dispose();
  }

  final _name = TextEditingController();
  final _phone = TextEditingController();
  final _type = TextEditingController();
  final _date = TextEditingController();
  final _nationId = TextEditingController();
  final _lab_name = TextEditingController();
  double lat = 0;
  double lon = 0;

  @override
  Widget build(BuildContext context) {
    Future.delayed(Duration.zero, () => PopUps(context));

    return Scaffold(
      appBar: AppBar(
          actions: [
            IconButton(
                onPressed: () {
                  print(lat);
                  print(lon);
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
                        controller: _name,
                        // controller: nameController,
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
                        controller: _date,
                        decoration: InputDecoration(
                          labelText: ' اختر التاريخ',
                          border: OutlineInputBorder(),
                          icon: FaIcon(FontAwesomeIcons.calendarCheck),
                        ),
                        keyboardType: TextInputType.name,
                        textInputAction: TextInputAction.done,
                        onTap: () async {
                          DateTime? pickedate = await showDatePicker(
                              context: context,
                              initialDate: DateTime.now(),
                              firstDate: DateTime(2020),
                              lastDate: DateTime(2050));

                          if (pickedate != null) {
                            setState(() {
                              _date.text = intl.DateFormat('yyyy-MM-dd')
                                  .format(pickedate);
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
          print('$lat///\n $lon');
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

  Future createExamination(
      {required String phone,
      required String name,
      required String lab,
      required String typeof,
      required DateTime dateof,
      required int nationid,
      required double latt,
      required double langg}) async {
    final docExam = FirebaseFirestore.instance.collection('Examination').doc();
    // final Exam = Examination(
    //     phone: phone,
    //     name_patient: name,
    //     lab_name: lab,
    //     type_exam: typeof,
    //     date: dateof,
    //     nation_id: nationid,
    //     lat:latt,
    //     lng: langg);
  }

  Future<String?> PopUps(BuildContext context) => showDialog<String>(
      context: context,
      builder: (context) => AlertDialog(
            // title: Text(""),
            actions: [
              TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text('ادخل بياناتك للسحب')),
              TextButton(
                  onPressed: () {
                    launch('tel://+970599969980');
                  },
                  child: Text('اتصل بنا'))
            ],
          ));
}
