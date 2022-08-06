import 'dart:convert';

AccountListResponseModel accountListResponseModelFromJson(String str) => AccountListResponseModel.fromJson(json.decode(str));

String accountListResponseModelToJson(AccountListResponseModel data) => json.encode(data.toJson());

class AccountListResponseModel {
  AccountListResponseModel({
    this.status,
    this.message,
    this.data,
  });

  String? status;
  String? message;
  List<AccountList>? data;

  factory AccountListResponseModel.fromJson(Map<String, dynamic> json) => AccountListResponseModel(
    status: json["status"] == null ? null : json["status"],
    message: json["message"] == null ? null : json["message"],
    data: json["data"] == null ? null : List<AccountList>.from(json["data"].map((x) => AccountList.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "status": status == null ? null : status,
    "message": message == null ? null : message,
    "data": data == null ? null : List<dynamic>.from(data!.map((x) => x.toJson())),
  };
}

class AccountList {
  AccountList({
    this.phoneNumber,
    this.balance,
    this.created,
  });

  String? phoneNumber;
  double? balance;
  DateTime? created;

  factory AccountList.fromJson(Map<String, dynamic> json) => AccountList(
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
