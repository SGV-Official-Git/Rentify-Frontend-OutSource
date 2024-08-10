import 'package:flutter/material.dart';
import 'package:rentify/gen/assets.gen.dart';
import 'package:rentify/main.dart';
import 'package:rentify/theme/colors.dart';
import 'package:rentify/theme/textstyles.dart';
import 'package:rentify/utilities/helper_func.dart';
import 'package:rentify/widgets/image.dart';

class RentDueListTile extends StatelessWidget {
  final String image, title, address, ownerName;
  final DateTime? date;
  const RentDueListTile({
    this.address = '',
    this.date,
    this.image = '',
    this.ownerName = '',
    this.title = '',
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: const Color(0xffEBEBEB))),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(6),
              child: ImageWidget(
                url: image,
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
                    title,
                    style: textStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: dimensions.width * 0.04),
                  ),
                  Text(
                    address,
                    style: textStyle(
                        fontWeight: FontWeight.w400,
                        fontSize: dimensions.width * 0.035,
                        color: AppColors.appBarGrey),
                  ),
                  Row(
                    children: [
                      Row(
                        children: [
                          ImageWidget(
                            url: Assets.icons.rentUser,
                            height: dimensions.width * 0.04,
                            width: dimensions.width * 0.04,
                          ),
                          SizedBox(
                            width: dimensions.width * 0.01,
                          ),
                          Text(ownerName,
                              style: textStyle(
                                  fontWeight: FontWeight.w400,
                                  fontSize: dimensions.width * 0.035,
                                  color: AppColors.appBarGrey))
                        ],
                      ),
                      SizedBox(
                        width: dimensions.width * 0.03,
                      ),
                      Row(
                        children: [
                          ImageWidget(
                            url: Assets.icons.calender,
                            height: dimensions.width * 0.04,
                            width: dimensions.width * 0.04,
                          ),
                          SizedBox(
                            width: dimensions.width * 0.01,
                          ),
                          Text(
                              HelperMethods.instance
                                  .dateFormatMonth(DateTime.now()),
                              style: textStyle(
                                  fontWeight: FontWeight.w400,
                                  fontSize: dimensions.width * 0.035,
                                  color: AppColors.appBarGrey))
                        ],
                      )
                    ],
                  )
                ],
              ),
            )
          ],
        ));
  }
}
