import 'package:flutter/material.dart';

import '../../shared/theme.dart';

Widget title(double? size) {
  return Center(
    child: Text(
      "TRAVELGO",
      style: blackTextStyle.copyWith(
          letterSpacing: 10, fontWeight: bold, fontSize: size),
    ),
  );
}
