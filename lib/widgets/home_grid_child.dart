import 'package:flutter/material.dart';
import 'package:rentify/data/home_grid_modal.dart';
import 'package:rentify/main.dart';
import 'package:rentify/theme/textstyles.dart';
import 'package:rentify/widgets/image.dart';

class HomeGridChild extends StatelessWidget {
  const HomeGridChild({
    super.key,
    required this.homeModal,
  });

  final HomeGridModal homeModal;

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      decoration: BoxDecoration(
          border: Border.all(color: const Color(0xffEBEBEB), width: 1),
          borderRadius: BorderRadius.circular(14)),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ImageWidget(
            url: homeModal.icon,
            height: dimensions.width * 0.13,
            width: dimensions.width * 0.13,
          ),
          SizedBox(
            height: dimensions.width * 0.02,
          ),
          Text(
            homeModal.title,
            style: textStyle(fontSize: dimensions.width * 0.035),
          )
        ],
      ),
    );
  }
}
