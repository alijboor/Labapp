// import 'package:http/http.dart' as http;
// import 'dart:convert';

// import 'package:lapapp/data/report.dart';

// String Link = "http://localhost/lab";

// List<Report> parseProducts(String responseBody) {
//   final parsed = json.decode(responseBody).cast<Map<String, dynamic>>();
//   return parsed.map<Report>((json) => Report.fromMap(json)).toList();
// }

// Future<List<Report>> fetchProducts() async {
//   final response = await http.get('$Link/reports.php');
//   if (response.statusCode == 200) {
//     return parseProducts(response.body);
//   } else {
//     throw Exception('Unable to fetch products from the REST API');
//   }
// }
