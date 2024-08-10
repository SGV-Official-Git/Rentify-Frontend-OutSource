// ignore_for_file: use_build_context_synchronously

import 'dart:io';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rentify/gen/assets.gen.dart';
import 'package:rentify/main.dart';
import 'package:rentify/providers/auth_provider.dart';
import 'package:rentify/theme/colors.dart';
import 'package:rentify/theme/textstyles.dart';
import 'package:rentify/utilities/validations.dart';
import 'package:rentify/widgets/image.dart';

import '../../utilities/social_login.dart';
import '../../widgets/auth_divider.dart';
import '../../widgets/custom_button.dart';
import '../../widgets/custom_text_field.dart';

class Register extends StatefulWidget {
  const Register({super.key});

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final formKey = GlobalKey<FormState>();

  final name = TextEditingController(),
      email = TextEditingController(),
      password = TextEditingController(),
      cnfPassword = TextEditingController(),
      phone = TextEditingController();

  bool obsecure = true, cnfObsecure = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(14.0),
        child: SingleChildScrollView(
          child: Form(
            //autovalidateMode: AutovalidateMode.always,
            key: formKey,
            child: Column(
              // mainAxisAlignment: MainAxisAlignment.center,
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
                  "Enter your Email & Password to Sign up",
                  style: textStyle(
                      fontWeight: FontWeight.w700,
                      fontSize: dimensions.width * 0.035,
                      color: AppColors.gray),
                ),
                SizedBox(
                  height: dimensions.height * 0.04,
                ),
                CustomTextField(
                  validator: (p0) => Validation.instance.emptyField(p0),
                  textInputType: TextInputType.name,
                  icon: Assets.icons.tenant,
                  hintText: "Name",
                  controller: name,
                ),
                SizedBox(
                  height: dimensions.height * 0.02,
                ),
                CustomTextField(
                  validator: (p0) => Validation.instance.emailValidation(p0),
                  textInputType: TextInputType.emailAddress,
                  hintText: "Email",
                  controller: email,
                  icon: Assets.icons.email,
                ),
                SizedBox(
                  height: dimensions.height * 0.02,
                ),
                CustomTextField(
                  textInputType: TextInputType.phone,
                  controller: phone,
                  validator: (p0) =>
                      Validation.instance.phoneNumberValidation(p0),
                  hintText: "Phone Number",
                  icon: Assets.icons.call,
                ),
                SizedBox(
                  height: dimensions.height * 0.02,
                ),
                CustomTextField(
                  obsecure: obsecure,
                  controller: password,
                  onLeadingPress: () => setState(() {
                    obsecure = !obsecure;
                  }),
                  validator: (p0) => Validation.instance.passwordValidation(p0),
                  textInputType: TextInputType.visiblePassword,
                  hintText: "Password",
                  trailingIcon: obsecure
                      ? Assets.icons.visible
                      : Assets.icons.viewPassword,
                  icon: Assets.icons.password,
                ),
                SizedBox(
                  height: dimensions.height * 0.02,
                ),
                CustomTextField(
                  obsecure: cnfObsecure,
                  onLeadingPress: () => setState(() {
                    cnfObsecure = !cnfObsecure;
                  }),
                  textInputType: TextInputType.visiblePassword,
                  controller: cnfPassword,
                  validator: (p0) => Validation.instance
                      .cnfPasswordValidation(p0, password.text),
                  hintText: "Confirm Password",
                  trailingIcon: cnfObsecure
                      ? Assets.icons.visible
                      : Assets.icons.viewPassword,
                  icon: Assets.icons.password,
                ),
                SizedBox(
                  height: dimensions.height * 0.06,
                ),
                CustomButton(
                  title: "Sign Up",
                  onPressed: () {
                    if (formKey.currentState?.validate() == true) {
                      context.read<AuthProvider>().registerApi(
                          fullName: name.text.trim(),
                          email: email.text.trim(),
                          phone: phone.text.trim(),
                          password: password.text.trim());
                    }
                  },
                ),
                SizedBox(
                  height: dimensions.height * 0.02,
                ),
                Text.rich(TextSpan(
                    text: 'Already Have an Account? ',
                    style: textStyle(fontWeight: FontWeight.w400),
                    children: [
                      TextSpan(
                        text: 'Sign In',
                        recognizer: TapGestureRecognizer()
                          ..onTap = () => Navigator.of(context).pop(),
                        style: textStyle(
                            fontWeight: FontWeight.w400, color: AppColors.blue),
                      )
                    ])),
                SizedBox(
                  height: dimensions.height * 0.04,
                ),
                const AuthDivider(),
                if (Platform.isIOS)
                  SizedBox(
                    height: dimensions.height * 0.02,
                  ),
                if (Platform.isIOS)
                  const CustomButton(
                    isApple: true,
                    title: "Continue with Apple",
                  ),
                SizedBox(
                  height: dimensions.height * 0.02,
                ),
                CustomButton(
                  isGoogle: true,
                  onPressed: () async {
                    final googleogin = await SocialLogin.shared.googleSignIn();
                    if (googleogin != null) {
                      context.read<AuthProvider>().socialLoginApi(
                          loginType: SocialType.google,
                          email: googleogin.email,
                          fullName: googleogin.displayName ?? "",
                          socialId: googleogin.id,
                          usetType: "1");
                    }
                  },
                  title: "Continue with Google",
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
