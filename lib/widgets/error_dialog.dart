import 'package:flutter/material.dart';

import 'package:lottie/lottie.dart';

import '../main.dart';
import '../theme/colors.dart';
import '../theme/textstyles.dart';
import '../utilities/navigator.dart';

enum AlertType { error, warning, success, info }

// ignore: must_be_immutable
class ErrorDialog extends StatelessWidget {
  AlertType type;
  String message;

  ErrorDialog({super.key, required this.message, required this.type});

  String getLottie(AlertType type) {
    switch (type) {
      case AlertType.error:
        return "assets/errors/error.json";
      case AlertType.success:
        return "assets/errors/success.json";
      case AlertType.warning:
        return "assets/errors/warning.json";
      default:
        return "assets/errors/info.json";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        LottieBuilder.asset(
          getLottie(type),
          height: 30,
          width: 30,
        ),
        SizedBox(
          width: dimensions.width * 0.03,
        ),
        Expanded(
          child: Text(
            message,
            style: textStyle(
              color: Colors.black,
              fontSize: dimensions.width * 0.035,
            ),
          ),
        ),
      ],
    );
  }
}

void alert({required AlertType type, required String message}) {
  AppNavigator.shared.scaffoldMessangerKey.currentState?.showSnackBar(SnackBar(
      backgroundColor: AppColors.lightButton,
      dismissDirection: DismissDirection.startToEnd,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      behavior: SnackBarBehavior.floating,
      elevation: 20,
      hitTestBehavior: HitTestBehavior.translucent,
      content: ErrorDialog(
        message: message,
        type: type,
      )));
}
