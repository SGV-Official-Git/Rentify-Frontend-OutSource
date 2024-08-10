import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:rentify/api/endpoints.dart';
import 'package:rentify/data/property_item_modal.dart';
import 'package:rentify/gen/assets.gen.dart';
import 'package:rentify/main.dart';
import 'package:rentify/widgets/image.dart';

import '../theme/colors.dart';
import '../theme/textstyles.dart';

class PropertyDropDown extends StatelessWidget {
  final PropertyItem? property;
  final bool isShowArrow;
  const PropertyDropDown({super.key, this.isShowArrow = true, this.property});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
          border: Border.all(color: const Color(0xffEBEBEB)),
          borderRadius: BorderRadius.circular(12)),
      child: Row(
        // crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(5),
            child: ImageWidget(
              url: "${Endpoints.imageUrl}${property?.propertyImage ?? ""}",
              height: dimensions.width * 0.15,
              width: dimensions.width * 0.15,
              fit: BoxFit.cover,
            ),
          ),
          SizedBox(
            width: dimensions.width * 0.03,
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  property?.propertyName ?? "Select Property",
                  style: textStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: dimensions.width * 0.04),
                ),
                Text(
                  property?.propertyAddress ?? "Select Property",
                  style: textStyle(
                      fontWeight: FontWeight.w400,
                      fontSize: dimensions.width * 0.035,
                      color: AppColors.appBarGrey),
                )
              ],
            ),
          ),
          if (isShowArrow)
            ImageWidget(
              url: Assets.icons.arrowDown,
            )
        ],
      ),
    );
  }
}
