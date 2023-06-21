import 'package:flutter/material.dart';
import 'package:travelgo/shared/theme.dart';

class DetailItem extends StatelessWidget {
  final String title;
  final String detail;
  final Icon iconUrl;

  const DetailItem({super.key, required this.title, required this.detail, required this.iconUrl});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        iconUrl,
        SizedBox(width: 8,),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title, style: blackTextStyle.copyWith(fontWeight: medium),),
            Text(detail, style: greyTextStyle.copyWith(fontWeight: medium),),
          ],
        )
      ],
    );
  }
}
