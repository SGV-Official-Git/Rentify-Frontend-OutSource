// To parse this JSON data, do
//
//     final propertyTypeItem = propertyTypeItemFromJson(jsonString);

import 'dart:convert';

PropertyTypeItem propertyTypeItemFromJson(String str) =>
    PropertyTypeItem.fromJson(json.decode(str));

String propertyTypeItemToJson(PropertyTypeItem data) =>
    json.encode(data.toJson());

class PropertyTypeItem {
  final String? id;
  final String? name;
  final String? status;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final int? v;

  PropertyTypeItem({
    this.id,
    this.name,
    this.status,
    this.createdAt,
    this.updatedAt,
    this.v,
  });

  factory PropertyTypeItem.fromJson(Map<String, dynamic> json) =>
      PropertyTypeItem(
        id: json["_id"],
        name: json["name"],
        status: json["status"],
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
        "name": name,
        "status": status,
        "createdAt": createdAt?.toIso8601String(),
        "updatedAt": updatedAt?.toIso8601String(),
        "__v": v,
      };
}
