import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:rentify/api/api_manager.dart';
import 'package:rentify/api/endpoints.dart';
import 'package:rentify/widgets/error_dialog.dart';
import 'package:rentify/widgets/loader.dart';

import '../api/api_response.dart';
import '../utilities/keys.dart';
import '../utilities/sp.dart';

class ProfileProvider extends ChangeNotifier {
  String imagePath = "";
  Future<void> updateProfile({
    required String name,
    required String email,
    required String phone,
    required String address,
    required File? image,
  }) async {
    try {
      Loader.show();
      if (image != null) {
        final response = await uploadImage(image);
        if (response != null) {
          if (response.statusCode) {
            imagePath = response.data;
            notifyListeners();
          } else {
            alert(type: AlertType.error, message: response.message ?? "");
            return;
          }
        }
      }
      final jsonBody = {
        "phone_no": phone,
        "fullName": name,
        "address": address,
        "profileImage": imagePath
      };
      final response = await ApiManager.instance
          .post(endpoint: Endpoints.userUpdate, jsonBody: jsonBody);
      if (response != null) {
        if (response.statusCode) {
          SP.i.setString(
              key: SPKeys.userData, value: jsonEncode(response.data));

          SP.i.setString(
              key: SPKeys.userName, value: response.data['fullName']);
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

  Future<ApiResponse?> uploadImage(File image) async {
    try {
      final body = {"file": image.path};
      final response = await ApiManager.instance.postWithImage<File>(
        endpoint: Endpoints.uploadImage,
        key: "file",
        jsonBody: body,
      );
      return response;
    } catch (e) {
      rethrow;
    }
  }
}
