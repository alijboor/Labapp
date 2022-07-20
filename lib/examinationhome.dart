// ignore_for_file: prefer_const_constructors, unnecessary_new, unused_local_variable, import_of_legacy_library_into_null_safe, implementation_imports, no_leading_underscores_for_local_identifiers, prefer_final_fields, unused_field, avoid_unnecessary_containers, sized_box_for_whitespace, non_constant_identifier_names, deprecated_member_use, unnecessary_null_comparison, avoid_print, use_build_context_synchronously

import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:lapapp/home.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:intl/intl.dart' as intl;
import 'package:http/http.dart' as http;

class HomeTest extends StatefulWidget {
  const HomeTest({Key? key}) : super(key: key);

  @override
  State<HomeTest> createState() => _HomeTestState();
}

class _HomeTestState extends State<HomeTest> {
  static const _initialCameraPosition = CameraPosition(
      target: LatLng(31.757302779811123, 35.2495029804585), zoom: 6);
  String? dropdouwn_val;
  List<dynamic> labs = <dynamic>[];
  late GoogleMapController _googleMapController;
  Set<Marker> markers = {};
  bool loading = false;
  final _name = TextEditingController();
  final _phone = TextEditingController();
  final _dates = TextEditingController();
  final _nationId = TextEditingController();
  // final _lab_name = TextEditingController();
  double lat = 0;
  double lon = 0;

  File? _image;
  final picker = ImagePicker();

  void _showDialog() {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text(
              "اختر طريقة من التالي لاجراء الفحص:",
              textDirection: TextDirection.rtl,
              style:
                  TextStyle(color: Colors.white, fontWeight: FontWeight.w700),
            ),
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
    getLocation();
    getLabs();
  }

  Future<void> getLocation() async {
    Position position = await _getPosition();

    _googleMapController.animateCamera(CameraUpdate.newCameraPosition(
        CameraPosition(
            target: LatLng(position.latitude, position.longitude), zoom: 16)));
    markers.clear();
    markers.add(Marker(
        markerId: const MarkerId('Location'),
        infoWindow: const InfoWindow(title: 'موقعك الحالي'),
        position: LatLng(position.latitude, position.longitude)));
    setState(() {
      lat = position.latitude;
      lon = position.longitude;
    });
  }

  Future<void> getLabs() async {
    double? distanceImMeter = 0.0;
    final response = await http.get(Uri.parse(
        'http://145.14.157.127/apps/labsmobileapp/tools/getlabs.php'));
    if (response.statusCode == 200) {
      setState(() {
        labs = json.decode(response.body);
      });
      var item = labs[0];
      print(item["lab_id"]);
      //lab_name   lab_phone
    }
  }

  @override
  void dispose() {
    _googleMapController.dispose();
    super.dispose();
  }

  Future choiceImage() async {
    final pickedImage = await picker.getImage(source: ImageSource.gallery);
    setState(() {
      _image = File(pickedImage!.path);
    });
  }

  Future upload(File imageFile) async {
    var uri =
        Uri.parse("http://145.14.157.127/apps/labsmobileapp/tools/addexam.php");

    var request = http.MultipartRequest("POST", uri);
    request.fields['name_patient'] = _name.text;
    request.fields['phone'] = _phone.text;
    request.fields['date'] = _dates.text.toString();
    request.fields['nation_id'] = _nationId.text.toString();
    request.fields['lab_name'] = dropdouwn_val!;
    request.fields['lng'] = lon.toString();
    request.fields['lat'] = lat.toString();

    var pic = await http.MultipartFile.fromPath("image", imageFile.path);

    request.files.add(pic);
    var response = await request.send();

    if (response.statusCode == 200) {
      Done(context);
    } else {
      notDone(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
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
              margin: EdgeInsets.fromLTRB(5, 2, 5, 2),
              height: 400,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(2, 10, 2, 0),
                      child: TextField(
                        controller: _name,
                        decoration: InputDecoration(
                          labelText: 'ادخل اسمك',
                          border: OutlineInputBorder(),
                        ),
                        keyboardType: TextInputType.name,
                        textInputAction: TextInputAction.next,
                      ),
                    ),
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(2, 10, 2, 5),
                          child: TextField(
                            controller: _phone,
                            decoration: InputDecoration(
                              labelText: 'ادخل رقم الهاتف',
                              border: OutlineInputBorder(),
                            ),
                            keyboardType: TextInputType.number,
                            textInputAction: TextInputAction.next,
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
                            keyboardType: TextInputType.number,
                            textInputAction: TextInputAction.next,
                          ),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      OutlinedButton(
                        onPressed: () {
                          choiceImage();
                        },
                        child: Text('اختر صورة عن تقرير '),
                      ),
                      Container(
                        width: 150,
                        height: 75,
                        child: _image == null
                            ? Center(child: Text("لا توجد صورة مرفقة"))
                            : Center(child: Image.file(_image!)),
                      )
                    ],
                  ),
                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey),
                          borderRadius: BorderRadius.all(Radius.circular(4))),
                      // margin: EdgeInsets.symmetric(vertical: 0, horizontal: 10),
                      padding: const EdgeInsets.fromLTRB(2, 5, 2, 5),
                      child: DropdownButtonHideUnderline(
                        child: DropdownButton(
                          hint: Text("اختر مختبر"),
                          value: dropdouwn_val,
                          isExpanded: true,
                          items: labs
                              .map((e) => DropdownMenuItem(
                                    value: e["lab_id"].toString(),
                                    child: Text(e["lab_name"].toString()),
                                  ))
                              .toList(),
                          onChanged: (value) {
                            setState(() {
                              dropdouwn_val = value as String?;
                            });
                          },
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(2, 10, 2, 5),
                      child: TextField(
                        readOnly: true,
                        controller: _dates,
                        decoration: InputDecoration(
                          labelText: ' اختر التاريخ للفحص',
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
                  Container(
                    height: 50,
                    child: ElevatedButton.icon(
                      icon: const Icon(Icons.send_sharp),
                      label: loading
                          ? Row(
                              // ignore: prefer_const_literals_to_create_immutables
                              children: [
                                Text("جاري ارسال الطلب"),
                                CircularProgressIndicator(
                                  color: Colors.white,
                                )
                              ],
                            )
                          : Text("ارسل الطلب"),
                      style: ElevatedButton.styleFrom(
                          primary: const Color.fromARGB(255, 0, 137, 80),
                          onPrimary: Colors.white),
                      onPressed: () {
                        if (_image == null) {
                          notDone(context);
                        } else {
                          setState(() {
                            loading = true;
                          });
                          upload(_image!);
                        }
                      },
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
      return Future.error('لا توجد صلاحيات للوصول للموقع');
    }

    Position position = await Geolocator.getCurrentPosition();

    return position;
  }

  Future<String?> Done(BuildContext context) => showDialog<String>(
      context: context,
      builder: (context) => AlertDialog(
            title: Text(
              "تم استقبال طلبك سيتم التواصل معك قريباً.",
              textDirection: TextDirection.rtl,
            ),
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
                  child: Text(
                    'تم',
                    style: TextStyle(fontSize: 20),
                  ))
            ],
          ));

  Future<String?> notDone(BuildContext context) => showDialog<String>(
      context: context,
      builder: (context) => AlertDialog(
            title: Text(
              "حدثت مشكلة حاول مرة اخرى",
              textDirection: TextDirection.rtl,
            ),
            content: Text("تاكد من ارفاق صورة و ادخال البيانات "),
            actions: [
              TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text('تم'))
            ],
          ));
}
