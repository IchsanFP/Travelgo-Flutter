import 'package:flutter/material.dart';

import '../../shared/theme.dart';

class CustomButton extends StatelessWidget {
  final String text;
  final double width;
  final double textSize;
  final Function() onPressed;
  final EdgeInsets? margin;

  const CustomButton(
      {super.key,
      required this.text,
      this.width = double.infinity,
      required this.textSize,
      required this.onPressed,
      this.margin});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: 55,
      margin: margin,
      child: TextButton(
          onPressed: onPressed,
          style: TextButton.styleFrom(
              backgroundColor: warnaCoklat,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(defaultRadius))),
          child: Text(
            text,
            style:
                whiteTextStyle.copyWith(fontWeight: medium, fontSize: textSize),
          )),
    );
  }
}
