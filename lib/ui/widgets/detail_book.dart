import 'package:flutter/material.dart';
import 'package:travelgo/shared/theme.dart';

class DetailBook extends StatelessWidget {
  final String title;
  final String detail;

  const DetailBook({super.key, required this.title, required this.detail});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: blackTextStyle.copyWith(fontWeight: semibold),
          ),
          Text(detail, style: blackTextStyle,)
        ],
      ),
    );
  }
}
