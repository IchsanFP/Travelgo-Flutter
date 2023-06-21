import 'package:flutter/material.dart';

import '../../shared/theme.dart';

class RoleTitle extends StatelessWidget {
  final String title;

  const RoleTitle({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: brownTextStyle.copyWith(
          fontSize: 16,
          fontWeight: semibold,
          decoration: TextDecoration.underline),
      textAlign: TextAlign.center,
    );
  }
}
