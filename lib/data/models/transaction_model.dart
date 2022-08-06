import 'dart:convert';

TransactionModelResponse emptyFromJson(String str) => TransactionModelResponse.fromJson(json.decode(str));

String emptyToJson(TransactionModelResponse data) => json.encode(data.toJson());

class TransactionModelResponse {
  TransactionModelResponse({
    this.status,
    this.data,
  });

  String? status;
  List<Transactions>? data;

  factory TransactionModelResponse.fromJson(Map<String, dynamic> json) => TransactionModelResponse(
    status: json["status"] == null ? null : json["status"],
    data: json["data"] == null ? null : List<Transactions>.from(json["data"].map((x) => Transactions.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "status": status == null ? null : status,
    "data": data == null ? null : List<dynamic>.from(data!.map((x) => x.toJson())),
  };
}

class Transactions {
  Transactions({
    this.type,
    this.amount,
    this.phoneNumber,
    this.created,
    this.balance,
  });

  String? type;
  double? amount;
  String? phoneNumber;
  DateTime? created;
  double? balance;

  factory Transactions.fromJson(Map<String, dynamic> json) => Transactions(
    type: json["type"] == null ? null : json["type"],
    amount: json["amount"] == null ? null : json["amount"].toDouble(),
    phoneNumber: json["phoneNumber"] == null ? null : json["phoneNumber"],
    created: json["created"] == null ? null : DateTime.parse(json["created"]),
    balance: json["balance"] == null ? null : json["balance"].toDouble(),
  );

  Map<String, dynamic> toJson() => {
    "type": type == null ? null : type,
    "amount": amount == null ? null : amount,
    "phoneNumber": phoneNumber == null ? null : phoneNumber,
    "created": created == null ? null : created?.toIso8601String(),
    "balance": balance == null ? null : balance,
  };
}

enum Type { CREDIT, DEBIT }

final typeValues = EnumValues({
  "credit": Type.CREDIT,
  "debit": Type.DEBIT
});

class EnumValues<T> {
  Map<String, T>? map;
  Map<T, String>? reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    if (reverseMap == null) {
      reverseMap = map?.map((k, v) => new MapEntry(v, k));
    }
    return reverseMap!;
  }
}
