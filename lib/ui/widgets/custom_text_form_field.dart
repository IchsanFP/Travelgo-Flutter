import 'package:flutter/material.dart';

import '../../shared/theme.dart';

class CustomTextFormField extends StatelessWidget {
  final String title;
  final String hintText;
  final bool isHidden;
  final TextEditingController? controller;
  final String? Function(String?)? validator;

  const CustomTextFormField(
      {super.key,
      required this.title,
      required this.hintText,
      this.isHidden = false,
      this.controller,
      this.validator});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(bottom: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: blackTextStyle.copyWith(fontSize: 16),
          ),
          SizedBox(
            height: 12,
          ),
          TextFormField(
            cursorColor: warnaHitam,
            obscureText: isHidden,
            decoration: InputDecoration(
                hintText: hintText,
                hintStyle: greyTextStyle,
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(defaultRadius)),
                focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(defaultRadius),
                    borderSide: BorderSide(color: warnaCoklat, width: 2))),
            controller: controller,
            validator: validator,
          ),
        ],
      ),
    );
  }
}
