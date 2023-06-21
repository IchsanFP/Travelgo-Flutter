import 'dart:convert';

import '../models/transaction_model.dart';
import '../models/vendor_transaction_model.dart';
import '../shared/api_response.dart';
import 'package:http/http.dart' as http;

import '../shared/constant.dart';

Future<ApiResponse> transaction(
    int packageId, int userId, int total, String status) async {
  var url = Uri.parse(makeTransactionURL);
  ApiResponse apiResponse = ApiResponse();

  try {
    final response = await http.post(url, headers: {
      "Accept": "application/json"
    }, body: {
      "travel_packages_id": packageId.toString(),
      "users_id": userId.toString(),
      "transaction_total": total.toString(),
      "transaction_status": status,
    });

    print(response.body);

    switch (response.statusCode) {
      case 200:
        apiResponse.data = Transaction.fromJson(jsonDecode(response.body));
        break;
      case 422:
        final errors = jsonDecode(response.body)['errors'];
        apiResponse.error = errors[errors.keys.elemenAt(0)][0];
        break;
      case 403:
        apiResponse.error = jsonDecode(response.body)['message'];
        break;
      default:
        apiResponse.error = "Something went wrong, try again!";
        break;
    }
  } catch (e) {
    print(e);
    apiResponse.error = "Server error";
  }

  return apiResponse;
}

Future<ApiResponse> updateStatus(int id, String status) async {
  var url = Uri.parse("$updateTransactionURL/$id");
  ApiResponse apiResponse = ApiResponse();
  try {
    final res = await http.put(url, body: {"transaction_status": status});
    print(res.body);

    switch (res.statusCode) {
      case 200 :
        break;
    }

  } catch (e) {
    print(e);
    apiResponse.error = "Error";
  }

  return apiResponse;
}

Future<List<VendorTransaction>> getTransactionById(int id) async {
  var url = Uri.parse("$getPackageTransactionByIdURL/$id");
  final res = await http.get(url);
  if (res.statusCode == 200) {
    var data = jsonDecode(res.body);
    print(data);
    var parsed = data['transaction'].cast<Map<String, dynamic>>();
      return parsed
          .map<VendorTransaction>((json) => VendorTransaction.fromJson(json)).toList();
  } else {
    throw Exception('Failed');
  }
}
