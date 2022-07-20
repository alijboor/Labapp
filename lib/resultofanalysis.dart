// ignore_for_file: prefer_const_constructors, non_constant_identifier_names, deprecated_member_use, prefer_collection_literals, prefer_typing_uninitialized_variables, avoid_print
import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cached_pdfview/flutter_cached_pdfview.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lapapp/pages/pdf_view.dart';
import 'package:path_provider/path_provider.dart';
import 'package:http/http.dart' as http;

class ResultOfAnalysis extends StatefulWidget {
  const ResultOfAnalysis({Key? key}) : super(key: key);

  @override
  State<ResultOfAnalysis> createState() => _ResultOfAnalysisState();
}

class _ResultOfAnalysisState extends State<ResultOfAnalysis> {
  List<dynamic> values = <dynamic>[];

  bool isData = false;
  TextEditingController nationNumber = TextEditingController();

  var datas;
  @override
  void initState() {
    super.initState();
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
                      "نتائج التحاليل الخاصة بك",
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
                Container(
                  margin: EdgeInsets.all(3),
                  child: Row(
                    children: <Widget>[
                      Expanded(
                        flex: 4,
                        child: Container(
                          height: 60,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                              color: Color.fromARGB(255, 209, 209, 209),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10))),
                          child: TextField(
                            textDirection: TextDirection.rtl,
                            // autofocus: true,
                            controller: nationNumber,
                            keyboardType: TextInputType.number,
                            decoration: InputDecoration(
                                border: InputBorder.none,
                                hintText: "ادخل رقم الهوية",
                                hintStyle: TextStyle(fontSize: 20),
                                // contentPadding: EdgeInsets.only(
                                //     left: 0, right: 0, bottom: 0, top: 0),
                                prefixIcon:
                                    Icon(Icons.search, color: Colors.black54)),
                          ),
                        ),
                      ),
                      SizedBox(width: 10),
                      Expanded(
                        child: MaterialButton(
                            height: 60,
                            onPressed: () {
                              if (nationNumber.text == '') {
                                PopUps(context);
                              } else {
                                dataFetch(nationNumber.text);
                                setState(() {
                                  isData = true;
                                });
                              }
                            },
                            child: Text(
                              'بحث',
                              textDirection: TextDirection.rtl,
                              style: TextStyle(fontWeight: FontWeight.w700),
                            )),
                      )
                    ],
                  ),
                ),
                SizedBox(height: 30),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "تحليلاتك",
                      style: GoogleFonts.workSans(
                        textStyle: TextStyle(
                          fontSize: 16,
                          color: Colors.black,
                          fontStyle: FontStyle.normal,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 30),
                if (isData)
                  FutureBuilder(
                    future: dataFetch(nationNumber.text),
                    builder: (context, snapshot) => snapshot.hasData
                        ? ListView.separated(
                            shrinkWrap: true,
                            itemCount: values.length,
                            physics: const NeverScrollableScrollPhysics(),
                            itemBuilder: (c, i) {
                              print(values);
                              if (values.length != 0) {
                                return InkWell(
                                  onTap: () {
                                    Navigator.of(context).push(
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                Directionality(
                                                    textDirection:
                                                        TextDirection.rtl,
                                                    child: PDFPageViewer(
                                                      link:
                                                          'http://145.14.157.127/apps/labsmobileapp/reports/${values[i]["reportid"]}.pdf',
                                                    ))));
                                  },
                                  child: SizedBox(
                                    height: 125,
                                    child: Row(
                                      mainAxisSize: MainAxisSize.max,
                                      children: [
                                        Center(
                                          child: ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(8),
                                            child: Container(
                                              width: 125,
                                              height: 125,
                                              // margin: EdgeInsets.only(right: 14 ),
                                              color: Color.fromARGB(
                                                  255, 160, 58, 58),
                                              child: PDF().cachedFromUrl(
                                                "http://145.14.157.127/apps/labsmobileapp/reports/${values[i]["reportid"]}.pdf",
                                                errorWidget: (error) => Center(
                                                    child: Text(
                                                  "لا يوجد ملف ",
                                                  style: TextStyle(
                                                      fontSize: 20,
                                                      fontWeight:
                                                          FontWeight.w600),
                                                )),
                                              ),
                                            ),
                                          ),
                                        ),
                                        Expanded(
                                          child: Row(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Expanded(
                                                child: Padding(
                                                  padding: EdgeInsets.only(
                                                    left: 15,
                                                    right: 2,
                                                    top: 10,
                                                    bottom: 10,
                                                  ),
                                                  child: Column(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.start,
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Flexible(
                                                        child: Text(
                                                          "رقم الهوية :${values[i]["nation_number"]}",
                                                          style: GoogleFonts
                                                              .workSans(
                                                            textStyle:
                                                                TextStyle(
                                                              fontSize: 16,
                                                              color:
                                                                  Colors.black,
                                                              fontStyle:
                                                                  FontStyle
                                                                      .normal,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w600,
                                                            ),
                                                          ),
                                                          maxLines: 3,
                                                          overflow: TextOverflow
                                                              .ellipsis,
                                                        ),
                                                      ),
                                                      SizedBox(
                                                        height: 8,
                                                      ),
                                                      Text(
                                                        "ملاحظات :${values[i]["note"]}",
                                                        style: GoogleFonts
                                                            .workSans(
                                                          textStyle: TextStyle(
                                                            fontSize: 14,
                                                            color: Colors.black,
                                                            fontStyle: FontStyle
                                                                .normal,
                                                            fontWeight:
                                                                FontWeight.w400,
                                                          ),
                                                        ),
                                                        // maxLines: 1,
                                                        // overflow: TextOverflow
                                                        //     .ellipsis,
                                                      ),
                                                      SizedBox(
                                                        height: 8,
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                );
                              } else {
                                return SizedBox(
                                    child: Text("لا توجد بيانات لك"));
                              }
                            },
                            separatorBuilder: (c, i) {
                              return SizedBox(height: 24);
                            },
                          )
                        : Center(
                            child: CircularProgressIndicator(),
                          ),
                  )
                else
                  Text("ادخل رقم الهوية للحصول على بياناتك "),
                SizedBox(height: 8),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<String?> PopUps(BuildContext context) => showDialog<String>(
      context: context,
      builder: (context) => AlertDialog(
            title: Text(
              "الرجاء ادخال رقم الهوية اولاً",
              textDirection: TextDirection.rtl,
            ),
            actions: [
              TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text('حسنا'))
            ],
          ));

  Future openFile({required String url, String? fileName}) async {
    await downloadFile(url, fileName!);
  }

  Future<File?> downloadFile(String url, String name) async {
    final appStorage = await getApplicationDocumentsDirectory();
    final file = File('${appStorage.path}/$name');

    final response = await Dio().get(
      url,
      options: Options(
        responseType: ResponseType.bytes,
        followRedirects: false,
        receiveTimeout: 0,
      ),
    );
    final raf = file.openSync(mode: FileMode.write);
    raf.writeFromSync(response.data);
    await raf.close();
    return file;
  }

  Future dataFetch(String? id) async {
    final response = await http.get(Uri.parse(
        'http://145.14.157.127/apps/labsmobileapp/tools/reports.php?id=$id'));
    if (response.statusCode == 200) {
      values = json.decode(response.body);
      print(values.length);
      return json.decode(response.body);
    }
  }
}
