// ignore_for_file: prefer_const_constructors, library_private_types_in_public_api, deprecated_member_use

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:url_launcher/url_launcher.dart';

class Doctors extends StatefulWidget {
  const Doctors({Key? key}) : super(key: key);

  @override
  _DoctorsState createState() => _DoctorsState();
}

class _DoctorsState extends State<Doctors> {
  List<dynamic> values = <dynamic>[];

  @override
  void initState() {
    super.initState();
  }

  Future dataFetch() async {
    final response = await http.get(Uri.parse(
        'http://145.14.157.127/apps/labsmobileapp/tools/getlabs.php'));
    if (response.statusCode == 200) {
      values = json.decode(response.body);
      return json.decode(response.body);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(
              parent: AlwaysScrollableScrollPhysics()),
          child: Padding(
            padding: EdgeInsets.only(left: 24, right: 24, bottom: 8),
            child: Column(
              children: [
                SizedBox(height: 37),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "قائمة المختبرات المتوفرة",
                      style: GoogleFonts.workSans(
                        textStyle: TextStyle(
                          fontSize: 16,
                          color: Colors.black,
                          fontStyle: FontStyle.normal,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    Center(
                      child: SizedBox(
                        width: 24,
                        height: 24,
                        child: IconButton(
                          visualDensity: VisualDensity.adaptivePlatformDensity,
                          padding: EdgeInsets.zero,
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          icon: const Icon(
                            Icons.chevron_right,
                            color: Colors.black,
                          ),
                        ),
                      ),
                    )
                  ],
                ),
                SizedBox(height: 37),
                SizedBox(height: 30),
                FutureBuilder(
                  future: dataFetch(),
                  builder: (context, snapshot) => snapshot.hasData
                      ? ListView.separated(
                          shrinkWrap: true,
                          itemCount: values.length,
                          physics: const NeverScrollableScrollPhysics(),
                          itemBuilder: (c, i) {
                            return ListTile(
                              // leading: const Icon(Icons.add),
                              title: Text(
                                '${values[i]['lab_name']}',
                                textScaleFactor: 1.5,
                              ),
                              // trailing: InkWell(
                              //   onTap: () {
                              //     launch('tel://${values[i]['lab_phone']}');
                              //   },
                              //   child: Column(
                              //     children: [
                              //       Expanded(
                              //         child: IconButton(
                              //           icon: const Icon(
                              //             Icons.call_outlined,
                              //             color: Colors.green,
                              //           ),
                              //           tooltip: 'اتصل بنا',
                              //           onPressed: () {
                              //             launch(
                              //                 'tel://${values[i]['lab_phone']}');
                              //           },
                              //         ),
                              //       ),
                              //       Expanded(
                              //           child: Text(
                              //         "اتصل",
                              //         style: TextStyle(
                              //           color: Colors.green,
                              //         ),
                              //       ))
                              //     ],
                              //   ),
                              // ),
                              subtitle: values[i]['address'] == null
                                  ? Text(
                                      "لا يوجد عنوان مرفق ",
                                      style: TextStyle(
                                        color: Colors.black,
                                      ),
                                    )
                                  : Text(
                                      'العنوان : ${values[i]['address']}',
                                      style: TextStyle(
                                        color: Colors.black,
                                      ),
                                    ),
                              selected: true,
                            );
                          },
                          separatorBuilder: (c, i) {
                            return SizedBox(height: 24);
                          },
                        )
                      : Center(
                          child: CircularProgressIndicator(),
                        ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  var kAnimationDuration = const Duration(milliseconds: 200);
  var kPrimaryColor = Colors.black;

  // String? swipeDirection;

  AnimatedContainer buildDot(bool isCurrent) {
    return AnimatedContainer(
      duration: kAnimationDuration,
      margin: const EdgeInsets.only(right: 5),
      height: 8,
      width: 8,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: isCurrent ? const Color(0xff525252) : const Color(0xffC4C4C4),
      ),
    );
  }
}
