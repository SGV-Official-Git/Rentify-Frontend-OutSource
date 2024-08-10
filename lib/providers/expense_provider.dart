import 'dart:io';

import 'package:flutter/material.dart';
import 'package:rentify/api/api_manager.dart';
import 'package:rentify/api/endpoints.dart';
import 'package:rentify/data/expense_graph.dart';
import 'package:rentify/data/expense_item_modal.dart';
import 'package:rentify/utilities/navigator.dart';
import 'package:rentify/widgets/error_dialog.dart';
import 'package:rentify/widgets/loader.dart';

import '../api/api_response.dart';

class ExpenseProvider extends ChangeNotifier {
  String? imagePath;

  List<ExpenseItem> expenseList = [];
  ExpenseGraph? expenseGraph;

  Future<void> addExpense({
    required String title,
    required String amount,
    required String date,
    required String propertyId,
    required File? file,
  }) async {
    try {
      Loader.show();

      if (file != null) {
        final response = await uploadImage(file);
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
        "expanseAmount": amount,
        "propertyId": propertyId,
        "expanseDate": date,
        "expanse": title,
        "expanseInvoice": imagePath,
      };
      final response = await ApiManager.instance
          .post(endpoint: Endpoints.addExpense, jsonBody: jsonBody);
      if (response != null) {
        if (response.statusCode) {
          expenseList.insert(
              0, ExpenseItem.fromJson((response.data['docs'] as List).first));
          notifyListeners();
          Navigator.of(AppNavigator.shared.getContext()).pop(true);
          alert(type: AlertType.success, message: response.message ?? "");
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

  Future<void> getExpenseList({required String propertyId}) async {
    try {
      Loader.show();
      final response = await ApiManager.instance.post(
          endpoint: Endpoints.getExpenseList,
          jsonBody: {"propertyId": propertyId});

      if (response != null) {
        if (response.statusCode) {
          expenseList = (response.data['docs'] as List)
              .map<ExpenseItem>((e) => ExpenseItem.fromJson(e))
              .toList();
          notifyListeners();
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

  Future<void> getExpenseData(
      {required String propertyId, required String type}) async {
    try {
      Loader.show();
      final response = await ApiManager.instance
          .post(endpoint: Endpoints.expenseGraph, jsonBody: {
        "propertyId": propertyId,
        "type": type // 2 monthlly  1 weekly
      });

      if (response != null) {
        if (response.statusCode) {
          expenseGraph = ExpenseGraph.fromJson(response.data);
          notifyListeners();
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
