import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_cached_pdfview/flutter_cached_pdfview.dart';

class PDFPageViewer extends StatelessWidget {
  const PDFPageViewer({Key? key, required this.link})
      : super(
          key: key,
        );
  final String link;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: const PDF().cachedFromUrl(
        link,
        errorWidget: (error) => Center(
            child: Text(
          "لا يوجد ملف ",
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
        )),
      ),
    );
  }
}
