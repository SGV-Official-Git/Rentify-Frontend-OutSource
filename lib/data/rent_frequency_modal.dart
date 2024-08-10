// To parse this JSON data, do
//
//     final rentFrequency = rentFrequencyFromJson(jsonString);

class RentFrequency {
  final String? id;
  final String? name;
  final String? status;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final int? v;

  RentFrequency({
    this.id,
    this.name,
    this.status,
    this.createdAt,
    this.updatedAt,
    this.v,
  });

  factory RentFrequency.fromJson(Map<String, dynamic> json) => RentFrequency(
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
