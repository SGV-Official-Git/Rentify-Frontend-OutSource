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
import 'package:rentify/utilities/keys.dart';
import 'package:rentify/utilities/navigator.dart';
import 'package:rentify/utilities/routes.dart';
import 'package:rentify/utilities/social_login.dart';
import 'package:rentify/utilities/sp.dart';
import 'package:rentify/utilities/validations.dart';
import 'package:rentify/widgets/image.dart';

import '../../widgets/auth_divider.dart';
import '../../widgets/custom_button.dart';
import '../../widgets/custom_text_field.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  bool rememberMe = false, obsecure = true;

  final formKey = GlobalKey<FormState>();

  TextEditingController email = TextEditingController(),
      password = TextEditingController();

  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      final savedEmail = SP.i.getString(key: SPKeys.email);
      final savedPassword = SP.i.getString(key: SPKeys.password);
      final rememberMe = SP.i.getBool(key: SPKeys.rememberMe);

      email.text = savedEmail ?? "";
      password.text = savedPassword ?? "";
      this.rememberMe = rememberMe;
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(14.0),
        child: SingleChildScrollView(
          child: Form(
            // autovalidateMode: AutovalidateMode.always,
            key: formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              // mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  height: dimensions.height * 0.1,
                ),
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
                  "Enter your Email & Password to Sign in",
                  style: textStyle(
                      fontWeight: FontWeight.w700,
                      fontSize: dimensions.width * 0.035,
                      color: AppColors.gray),
                ),
                SizedBox(
                  height: dimensions.height * 0.04,
                ),
                CustomTextField(
                  textInputType: TextInputType.emailAddress,
                  hintText: "Email",
                  controller: email,
                  validator: (p0) => Validation.instance.emailValidation(p0),
                  icon: Assets.icons.email,
                ),
                SizedBox(
                  height: dimensions.height * 0.02,
                ),
                CustomTextField(
                  obsecure: obsecure,
                  textInputType: TextInputType.visiblePassword,
                  hintText: "Password",
                  onLeadingPress: () => setState(() {
                    obsecure = !obsecure;
                  }),
                  controller: password,
                  validator: (p0) => Validation.instance.passwordValidation(p0),
                  trailingIcon: obsecure
                      ? Assets.icons.visible
                      : Assets.icons.viewPassword,
                  icon: Assets.icons.password,
                ),
                SizedBox(
                  height: dimensions.height * 0.02,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Checkbox(
                            activeColor: AppColors.primary,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(5)),
                            value: rememberMe,
                            onChanged: (value) {
                              setState(() {
                                rememberMe = value ?? false;
                              });
                            }),
                        Text(
                          "Remember me",
                          style: textStyle(),
                        )
                      ],
                    ),
                    Text(
                      "Forgot Password?",
                      style: textStyle(
                          color: AppColors.blue, fontWeight: FontWeight.w500),
                    )
                  ],
                ),
                SizedBox(
                  height: dimensions.height * 0.06,
                ),
                CustomButton(
                    title: "Sign In",
                    onPressed: () {
                      if (formKey.currentState!.validate()) {
                        if (rememberMe) {
                          SP.i.setString(
                              key: SPKeys.email, value: email.text.trim());
                          SP.i.setString(
                              key: SPKeys.password,
                              value: password.text.trim());
                          SP.i.setBool(
                              key: SPKeys.rememberMe, value: rememberMe);
                        } else {
                          SP.i.setString(key: SPKeys.email, value: "");
                          SP.i.setString(key: SPKeys.password, value: "");
                          SP.i.setBool(
                              key: SPKeys.rememberMe, value: rememberMe);
                        }
                        context
                            .read<AuthProvider>()
                            .loginApi(email.text, password.text);
                      }
                    }),
                SizedBox(
                  height: dimensions.height * 0.02,
                ),
                Text.rich(TextSpan(
                    text: 'Don’t Have an Account? ',
                    style: textStyle(fontWeight: FontWeight.w400),
                    children: [
                      TextSpan(
                        text: 'Sign Up',
                        recognizer: TapGestureRecognizer()
                          ..onTap = () => AppNavigator.shared
                              .pushNamed(routeName: Routes.register),
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
                  CustomButton(
                    isApple: true,
                    title: "Continue with Apple",
                    onPressed: () async {
                      final appleLogin = await SocialLogin.shared.appleLogin();
                      if (appleLogin != null) {
                        context.read<AuthProvider>().socialLoginApi(
                            loginType: SocialType.apple,
                            email: appleLogin.email ?? "",
                            fullName: appleLogin.familyName ?? "",
                            socialId: appleLogin.userIdentifier ?? "",
                            usetType: "1");
                      }
                    },
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
