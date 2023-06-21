import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:travelgo/shared/api_response.dart';
import 'package:http/http.dart' as http;
import 'package:travelgo/shared/constant.dart';

import '../models/user_model.dart';

Future<ApiResponse> login(String email, String password, String role) async {
  var url = Uri.parse(loginURL);
  ApiResponse apiResponse = ApiResponse();
  try {
    final response = await http.post(url,
        headers: {"Accept": "application/json"},
        body: {"email": email, "password": password, "roles": role});

    switch (response.statusCode) {
      case 200:
        apiResponse.data = User.fromJson(jsonDecode(response.body));
        apiResponse.error = null;
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
    apiResponse.error = "Server error";
  }
  return apiResponse;
}

Future<ApiResponse> register(
    String name, String email, String password, String usn, String role) async {
  var url = Uri.parse(registerURL);
  ApiResponse apiResponse = ApiResponse();
  try {
    final response = await http.post(url, headers: {
      "Accept": "application/json"
    }, body: {
      "name": name,
      "email": email,
      "username": usn,
      "password": password,
      "password_confirmation": password,
      "roles": role
    });

    switch (response.statusCode) {
      case 200:
        apiResponse.data = User.fromJson(jsonDecode(response.body));
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
    apiResponse.error = "Server error";
  }

  return apiResponse;
}

Future<ApiResponse> getDetailUser() async {
  var url = Uri.parse(userURL);
  ApiResponse apiResponse = ApiResponse();

  try {
    String token = await getToken();
    final response = await http.post(url, headers: {
      "Accept": "application/json",
      "Authorization": "Bearer $token"
    });

    switch (response.statusCode) {
      case 200:
        apiResponse.data = User.fromJson(jsonDecode(response.body));
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
    apiResponse.error = "Server error";
  }
  return apiResponse;
}

Future<String> getToken() async {
  SharedPreferences pref = await SharedPreferences.getInstance();
  return pref.getString("token") ?? "";
}

Future<int> getUserId() async {
  SharedPreferences pref = await SharedPreferences.getInstance();
  return pref.getInt("userId") ?? 0;
}

Future<bool> logout() async {
  SharedPreferences pref = await SharedPreferences.getInstance();
  return await pref.remove("token");
}

Future<ApiResponse> fetchUserById(int id) async {
  var url = Uri.parse("$getUserByIdURL/$id");
  ApiResponse apiResponse = ApiResponse();

  try {
    final res = await http.post(url, headers: {"Accept": "application/json"});
    switch (res.statusCode) {
      case 200 :
        apiResponse.data = User.fromJson(jsonDecode(res.body));
        break;
    }
  } catch (e) {
    apiResponse.error = "Error";
  }
  return apiResponse;
}
