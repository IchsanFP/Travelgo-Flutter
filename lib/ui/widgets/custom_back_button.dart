import 'package:flutter/material.dart';
import 'package:travelgo/shared/theme.dart';

class CustomBackButton extends StatelessWidget {
  const CustomBackButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12),
      child: Container(
        height: 48,
        width: 48,
        decoration: BoxDecoration(
            color: warnaBg.withOpacity(0.3), shape: BoxShape.circle),
        child: IconButton(
          icon: Icon(
            Icons.arrow_back_ios_new_rounded,
            color: warnaBg,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
    );
  }
}
