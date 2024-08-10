// To parse this JSON data, do
//
//     final roomAndrBedItem = roomAndrBedItemFromJson(jsonString);

import 'dart:convert';

RoomAndrBedItem roomAndrBedItemFromJson(String str) =>
    RoomAndrBedItem.fromJson(json.decode(str));

String roomAndrBedItemToJson(RoomAndrBedItem data) =>
    json.encode(data.toJson());

class RoomAndrBedItem {
  final String? name;
  final String? roomBeds;
  final String? id;

  RoomAndrBedItem({
    this.name,
    this.roomBeds,
    this.id,
  });

  factory RoomAndrBedItem.fromJson(Map<String, dynamic> json) =>
      RoomAndrBedItem(
        name: json["roomNumber"],
        roomBeds: json["roomBeds"],
        id: json["_id"],
      );

  Map<String, dynamic> toJson() => {
        "roomNumber": name,
        "roomBeds": roomBeds,
        "_id": id,
      };
}
