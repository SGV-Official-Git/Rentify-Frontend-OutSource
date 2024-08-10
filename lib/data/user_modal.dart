class UserData {
  final String? id;
  final String? fullName;
  final String? email;
  final String? profileImage;
  final int? userType;
  final bool? isAdmin;
  final bool? addbyAdmin;
  final bool? statusUser;
  final String? loginType;
  final String? phone;
  final String? address;
  final String? socialId;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final int? v;

  UserData({
    this.id,
    this.fullName,
    this.address,
    this.phone,
    this.email,
    this.profileImage,
    this.userType,
    this.isAdmin,
    this.addbyAdmin,
    this.statusUser,
    this.loginType,
    this.socialId,
    this.createdAt,
    this.updatedAt,
    this.v,
  });

  factory UserData.fromJson(Map<String, dynamic> json) => UserData(
        id: json["_id"],
        fullName: json["fullName"],
        email: json["email"],
        profileImage: json["profileImage"],
        userType: json["userType"],
        isAdmin: json["isAdmin"],
        addbyAdmin: json["addbyAdmin"],
        statusUser: json["statusUser"],
        loginType: json["loginType"],
        socialId: json["socialId"],
        phone: json["phone_no"],
        address: json["address"],
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
        "userType": userType,
        "isAdmin": isAdmin,
        "addbyAdmin": addbyAdmin,
        "statusUser": statusUser,
        "loginType": loginType,
        "socialId": socialId,
        "createdAt": createdAt?.toIso8601String(),
        "updatedAt": updatedAt?.toIso8601String(),
        "__v": v,
      };
}
