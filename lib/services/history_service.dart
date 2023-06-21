import 'dart:convert';

import '../models/history_model.dart';
import '../shared/constant.dart';
import 'package:http/http.dart' as http;

Future<List<History>> getHistory(int id) async {
  var url = Uri.parse("$getHistoryURL/$id");
    final res =
        await http.get(url);
    if (res.statusCode == 200) {
      var data = jsonDecode(res.body);
      var parsed = data['transaction'].cast<Map<String, dynamic>>();
      return parsed
          .map<History>((json) => History.fromJson(json))
          .toList();
    } else {
      throw Exception('Failed');
    }
  }