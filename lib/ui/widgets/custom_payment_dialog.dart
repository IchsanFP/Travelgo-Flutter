import 'package:flutter/material.dart';

import '../../shared/theme.dart';
import '../pages/user/user_main_page.dart';

class CustomPaymentDialog extends StatelessWidget {
  final String title;
  final IconData? icon;

  const CustomPaymentDialog({super.key, required this.title, this.icon});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(defaultRadius)),
      title: Text(title, style: blackTextStyle.copyWith(fontWeight: bold, fontSize: 20), textAlign: TextAlign.center,),
      content: SingleChildScrollView(
        child: Column(
          children: [
            TextButton(
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => UserMainPage()));
                },
                child: Text(
                  "Close",
                  style: brownTextStyle.copyWith(
                      fontWeight: medium,
                      fontSize: 16,
                      decoration: TextDecoration.underline),
                ))
          ],
        ),
      ),
    );
  }
}
