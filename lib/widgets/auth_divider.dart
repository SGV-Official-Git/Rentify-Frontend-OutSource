import 'package:flutter/material.dart';
import 'package:rentify/theme/colors.dart';
import 'package:rentify/theme/textstyles.dart';

class AuthDivider extends StatelessWidget {
  const AuthDivider({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Expanded(
          child: Divider(
            color: AppColors.hint,
            thickness: 1,
            height: 2,
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Text(
            "Or",
            style: textStyle(color: AppColors.hint),
          ),
        ),
        const Expanded(
          child: Divider(
            color: AppColors.hint,
            thickness: 1,
            height: 2,
          ),
        ),
      ],
    );
  }
}
