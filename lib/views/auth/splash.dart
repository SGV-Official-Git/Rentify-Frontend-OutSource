import 'package:flutter/material.dart';
import 'package:rentify/gen/assets.gen.dart';
import 'package:rentify/utilities/keys.dart';
import 'package:rentify/utilities/navigator.dart';
import 'package:rentify/utilities/routes.dart';
import 'package:rentify/utilities/sp.dart';
import 'package:rentify/widgets/image.dart';

class Splash extends StatefulWidget {
  const Splash({super.key});

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 2), () {
      final token = SP.i.getString(key: SPKeys.accessToken);
      if (token != null) {
        AppNavigator.shared.pushNamedAndRemove(routeName: Routes.dashboard);
      } else {
        AppNavigator.shared.pushNamedAndRemove(routeName: Routes.login);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ImageWidget(
          url: Assets.icons.logo,
        ),
      ),
    );
  }
}
