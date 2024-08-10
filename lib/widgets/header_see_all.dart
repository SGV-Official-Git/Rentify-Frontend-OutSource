import 'package:flutter/material.dart';
import 'package:rentify/main.dart';
import 'package:rentify/theme/colors.dart';
import 'package:rentify/theme/textstyles.dart';

class HeaderSeeAll extends StatelessWidget {
  final String? titleStart, titleEnd;
  const HeaderSeeAll({super.key, this.titleStart, this.titleEnd});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Text(
            "$titleStart",
            style: textStyle(
                color: AppColors.primaryDark,
                fontSize: dimensions.width * 0.035,
                fontWeight: FontWeight.w600),
          ),
        ),
        Text(
          "$titleEnd",
          style: textStyle(
              color: AppColors.primary,
              fontSize: dimensions.width * 0.035,
              fontWeight: FontWeight.w400),
        )
      ],
    );
  }
}
