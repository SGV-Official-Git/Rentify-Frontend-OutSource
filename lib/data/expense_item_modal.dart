// To parse this JSON data, do
//
//     final expenseItem = expenseItemFromJson(jsonString);

import 'dart:convert';

ExpenseItem expenseItemFromJson(String str) =>
    ExpenseItem.fromJson(json.decode(str));

String expenseItemToJson(ExpenseItem data) => json.encode(data.toJson());

class ExpenseItem {
  final String? id;
  final int? expanseAmount;
  final String? propertyId;
  final String? ownerId;
  final DateTime? expanseDate;
  final String? expanse;
  final String? expanseInvoice;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final int? v;
  final List<OwnerDetail>? ownerDetails;
  final List<PropertyDetail>? propertyDetails;

  ExpenseItem({
    this.id,
    this.expanseAmount,
    this.propertyId,
    this.ownerId,
    this.expanseDate,
    this.expanse,
    this.expanseInvoice,
    this.createdAt,
    this.updatedAt,
    this.v,
    this.ownerDetails,
    this.propertyDetails,
  });

  factory ExpenseItem.fromJson(Map<String, dynamic> json) => ExpenseItem(
        id: json["_id"],
        expanseAmount: json["expanseAmount"],
        propertyId: json["propertyId"],
        ownerId: json["ownerId"],
        expanseDate: json["expanseDate"] == null
            ? null
            : DateTime.parse(json["expanseDate"]),
        expanse: json["expanse"],
        expanseInvoice: json["expanseInvoice"],
        createdAt: json["createdAt"] == null
            ? null
            : DateTime.parse(json["createdAt"]),
        updatedAt: json["updatedAt"] == null
            ? null
            : DateTime.parse(json["updatedAt"]),
        v: json["__v"],
        ownerDetails: json["ownerDetails"] == null
            ? []
            : List<OwnerDetail>.from(
                json["ownerDetails"]!.map((x) => OwnerDetail.fromJson(x))),
        propertyDetails: json["propertyDetails"] == null
            ? []
            : List<PropertyDetail>.from(json["propertyDetails"]!
                .map((x) => PropertyDetail.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "expanseAmount": expanseAmount,
        "propertyId": propertyId,
        "ownerId": ownerId,
        "expanseDate": expanseDate?.toIso8601String(),
        "expanse": expanse,
        "expanseInvoice": expanseInvoice,
        "createdAt": createdAt?.toIso8601String(),
        "updatedAt": updatedAt?.toIso8601String(),
        "__v": v,
        "ownerDetails": ownerDetails == null
            ? []
            : List<dynamic>.from(ownerDetails!.map((x) => x.toJson())),
        "propertyDetails": propertyDetails == null
            ? []
            : List<dynamic>.from(propertyDetails!.map((x) => x.toJson())),
      };
}

class OwnerDetail {
  final String? id;
  final String? fullName;
  final String? email;
  final String? profileImage;
  final String? phoneNo;
  final int? userType;
  final String? address;
  final bool? addbyAdmin;
  final bool? statusUser;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final int? v;

  OwnerDetail({
    this.id,
    this.fullName,
    this.email,
    this.profileImage,
    this.phoneNo,
    this.userType,
    this.address,
    this.addbyAdmin,
    this.statusUser,
    this.createdAt,
    this.updatedAt,
    this.v,
  });

  factory OwnerDetail.fromJson(Map<String, dynamic> json) => OwnerDetail(
        id: json["_id"],
        fullName: json["fullName"],
        email: json["email"],
        profileImage: json["profileImage"],
        phoneNo: json["phone_no"],
        userType: json["userType"],
        address: json["address"],
        addbyAdmin: json["addbyAdmin"],
        statusUser: json["statusUser"],
        createdAt: json["createdAt"] == null
            ? null
            : DateTime.parse(json["createdAt"]),
        updatedAt: json["updatedAt"] == null
            ? null
            : DateTime.parse(json["updatedAt"]),
        v: json["__v"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "fullName": fullName,
        "email": email,
        "profileImage": profileImage,
        "phone_no": phoneNo,
        "userType": userType,
        "address": address,
        "addbyAdmin": addbyAdmin,
        "statusUser": statusUser,
        "createdAt": createdAt?.toIso8601String(),
        "updatedAt": updatedAt?.toIso8601String(),
        "__v": v,
      };
}

class PropertyDetail {
  final String? id;
  final String? propertyName;
  final String? propertyType;
  final String? ownerId;
  final String? propertyImage;
  final String? propertyAddress;
  final String? propertyMangerName;
  final String? propertyMangerCont;
  final List<PropertyRoomDetail>? propertyRoomDetails;
  final List<String>? propertyAmenities;
  final List<String>? tenantIds;
  final List<String>? expanseIds;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final int? v;

  PropertyDetail({
    this.id,
    this.propertyName,
    this.propertyType,
    this.ownerId,
    this.propertyImage,
    this.propertyAddress,
    this.propertyMangerName,
    this.propertyMangerCont,
    this.propertyRoomDetails,
    this.propertyAmenities,
    this.tenantIds,
    this.expanseIds,
    this.createdAt,
    this.updatedAt,
    this.v,
  });

  factory PropertyDetail.fromJson(Map<String, dynamic> json) => PropertyDetail(
        id: json["_id"],
        propertyName: json["propertyName"],
        propertyType: json["propertyType"],
        ownerId: json["ownerId"],
        propertyImage: json["propertyImage"],
        propertyAddress: json["propertyAddress"],
        propertyMangerName: json["propertyMangerName"],
        propertyMangerCont: json["propertyMangerCont"],
        propertyRoomDetails: json["propertyRoomDetails"] == null
            ? []
            : List<PropertyRoomDetail>.from(json["propertyRoomDetails"]!
                .map((x) => PropertyRoomDetail.fromJson(x))),
        propertyAmenities: json["propertyAmenities"] == null
            ? []
            : List<String>.from(json["propertyAmenities"]!.map((x) => x)),
        tenantIds: json["tenantIds"] == null
            ? []
            : List<String>.from(json["tenantIds"]!.map((x) => x)),
        expanseIds: json["expanseIds"] == null
            ? []
            : List<String>.from(json["expanseIds"]!.map((x) => x)),
        createdAt: json["createdAt"] == null
            ? null
            : DateTime.parse(json["createdAt"]),
        updatedAt: json["updatedAt"] == null
            ? null
            : DateTime.parse(json["updatedAt"]),
        v: json["__v"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "propertyName": propertyName,
        "propertyType": propertyType,
        "ownerId": ownerId,
        "propertyImage": propertyImage,
        "propertyAddress": propertyAddress,
        "propertyMangerName": propertyMangerName,
        "propertyMangerCont": propertyMangerCont,
        "propertyRoomDetails": propertyRoomDetails == null
            ? []
            : List<dynamic>.from(propertyRoomDetails!.map((x) => x.toJson())),
        "propertyAmenities": propertyAmenities == null
            ? []
            : List<dynamic>.from(propertyAmenities!.map((x) => x)),
        "tenantIds": tenantIds == null
            ? []
            : List<dynamic>.from(tenantIds!.map((x) => x)),
        "expanseIds": expanseIds == null
            ? []
            : List<dynamic>.from(expanseIds!.map((x) => x)),
        "createdAt": createdAt?.toIso8601String(),
        "updatedAt": updatedAt?.toIso8601String(),
        "__v": v,
      };
}

class PropertyRoomDetail {
  final String? roomNumber;
  final String? roomBeds;
  final String? roomStatus;
  final List<String>? roomAmenities;
  final String? id;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  PropertyRoomDetail({
    this.roomNumber,
    this.roomBeds,
    this.roomStatus,
    this.roomAmenities,
    this.id,
    this.createdAt,
    this.updatedAt,
  });

  factory PropertyRoomDetail.fromJson(Map<String, dynamic> json) =>
      PropertyRoomDetail(
        roomNumber: json["roomNumber"],
        roomBeds: json["roomBeds"],
        roomStatus: json["roomStatus"],
        roomAmenities: json["roomAmenities"] == null
            ? []
            : List<String>.from(json["roomAmenities"]!.map((x) => x)),
        id: json["_id"],
        createdAt: json["createdAt"] == null
            ? null
            : DateTime.parse(json["createdAt"]),
        updatedAt: json["updatedAt"] == null
            ? null
            : DateTime.parse(json["updatedAt"]),
      );

  Map<String, dynamic> toJson() => {
        "roomNumber": roomNumber,
        "roomBeds": roomBeds,
        "roomStatus": roomStatus,
        "roomAmenities": roomAmenities == null
            ? []
            : List<dynamic>.from(roomAmenities!.map((x) => x)),
        "_id": id,
        "createdAt": createdAt?.toIso8601String(),
        "updatedAt": updatedAt?.toIso8601String(),
      };
}
