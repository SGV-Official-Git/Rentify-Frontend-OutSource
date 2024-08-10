// To parse this JSON data, do
//
//     final propertyAssetItem = propertyAssetItemFromJson(jsonString);

import 'dart:convert';

PropertyAssetItem propertyAssetItemFromJson(String str) =>
    PropertyAssetItem.fromJson(json.decode(str));

String propertyAssetItemToJson(PropertyAssetItem data) =>
    json.encode(data.toJson());

class PropertyAssetItem {
  final String? id;
  final String? name;
  final String? image;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final int? v;

  PropertyAssetItem({
    this.id,
    this.name,
    this.image,
    this.createdAt,
    this.updatedAt,
    this.v,
  });

  factory PropertyAssetItem.fromJson(Map<String, dynamic> json) =>
      PropertyAssetItem(
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
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "name": name,
        "image": image,
        "createdAt": createdAt?.toIso8601String(),
        "updatedAt": updatedAt?.toIso8601String(),
        "__v": v,
      };
}
