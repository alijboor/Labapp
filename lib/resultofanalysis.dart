// ignore_for_file: prefer_const_constructors, non_constant_identifier_names

// import 'dart:html';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cached_pdfview/flutter_cached_pdfview.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lapapp/data/report.dart';
import 'package:path_provider/path_provider.dart';

class ResultOfAnalysis extends StatefulWidget {
  const ResultOfAnalysis({Key? key}) : super(key: key);

  @override
  State<ResultOfAnalysis> createState() => _ResultOfAnalysisState();
}

class _ResultOfAnalysisState extends State<ResultOfAnalysis> {
  int currentPage = 0;

  late TextEditingController nationNumber;
  @override
  void initState() {
    super.initState();
    nationNumber = TextEditingController();
    // PopUps();
    // WidgetsBinding.instance?.addPostFrameCallback((_) {
    //   showDialog(
    //       context: context,
    //       builder: (context) => AlertDialog(
    //             title: Text("ادخل رقم الهوية"),
    //             content: TextField(
    //               autofocus: true,
    //               decoration: InputDecoration(hintText: "ادخل رقم الهوية"),
    //             ),
    //             actions: [
    //               TextButton(onPressed: () {}, child: Text('بحث عن نتائج'))
    //             ],
    //           ));
    // });
  }

  List<Report> reports = [
    Report(0, "فحص دم", "نتيجة فحص الدم جيدة", "علي جبور", 405499484),
    Report(1, "فحص بول", "نتيجة فحص البول جيدة", "علي جبور", 405499484)
  ];
  @override
  Widget build(BuildContext context) {
    Future.delayed(Duration.zero, () => PopUps(context));
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
                    // SizedBox(
                    //   width: 24,
                    //   height: 24,
                    //   child: IconButton(
                    //     visualDensity: VisualDensity.adaptivePlatformDensity,
                    //     padding: EdgeInsets.zero,
                    //     onPressed: () {
                    //       Navigator.pop(context);
                    //     },
                    //     icon: const Icon(
                    //       Icons.chevron_left,
                    //       color: Colors.black,
                    //     ),
                    //   ),
                    // ),
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
                ClipRRect(
                  borderRadius: BorderRadius.circular(16),
                  child: SizedBox(
                    width: 343,
                    height: 170,
                    child: Stack(
                      children: [
                        PageView.builder(
                          itemCount: 4,
                          physics: const BouncingScrollPhysics(
                              parent: AlwaysScrollableScrollPhysics()),
                          onPageChanged: (index) {
                            setState(() {
                              currentPage = index;
                            });
                          },
                          itemBuilder: (c, i) {
                            return Container(
                              width: 343,
                              height: 170,
                              color: const Color(0xffA8A8A8),
                            );
                          },
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Center(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: List.generate(
                                  4,
                                  (index) => buildDot(index == currentPage),
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 11,
                            )
                          ],
                        )
                      ],
                    ),
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
                    // TextButton(
                    //   onPressed: () {},
                    //   child: Text(
                    //     "See more",
                    //     style: GoogleFonts.workSans(
                    //       textStyle: TextStyle(
                    //         fontSize: 14,
                    //         color: Colors.black,
                    //         fontStyle: FontStyle.normal,
                    //         fontWeight: FontWeight.w600,
                    //       ),
                    //     ),
                    //   ),
                    // )
                  ],
                ),
                SizedBox(height: 30),
                ListView.separated(
                  shrinkWrap: true,
                  itemCount: reports.length,
                  physics: const NeverScrollableScrollPhysics(),
                  itemBuilder: (c, i) {
                    return SizedBox(
                      height: 125,
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Center(
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(8),
                              child: Container(
                                width: 125,
                                height: 125,
                                // margin: EdgeInsets.only(right: 14 ),
                                color: Color.fromARGB(255, 160, 58, 58),
                                child: PDF().cachedFromUrl(
                                    "https://www.bu.edu/tech/files/2017/02/Introduction-to-C-Part-1.pdf"),
                              ),
                            ),
                          ),
                          Expanded(
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                                          CrossAxisAlignment.start,
                                      children: [
                                        Flexible(
                                          child: Text(
                                            reports[i].name,
                                            style: GoogleFonts.workSans(
                                              textStyle: TextStyle(
                                                fontSize: 16,
                                                color: Colors.black,
                                                fontStyle: FontStyle.normal,
                                                fontWeight: FontWeight.w600,
                                              ),
                                            ),
                                            maxLines: 3,
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                        ),
                                        SizedBox(
                                          height: 8,
                                        ),
                                        Text(
                                          reports[i].name_of_patient,
                                          style: GoogleFonts.workSans(
                                            textStyle: TextStyle(
                                              fontSize: 14,
                                              color: Colors.black,
                                              fontStyle: FontStyle.normal,
                                              fontWeight: FontWeight.w400,
                                            ),
                                          ),
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                        SizedBox(
                                          height: 8,
                                        ),
                                        Row(
                                          children: [
                                            const Icon(
                                              Icons.star,
                                              color: Colors.black,
                                            ),
                                            Text(
                                              reports[i].descr,
                                              style: GoogleFonts.workSans(
                                                textStyle: TextStyle(
                                                  fontSize: 14,
                                                  color: Colors.black,
                                                  fontStyle: FontStyle.normal,
                                                  fontWeight: FontWeight.w600,
                                                ),
                                              ),
                                              maxLines: 1,
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                            SizedBox(
                                              width: 16,
                                            ),
                                            // Flexible(
                                            //   child: Text(
                                            //     reports[i].descr,
                                            //     style: GoogleFonts.workSans(
                                            //       textStyle: TextStyle(
                                            //         fontSize: 14,
                                            //         color: Colors.black,
                                            //         fontStyle: FontStyle.normal,
                                            //         fontWeight: FontWeight.w600,
                                            //       ),
                                            //     ),
                                            //     maxLines: 1,
                                            //     overflow: TextOverflow.ellipsis,
                                            //   ),
                                            // ),
                                          ],
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    );
                  },
                  separatorBuilder: (c, i) {
                    return SizedBox(height: 24);
                  },
                ),
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
            title: Text("ادخل رقم الهوية"),
            content: TextField(
              autofocus: true,
              decoration: InputDecoration(hintText: "ادخل رقم الهوية"),
              controller: nationNumber,
            ),
            actions: [
              TextButton(
                  onPressed: () {
                    Navigator.of(context).pop(nationNumber.text);
                    // print(nationNumber.text);
                  },
                  child: Text('بحث عن نتائج'))
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
