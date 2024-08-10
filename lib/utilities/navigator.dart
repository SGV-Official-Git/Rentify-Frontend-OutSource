import 'package:flutter/material.dart';

class AppNavigator {
  static final shared = AppNavigator();
  final navigatorKey = GlobalKey<NavigatorState>();

  GlobalKey<ScaffoldState>? scaffoldKey = GlobalKey<ScaffoldState>();

  final scaffoldMessangerKey = GlobalKey<ScaffoldMessengerState>();

  BuildContext getContext() {
    return navigatorKey.currentState!.context;
  }

  void unfocus() {
    FocusScope.of(getContext()).unfocus();
  }

  void openDrawer() {
    scaffoldKey?.currentState?.openDrawer();
  }

  Future<T?> pushNamed<T>(
      {required String routeName, dynamic arguments}) async {
    return navigatorKey.currentState
        ?.pushNamed<T>(routeName, arguments: arguments ?? {});
  }

  Future<T?> pushNamedAndRemove<T>(
      {required String routeName, dynamic arguments}) async {
    return navigatorKey.currentState?.pushNamedAndRemoveUntil<T>(
        routeName, (route) => false,
        arguments: arguments ?? {});
  }
}
