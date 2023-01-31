
class VerifyEmailTokenResponse {
  VerifyEmailTokenResponse({
    this.status,
    this.message,
    this.data,
    this.meta,
    this.pagination,
  });

  bool? status;
  String? message;
  Data? data;
  List<dynamic>? meta;
  List<dynamic>? pagination;

  factory VerifyEmailTokenResponse.fromJson(Map<String, dynamic> json) => VerifyEmailTokenResponse(
    status: json["status"],
    message: json["message"],
    data: json["data"] == null ? null : Data.fromJson(json["data"]),
    meta: json["meta"] == null ? [] : List<dynamic>.from(json["meta"]!.map((x) => x)),
    pagination: json["pagination"] == null ? [] : List<dynamic>.from(json["pagination"]!.map((x) => x)),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
    "data": data?.toJson(),
    "meta": meta == null ? [] : List<dynamic>.from(meta!.map((x) => x)),
    "pagination": pagination == null ? [] : List<dynamic>.from(pagination!.map((x) => x)),
  };
}

class Data {
  Data({
    this.email,
  });

  String? email;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    email: json["email"],
  );

  Map<String, dynamic> toJson() => {
    "email": email,
  };
}
