// To parse this JSON data, do
//
//     final propertyItem = propertyItemFromJson(jsonString);

import 'dart:convert';

PropertyItem propertyItemFromJson(String str) =>
    PropertyItem.fromJson(json.decode(str));

String propertyItemToJson(PropertyItem data) => json.encode(data.toJson());

class PropertyItem {
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
  final List<dynamic>? expanseIds;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final int? v;
  final List<Detail>? amenitiesDetails;
  final List<Detail>? propertyTypeDetails;
  final int? totalDepositAmount;
  final int? totalTenats;
  final int? totalRooms;
  final int? totalBeds;

  PropertyItem({
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
    this.amenitiesDetails,
    this.propertyTypeDetails,
    this.totalDepositAmount,
    this.totalTenats,
    this.totalRooms,
    this.totalBeds,
  });

  factory PropertyItem.fromJson(Map<String, dynamic> json) => PropertyItem(
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
            : List<dynamic>.from(json["expanseIds"]!.map((x) => x)),
        createdAt: json["createdAt"] == null
            ? null
            : DateTime.parse(json["createdAt"]),
        updatedAt: json["updatedAt"] == null
            ? null
            : DateTime.parse(json["updatedAt"]),
        v: json["__v"],
        amenitiesDetails: json["amenitiesDetails"] == null
            ? []
            : List<Detail>.from(
                json["amenitiesDetails"]!.map((x) => Detail.fromJson(x))),
        propertyTypeDetails: json["propertyTypeDetails"] == null
            ? []
            : List<Detail>.from(
                json["propertyTypeDetails"]!.map((x) => Detail.fromJson(x))),
        totalDepositAmount: json["totalDepositAmount"],
        totalTenats: json["totalTenats"],
        totalRooms: json["totalRooms"],
        totalBeds: json["totalBeds"],
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
        "amenitiesDetails": amenitiesDetails == null
            ? []
            : List<dynamic>.from(amenitiesDetails!.map((x) => x.toJson())),
        "propertyTypeDetails": propertyTypeDetails == null
            ? []
            : List<dynamic>.from(propertyTypeDetails!.map((x) => x.toJson())),
        "totalDepositAmount": totalDepositAmount,
        "totalTenats": totalTenats,
        "totalRooms": totalRooms,
        "totalBeds": totalBeds,
      };
}

class Detail {
  final String? id;
  final String? name;
  final String? image;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final int? v;
  final String? status;

  Detail({
    this.id,
    this.name,
    this.image,
    this.createdAt,
    this.updatedAt,
    this.v,
    this.status,
  });

  factory Detail.fromJson(Map<String, dynamic> json) => Detail(
        id: json["_id"],
        name: json["name"],
        image: json["image"],
        createdAt: json["createdAt"] == null
            ? null
            : DateTime.parse(json["createdAt"]),
        updatedAt: json["updatedAt"] == null
            ? null
            : DateTime.parse(json["updatedAt"]),
        v: json["__v"],
        status: json["status"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "name": name,
        "image": image,
        "createdAt": createdAt?.toIso8601String(),
        "updatedAt": updatedAt?.toIso8601String(),
        "__v": v,
        "status": status,
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
