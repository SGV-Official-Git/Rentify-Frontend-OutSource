import 'dart:io';

import 'package:flutter/material.dart';
import 'package:rentify/api/api_manager.dart';
import 'package:rentify/api/endpoints.dart';
import 'package:rentify/data/room_and_bed_item.dart';
import 'package:rentify/data/tenant_item_modal.dart';
import 'package:rentify/utilities/navigator.dart';

import 'package:rentify/widgets/error_dialog.dart';
import 'package:rentify/widgets/loader.dart';

import '../api/api_response.dart';
import '../data/add_property_asset_modal.dart';
import '../data/rent_frequency_modal.dart';

class TenantProvider extends ChangeNotifier {
  String tenantDocPath = '', tenantImagePath = '';
  List<RentFrequency> rentFrequency = [];
  List<TenantItem> tenantList = [];
  List<RoomAndrBedItem> roomANDbeds = [];
  Future<void> addTenantApi({
    required String name,
    required String mobile,
    required String nameemContactName,
    required RentFrequency? rentFrequency,
    required String emContactNumber,
    required String tenantDocNumber,
    required String rentAmount,
    required String tenantPermanentAddress,
    required String meter,
    required String pricePerUnit,
    required String depositeAmount,
    required String roomAllocated,
    required File? tenantDoc,
    required String tPurposeofStay,
    required String propertyId,
    required String bedAllocated,
    required DateTime billingDate,
    required List<AddPropertyAsset> propAssets,
    required File? tenantImage,
  }) async {
    try {
      Loader.show();

      if (tenantImage != null) {
        final response = await uploadImage(tenantImage);
        if (response != null) {
          if (response.statusCode) {
            tenantImagePath = response.data;
            notifyListeners();
          } else {
            alert(type: AlertType.error, message: response.message ?? "");
            return;
          }
        }
      }
      if (tenantDoc != null) {
        final response = await uploadImage(tenantDoc);
        if (response != null) {
          if (response.statusCode) {
            tenantDocPath = response.data;
            notifyListeners();
          } else {
            alert(type: AlertType.error, message: response.message ?? "");
            return;
          }
        }
      }

      final jsonBody = {
        "tenantName": name,
        "tenantMobileNo": mobile,
        "tenantEmContactNo": emContactNumber,
        "tenantEmName": nameemContactName,
        "roomAllocated": roomAllocated,
        "depositeAmount": depositeAmount,
        "rentFrequency": rentFrequency?.id,
        "bedAllocated": bedAllocated,
        "tenantPAddress": tenantPermanentAddress,
        "tenantDocument": tenantDocPath,
        "tenantDocumnetNo": tenantDocNumber,
        "rentAmout": rentAmount,
        "tPurposeofStay": tPurposeofStay,
        "electricity": {"CurrentMeter": meter, "priceUnit": pricePerUnit},
        "propertyId": propertyId,
        "billingDate": billingDate.toString(),
        "propAssets": propAssets
            .map((e) => {"itemName": e.name, "count": e.quantity})
            .toList(),
        "tenantImage": tenantImagePath,

        // "editId": "66a0dd003ea43ef83bb7ebb3",
        // "del": "1"
      };
      final response = await ApiManager.instance
          .post(endpoint: Endpoints.addTenant, jsonBody: jsonBody);
      if (response != null) {
        if (response.statusCode) {
          tenantList.add(TenantItem.fromJson(response.data));
          notifyListeners();
          Navigator.of(AppNavigator.shared.getContext()).pop();
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

  Future<void> rentFrequencyListApi() async {
    try {
      Loader.show();
      final response = await ApiManager.instance
          .post(endpoint: Endpoints.rentFrquencyList, jsonBody: {});
      if (response != null) {
        if (response.statusCode) {
          rentFrequency = (response.data['docs'] as List)
              .map<RentFrequency>((e) => RentFrequency.fromJson(e))
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

  Future<void> getRoomAndBed({required String propertyId}) async {
    try {
      Loader.show();
      final jsonBody = {"propertyId": propertyId};
      final response = await ApiManager.instance.post(
          endpoint: Endpoints.getRoomAndBed,
          queryParameters: jsonBody,
          jsonBody: jsonBody);
      if (response != null) {
        if (response.statusCode) {
          roomANDbeds = (response.data as List)
              .map((item) => RoomAndrBedItem.fromJson(item))
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

  Future<void> getTenantList({String? tenantId, String? propId}) async {
    try {
      Loader.show();
      final jsonBody = {"propertyId": propId, "tenantId": tenantId};
      final response = await ApiManager.instance.post(
          endpoint: Endpoints.getTenantList,
          queryParameters: jsonBody,
          jsonBody: jsonBody);
      if (response != null) {
        if (response.statusCode) {
          tenantList = (response.data["docs"] as List)
              .map<TenantItem>((e) => TenantItem.fromJson(e))
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
}
