import 'dart:io';

import 'package:flutter/material.dart';
import 'package:rentify/api/api_manager.dart';
import 'package:rentify/api/endpoints.dart';
import 'package:rentify/data/property_asset_itm.dart';
import 'package:rentify/data/room_asset_modal.dart' as ram;
import 'package:rentify/utilities/navigator.dart';
import 'package:rentify/utilities/routes.dart';
import 'package:rentify/views/dialogs/add_property_dialog.dart';
import 'package:rentify/widgets/error_dialog.dart';
import 'package:rentify/widgets/loader.dart';

import '../api/api_response.dart';
import '../data/property_item_modal.dart';
import '../data/property_list_item.dart';

class PropertyProvider extends ChangeNotifier {
  List<PropertyTypeItem> propertyTypes = [];
  List<PropertyAssetItem> propertyAssets = [];
  List<PropertyItem> properties = [];
  String? imagePath;

  //add property
  Future<void> addProperty({
    required File? image,
    required String name,
    required String type,
    required String address,
    required String managerName,
    required String contact,
    required List<String> propertyAsset,
    required List<ram.PropertyRoomDetail> propertyRoomDetails,
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
        "propertyName": name,
        "propertyImage": imagePath,
        "propertyType": type,
        "propertyAddress": address,
        "propertyMangerName": managerName,
        "propertyMangerCont": contact,
        "propertyAmenities": propertyAsset,
        "propertyRoomDetails": propertyRoomDetails
            .map((e) => {
                  "roomNumber": e.roomNumber,
                  "roomBeds": e.totalBeds,
                  "roomStatus": "1",
                  "roomAmenities": e.roomAmenities
                })
            .toList()
      };
      final response = await ApiManager.instance.post(
        endpoint: Endpoints.propertyCrud,
        jsonBody: jsonBody,
      );
      if (response != null) {
        if (response.statusCode) {
          alert(type: AlertType.success, message: response.message ?? "");
          properties.add(PropertyItem.fromJson(response.data));
          notifyListeners();
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

  Future<void> getPropertyType() async {
    try {
      Loader.show();
      final jsonBody = {};
      final response = await ApiManager.instance
          .post(endpoint: Endpoints.propTypeList, jsonBody: jsonBody);
      if (response != null) {
        if (response.statusCode) {
          propertyTypes = (response.data as List)
              .map<PropertyTypeItem>((e) => PropertyTypeItem.fromJson(e))
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

  Future<void> getPropertyAssets() async {
    try {
      Loader.show();
      final jsonBody = {};
      final response = await ApiManager.instance
          .post(endpoint: Endpoints.propAssetList, jsonBody: jsonBody);
      if (response != null) {
        if (response.statusCode) {
          propertyAssets = (response.data as List)
              .map<PropertyAssetItem>((e) => PropertyAssetItem.fromJson(e))
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

  Future<void> propertyListApi({String? propId}) async {
    try {
      Loader.show();
      final json = {
        "propId": propId,
      };
      final response = await ApiManager.instance
          .post(endpoint: Endpoints.getPropList, jsonBody: json);
      if (response != null) {
        if (response.statusCode) {
          properties = (response.data['docs'] as List)
              .map<PropertyItem>((e) => PropertyItem.fromJson(e))
              .toList();
          notifyListeners();
          if (properties.isEmpty) {
            showDialog(
              context: AppNavigator.shared.getContext(),
              barrierDismissible: false,
              useRootNavigator: true,
              builder: (context) => const AddPropertyDialog(),
            );
          }
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
