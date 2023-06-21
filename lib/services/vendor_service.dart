import 'dart:convert';

import '../models/package_model.dart';
import 'package:http/http.dart' as http;

import '../shared/constant.dart';

Future<List<Package>> getVendorPackages(int id) async {
  var url = Uri.parse("$getVendorPackagesURL/$id");
  final res = await http.get(url);

  if (res.statusCode == 200) {
    var data = jsonDecode(res.body);
    var parsed = data['items'].cast<Map<String, dynamic>>();
    return parsed.map<Package>((json) => Package.fromJson(json)).toList();
  } else {
    throw Exception('Failed');
  }
}
