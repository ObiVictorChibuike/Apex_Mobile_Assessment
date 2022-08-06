import 'dart:convert';

AuthUserResponseModel authUserResponseModelFromJson(String str) => AuthUserResponseModel.fromJson(json.decode(str));

String authUserResponseModelToJson(AuthUserResponseModel data) => json.encode(data.toJson());

class AuthUserResponseModel {
  AuthUserResponseModel({
    this.status,
    this.message,
    this.data,
  });

  String? status;
  String? message;
  List<AuthUser>? data;

  factory AuthUserResponseModel.fromJson(Map<String, dynamic> json) => AuthUserResponseModel(
    status: json["status"] == null ? null : json["status"],
    message: json["message"] == null ? null : json["message"],
    data: json["data"] == null ? null : List<AuthUser>.from(json["data"].map((x) => AuthUser.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "status": status == null ? null : status,
    "message": message == null ? null : message,
    "data": data == null ? null : List<dynamic>.from(data!.map((x) => x.toJson())),
  };
}

class AuthUser {
  AuthUser({
    this.phoneNumber,
    this.balance,
    this.created,
  });

  String? phoneNumber;
  double? balance;
  DateTime? created;

  factory AuthUser.fromJson(Map<String, dynamic> json) => AuthUser(
    phoneNumber: json["phoneNumber"] == null ? null : json["phoneNumber"],
    balance: json["balance"] == null ? null : json["balance"].toDouble(),
    created: json["created"] == null ? null : DateTime.parse(json["created"]),
  );

  Map<String, dynamic> toJson() => {
    "phoneNumber": phoneNumber == null ? null : phoneNumber,
    "balance": balance == null ? null : balance,
    "created": created == null ? null : created?.toIso8601String(),
  };
}
