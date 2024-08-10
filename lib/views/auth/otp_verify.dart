import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rentify/widgets/custom_button.dart';

import '../../gen/assets.gen.dart';
import '../../main.dart';
import '../../providers/auth_provider.dart';
import '../../theme/colors.dart';
import '../../theme/textstyles.dart';
import '../../widgets/error_dialog.dart';
import '../../widgets/image.dart';
import '../../widgets/otp_textfield.dart';

class OtpVerify extends StatefulWidget {
  const OtpVerify({super.key});

  @override
  State<OtpVerify> createState() => _OtpVerifyState();
}

class _OtpVerifyState extends State<OtpVerify> {
  List<String> otp = [];
  Map<String, dynamic> arguments = {};
  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () {
      arguments =
          ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>;

      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(15),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            ImageWidget(
              url: Assets.icons.logo,
            ),
            SizedBox(
              height: dimensions.height * 0.01,
            ),
            Text(
              "Welcome to Rentify 👋🏻",
              style: textStyle(
                  fontWeight: FontWeight.w700,
                  fontSize: dimensions.width * 0.05,
                  color: AppColors.black),
            ),
            Text(
              "Enter your OTP sent on email",
              style: textStyle(
                  fontWeight: FontWeight.w700,
                  fontSize: dimensions.width * 0.035,
                  color: AppColors.gray),
            ),
            Text(
              "${arguments["phone"] ?? ""}",
              style: textStyle(
                  fontWeight: FontWeight.w700,
                  fontSize: dimensions.width * 0.035,
                  color: AppColors.primary),
            ),
            SizedBox(
              height: dimensions.height * 0.04,
            ),
            Text("Use ${arguments["otp"] ?? ""} to verify"),
            SizedBox(
              height: dimensions.height * 0.04,
            ),
            OTPTextField(
              length: 6,
              otp: otp,
              onChange: (p0) {
                setState(() {
                  otp = p0 ?? [];
                });
              },
            ),
            SizedBox(
              height: dimensions.height * 0.04,
            ),
            CustomButton(
              title: "Verify",
              onPressed: () {
                if (otp.isNotEmpty) {
                  context.read<AuthProvider>().otpVerify(
                        phone: arguments['phone'],
                        otp: otp.join(""),
                      );
                } else {
                  alert(type: AlertType.error, message: "Please enter otp");
                }
              },
            )
          ],
        ),
      ),
    );
  }
}
