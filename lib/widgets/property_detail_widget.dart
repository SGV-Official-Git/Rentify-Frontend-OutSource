import 'package:flutter/material.dart';
import 'package:rentify/main.dart';
import 'package:rentify/theme/colors.dart';
import 'package:rentify/theme/textstyles.dart';
import 'package:rentify/widgets/image.dart';

class PropertyDetailWidget extends StatelessWidget {
  const PropertyDetailWidget({
    super.key,
    this.assetName,
    this.icon,
    this.value,
  });

  final String? assetName, icon, value;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      // decoration: BoxDecoration(
      //     borderRadius: BorderRadius.circular(10),
      //     border: Border.all(color: const Color(0xffF0F0F0))),
      child: Row(
        children: [
          ImageWidget(
            url: icon ?? "",
            color: AppColors.gray,
            height: 20,
            width: 20,
          ),
          SizedBox(
            width: dimensions.width * 0.02,
          ),
          Expanded(
            child: Text(
              assetName ?? "",
              style: textStyle(
                fontSize: dimensions.width * 0.035,
                color: AppColors.gray,
              ),
            ),
          ),
          SizedBox(
            width: dimensions.width * 0.02,
          ),
          Text(
            value ?? "",
            style: textStyle(
              fontSize: dimensions.width * 0.035,
              color: AppColors.primary,
            ),
          )
        ],
      ),
    );
  }
}
