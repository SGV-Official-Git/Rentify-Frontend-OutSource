import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:rentify/api/api_manager.dart';
import 'package:rentify/api/endpoints.dart';
import 'package:rentify/utilities/keys.dart';
import 'package:rentify/utilities/navigator.dart';
import 'package:rentify/utilities/routes.dart';
import 'package:rentify/utilities/sp.dart';
import 'package:rentify/widgets/error_dialog.dart';
import 'package:rentify/widgets/loader.dart';

enum SocialType { google, apple }

class AuthProvider extends ChangeNotifier {
  Future<void> loginApi(String email, String password) async {
    try {
      Loader.show();
      final jsonBody = {"email": email, "password": password};

      final response = await ApiManager.instance
          .post(endpoint: Endpoints.login, jsonBody: jsonBody);
      if (response != null) {
        if (response.statusCode) {
          SP.i.setString(
              key: SPKeys.userData, value: jsonEncode(response.data['user']));
          SP.i.setString(
              key: SPKeys.accessToken, value: response.data['accessToken']);
          SP.i.setString(
              key: SPKeys.userName, value: response.data['user']['fullName']);
          AppNavigator.shared.pushNamedAndRemove(routeName: Routes.dashboard);
        } else {
          alert(type: AlertType.error, message: response.message ?? "");
        }
      }
    } catch (e) {
      alert(type: AlertType.error, message: "$e");
    } finally {
      Loader.hide();
    }
  }

  Future<void> registerApi({
    required String fullName,
    required String email,
    required String phone,
    required String password,
  }) async {
    try {
      Loader.show();
      final jsonBody = {
        "fullName": fullName,
        "email": email,
        "password": password,
        "phone_no": phone,
        "userType": "1",
      };
      final response = await ApiManager.instance
          .post(endpoint: Endpoints.signUp, jsonBody: jsonBody);
      if (response != null) {
        if (response.statusCode) {
          AppNavigator.shared.pushNamed(
              routeName: Routes.otpVerify,
              arguments: {"phone": phone, "otp": response.data['otp']});
        } else {
          alert(type: AlertType.error, message: response.message ?? "");
        }
      }
    } catch (e) {
      alert(type: AlertType.error, message: "$e");
    } finally {
      Loader.hide();
    }
  }

  Future<void> otpVerify({
    required String phone,
    required String otp,
  }) async {
    try {
      Loader.show();
      final jsonBody = {
        "phone_no": phone,
        "otp": otp,
      };
      final response = await ApiManager.instance
          .post(endpoint: Endpoints.otpVerify, jsonBody: jsonBody);
      if (response != null) {
        if (response.statusCode) {
          SP.i.setString(
              key: SPKeys.userData, value: jsonEncode(response.data['user']));
          SP.i.setString(
              key: SPKeys.accessToken, value: response.data['accessToken']);
          SP.i.setString(
              key: SPKeys.userName, value: response.data['user']['fullName']);
          AppNavigator.shared.pushNamedAndRemove(routeName: Routes.dashboard);
        } else {
          alert(type: AlertType.error, message: response.message ?? "");
        }
      }
    } catch (e) {
      alert(type: AlertType.error, message: "$e");
    } finally {
      Loader.hide();
    }
  }

  Future<void> socialLoginApi({
    required SocialType loginType,
    required String email,
    required String fullName,
    required String socialId,
    required String usetType,
  }) async {
    try {
      Loader.show();
      final jsonBody = {
        "email": email,
        "fullName": fullName,
        "socialId": socialId,
        "userType": usetType,
        "loginType": loginType.name,
      };
      final response = await ApiManager.instance
          .post(endpoint: Endpoints.socialLogin, jsonBody: jsonBody);
      if (response != null) {
        if (response.statusCode) {
          SP.i.setString(
              key: SPKeys.userData, value: jsonEncode(response.data['user']));
          SP.i.setString(
              key: SPKeys.accessToken, value: response.data['accessToken']);
          SP.i.setString(
              key: SPKeys.userName, value: response.data['user']['fullName']);
          AppNavigator.shared.pushNamed(routeName: Routes.dashboard);
        } else {
          alert(type: AlertType.error, message: response.message ?? "");
        }
      }
    } catch (e) {
      alert(type: AlertType.error, message: "$e");
    } finally {
      Loader.hide();
    }
  }
}
