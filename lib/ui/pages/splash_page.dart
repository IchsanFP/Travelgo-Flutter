// ignore_for_file: use_build_context_synchronously

import 'dart:async';
import 'package:flutter/material.dart';
import 'package:travelgo/services/user_service.dart';
import 'package:travelgo/shared/api_response.dart';
import '../../models/user_model.dart';
import '../widgets/title.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  void _loadUserInfo() async {
    String token = await getToken();
    if (token == '') {
      Timer(Duration(seconds: 3), () {
        Navigator.pushNamedAndRemoveUntil(
            context, '/get-started', (route) => false);
      });
    } else {
      ApiResponse res = await getDetailUser();
      var data = res.data as User;
      if (res.error == null && data.role == "USER") {
        Navigator.pushNamedAndRemoveUntil(context, '/main', (route) => false);
      } else if (res.error == null && data.role == "VENDOR"){
        Navigator.pushNamedAndRemoveUntil(context, '/main-vendor', (route) => false);
      } else if (res.error == "Unauthorized") {
        Timer(Duration(seconds: 3), () {
          Navigator.pushNamedAndRemoveUntil(
              context, '/get-started', (route) => false);
        });
      } else {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text("${res.error}")));
      }
    }
  }

  @override
  void initState() {
    _loadUserInfo();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: title(24)),
    );
  }
}
