// To parse this JSON data, do
//
//     final tenantItem = tenantItemFromJson(jsonString);

class TenantItem {
  final String? id;
  final String? tenantName;
  final String? rentAmout;
  final String? depositeAmount;
  final String? tenantMobileNo;
  final String? tenantEmContactNo;
  final String? tenantPAddress;
  final String? tenantDocument;
  final String? tenantDocumnetNo;
  final String? ownerId;
  final String? tPurposeofStay;
  final String? propertyId;
  final DateTime? billingDate;
  final String? roomAllocated;
  final String? bedAllocated;
  final List<PropAsset>? propAssets;
  final String? rentFrequency;
  final Electricity? electricity;
  final String? tenantImage;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final int? v;

  TenantItem({
    this.id,
    this.tenantName,
    this.rentAmout,
    this.depositeAmount,
    this.tenantMobileNo,
    this.tenantEmContactNo,
    this.tenantPAddress,
    this.tenantDocument,
    this.tenantDocumnetNo,
    this.ownerId,
    this.tPurposeofStay,
    this.propertyId,
    this.billingDate,
    this.roomAllocated,
    this.bedAllocated,
    this.propAssets,
    this.rentFrequency,
    this.electricity,
    this.tenantImage,
    this.createdAt,
    this.updatedAt,
    this.v,
  });

  factory TenantItem.fromJson(Map<String, dynamic> json) => TenantItem(
        id: json["_id"],
        tenantName: json["tenantName"],
        rentAmout: json["rentAmout"],
        depositeAmount: json["depositeAmount"],
        tenantMobileNo: json["tenantMobileNo"],
        tenantEmContactNo: json["tenantEmContactNo"],
        tenantPAddress: json["tenantPAddress"],
        tenantDocument: json["tenantDocument"],
        tenantDocumnetNo: json["tenantDocumnetNo"],
        ownerId: json["ownerId"],
        tPurposeofStay: json["tPurposeofStay"],
        propertyId: json["propertyId"],
        billingDate: json["billingDate"] == null
            ? null
            : DateTime.parse(json["billingDate"]),
        roomAllocated: json["roomAllocated"],
        bedAllocated: json["bedAllocated"],
        propAssets: json["propAssets"] == null
            ? []
            : List<PropAsset>.from(
                json["propAssets"]!.map((x) => PropAsset.fromJson(x))),
        rentFrequency: json["rentFrequency"],
        electricity: json["electricity"] == null
            ? null
            : Electricity.fromJson(json["electricity"]),
        tenantImage: json["tenantImage"],
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
        "tenantName": tenantName,
        "rentAmout": rentAmout,
        "depositeAmount": depositeAmount,
        "tenantMobileNo": tenantMobileNo,
        "tenantEmContactNo": tenantEmContactNo,
        "tenantPAddress": tenantPAddress,
        "tenantDocument": tenantDocument,
        "tenantDocumnetNo": tenantDocumnetNo,
        "ownerId": ownerId,
        "tPurposeofStay": tPurposeofStay,
        "propertyId": propertyId,
        "billingDate": billingDate?.toIso8601String(),
        "roomAllocated": roomAllocated,
        "bedAllocated": bedAllocated,
        "propAssets": propAssets == null
            ? []
            : List<dynamic>.from(propAssets!.map((x) => x.toJson())),
        "rentFrequency": rentFrequency,
        "electricity": electricity?.toJson(),
        "tenantImage": tenantImage,
        "createdAt": createdAt?.toIso8601String(),
        "updatedAt": updatedAt?.toIso8601String(),
        "__v": v,
      };
}

class Electricity {
  final String? currentMeter;
  final String? priceUnit;
  final String? id;

  Electricity({
    this.currentMeter,
    this.priceUnit,
    this.id,
  });

  factory Electricity.fromJson(Map<String, dynamic> json) => Electricity(
        currentMeter: json["CurrentMeter"],
        priceUnit: json["priceUnit"],
        id: json["_id"],
      );

  Map<String, dynamic> toJson() => {
        "CurrentMeter": currentMeter,
        "priceUnit": priceUnit,
        "_id": id,
      };
}

class PropAsset {
  final String? itemName;
  final int? count;
  final String? id;

  PropAsset({
    this.itemName,
    this.count,
    this.id,
  });

  factory PropAsset.fromJson(Map<String, dynamic> json) => PropAsset(
        itemName: json["itemName"],
        count: json["count"],
        id: json["_id"],
      );

  Map<String, dynamic> toJson() => {
        "itemName": itemName,
        "count": count,
        "_id": id,
      };
}
