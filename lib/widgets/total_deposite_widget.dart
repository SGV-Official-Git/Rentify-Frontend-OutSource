import 'package:flutter/material.dart';
import 'package:rentify/main.dart';
import 'package:rentify/theme/colors.dart';
import 'package:rentify/theme/textstyles.dart';
import 'package:rentify/widgets/image.dart';

class TotalDepositeWidget extends StatelessWidget {
  const TotalDepositeWidget({super.key, this.amount = "", this.icon = ""});
  final String amount, icon;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: AppColors.bottomNav)),
      child: ListTile(
        leading: ImageWidget(
          url: icon,
        ),
        title: Text(
          "Total Deposit",
          style: textStyle(
              fontWeight: FontWeight.w400,
              color: AppColors.gray,
              fontSize: dimensions.width * 0.035),
        ),
        trailing: Text(
          "\$ $amount",
          style: textStyle(
              fontWeight: FontWeight.w700,
              color: AppColors.primary,
              fontSize: dimensions.width * 0.04),
        ),
      ),
    );
  }
}
