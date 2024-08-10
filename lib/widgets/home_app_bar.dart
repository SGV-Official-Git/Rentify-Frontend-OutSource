import 'package:flutter/material.dart';
import 'package:rentify/gen/assets.gen.dart';
import 'package:rentify/main.dart';
import 'package:rentify/theme/colors.dart';
import 'package:rentify/theme/textstyles.dart';
import 'package:rentify/widgets/image.dart';

class HomeAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String? title;
  final VoidCallback? onTapScan, onTapNotification;
  const HomeAppBar(
      {super.key, this.title, this.onTapNotification, this.onTapScan});

  @override
  Widget build(BuildContext context) {
    return PreferredSize(
        preferredSize: Size(dimensions.width, dimensions.height * 0.07),
        child: SafeArea(
          child: Container(
            margin: const EdgeInsets.symmetric(horizontal: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ImageWidget(
                  url: Assets.icons.logo,
                  height: dimensions.width * 0.1,
                  width: dimensions.width * 0.1,
                ),
                SizedBox(
                  width: dimensions.width * 0.03,
                ),
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Hi Welcome Back!",
                        style: textStyle(
                            color: AppColors.appBarGrey,
                            fontSize: dimensions.width * 0.035),
                      ),
                      Text(
                        title ?? "",
                        style: textStyle(
                            color: AppColors.black,
                            fontWeight: FontWeight.w500,
                            fontSize: dimensions.width * 0.04),
                      )
                    ],
                  ),
                ),
                ImageWidget(
                  url: Assets.icons.scanner,
                  height: 40,
                  width: 40,
                ),
                SizedBox(
                  width: dimensions.width * 0.03,
                ),
                ImageWidget(
                  url: Assets.icons.notification,
                  height: 40,
                  width: 40,
                )
              ],
            ),
          ),
        ));
  }

  @override
  Size get preferredSize => Size(dimensions.width, dimensions.height * 0.07);
}
