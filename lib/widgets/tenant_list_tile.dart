import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:rentify/gen/assets.gen.dart';
import 'package:rentify/main.dart';
import 'package:rentify/theme/colors.dart';
import 'package:rentify/theme/textstyles.dart';
import 'package:rentify/widgets/image.dart';

class TenantListTile extends StatelessWidget {
  final String image, title, address, phone;
  final void Function()? onTap;
  const TenantListTile({
    this.address = '',
    this.image = '',
    this.phone = '',
    this.title = '',
    this.onTap,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap ?? () {},
      child: Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: const Color(0xffEBEBEB))),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                clipBehavior: Clip.hardEdge,
                // padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(6),
                    color: const Color(0xffF2F2F7)),
                child: ImageWidget(
                  url: image,
                  height: dimensions.width * 0.15,
                  width: dimensions.width * 0.15,
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
                        ImageWidget(
                          url: Assets.icons.telIcon2x,
                          height: dimensions.width * 0.04,
                          width: dimensions.width * 0.04,
                        ),
                        SizedBox(
                          width: dimensions.width * 0.01,
                        ),
                        Text(phone,
                            style: textStyle(
                                fontWeight: FontWeight.w400,
                                fontSize: dimensions.width * 0.035,
                                color: AppColors.appBarGrey))
                      ],
                    )
                  ],
                ),
              )
            ],
          )),
    );
  }
}
