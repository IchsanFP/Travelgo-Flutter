import 'dart:convert';

import 'package:travelgo/shared/constant.dart';

import '../models/package_model.dart';
import 'package:http/http.dart' as http;

class HomePageService {
  Future<List<Package>> getTravelPackage() async { // menandakan bahwa metode ini akan berjalan secara asinkron.
    final res =
        await http.get(Uri.parse(getPackagesURL));
    if (res.statusCode == 200) {
      var data = jsonDecode(res.body);
      var parsed = data['items'].cast<Map<String, dynamic>>();
      return parsed
          .map<Package>((json) => Package.fromJson(json))
          .toList();
    } else {
      throw Exception('Failed');
    }
  }
}
