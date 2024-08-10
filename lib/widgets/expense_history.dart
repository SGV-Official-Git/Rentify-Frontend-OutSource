// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:rentify/main.dart';
import 'package:rentify/theme/colors.dart';
import 'package:rentify/theme/textstyles.dart';
import 'package:rentify/utilities/helper_func.dart';
import 'package:rentify/widgets/image.dart';

class ExpenseHistory extends StatelessWidget {
  String? image, title, propertyName, amount;
  DateTime? date;
  ExpenseHistory(
      {super.key,
      this.amount,
      this.date,
      this.image,
      this.propertyName,
      this.title});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(6),
          child: ImageWidget(
            url: image ?? "",
            height: dimensions.width * 0.17,
            width: dimensions.width * 0.2,
            fit: BoxFit.fill,
          ),
        ),
        SizedBox(
          width: dimensions.width * 0.03,
        ),
        Expanded(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title ?? "",
                style: textStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: dimensions.width * 0.04),
              ),
              Text(
                propertyName ?? "",
                style: textStyle(
                    fontWeight: FontWeight.w400,
                    fontSize: dimensions.width * 0.035,
                    color: AppColors.appBarGrey),
              ),
            ],
          ),
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text(
              "\$$amount",
              style: textStyle(
                  fontWeight: FontWeight.w600,
                  color: AppColors.primary,
                  fontSize: dimensions.width * 0.04),
            ),
            Text(
              HelperMethods.instance.dateFormatMonth(date),
              style: textStyle(
                  fontWeight: FontWeight.w400,
                  fontSize: dimensions.width * 0.035,
                  color: AppColors.appBarGrey),
            ),
          ],
        ),
      ],
    );
  }
}
