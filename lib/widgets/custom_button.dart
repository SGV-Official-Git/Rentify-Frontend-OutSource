import 'package:flutter/material.dart';
import 'package:rentify/gen/assets.gen.dart';
import 'package:rentify/main.dart';
import 'package:rentify/theme/colors.dart';
import 'package:rentify/theme/textstyles.dart';
import 'package:rentify/widgets/image.dart';

class CustomButton extends StatelessWidget {
  final VoidCallback? onPressed;
  final bool isGoogle, isApple;
  final Color? backgroundColor, textColor, iconColor;
  final String? title, icon;
  const CustomButton(
      {super.key,
      this.iconColor,
      this.icon,
      this.onPressed,
      this.backgroundColor = AppColors.primary,
      this.textColor = Colors.white,
      this.isGoogle = false,
      this.isApple = false,
      this.title});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        style: ButtonStyle(
            backgroundColor: MaterialStatePropertyAll(isApple
                ? AppColors.black
                : isGoogle
                    ? Colors.white
                    : backgroundColor ?? AppColors.primary),
            foregroundColor: const MaterialStatePropertyAll(Colors.white),
            shape: MaterialStatePropertyAll(RoundedRectangleBorder(
                side: isGoogle ? const BorderSide(width: 1) : BorderSide.none,
                borderRadius: BorderRadius.circular(12))),
            fixedSize: MaterialStatePropertyAll(
                Size(dimensions.width, dimensions.height * 0.054))),
        onPressed: onPressed,
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (isApple || isGoogle)
              ImageWidget(
                url: isApple ? Assets.icons.btnApple : Assets.icons.btnGoogle,
                height: 25,
                width: 25,
              ),
            if (icon != null)
              ImageWidget(
                url: icon ?? "",
                height: 20,
                width: 20,
                color: iconColor ?? AppColors.primary,
              ),
            if (isApple || isGoogle || icon != null)
              SizedBox(
                width: dimensions.width * 0.03,
              ),
            Text(
              title ?? "",
              style: textStyle(
                  fontSize: dimensions.width * 0.04,
                  color:
                      isGoogle ? AppColors.black : textColor ?? Colors.white),
            ),
          ],
        ));
  }
}
