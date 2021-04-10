// To parse this JSON data, do
//
//     final loginResponse = loginResponseFromMap(jsonString);

import 'dart:convert';

class LoginResponse {
  LoginResponse({
    this.firstRun,
    this.success,
    this.token,
  });

  final bool firstRun;
  final bool success;
  final String token;

  factory LoginResponse.fromJson(String str) =>
      LoginResponse.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory LoginResponse.fromMap(Map<String, dynamic> json) => LoginResponse(
        firstRun: json["first_run"] == null ? null : json["first_run"],
        success: json["success"] == null ? null : json["success"],
        token: json["token"] == null ? null : json["token"],
      );

  Map<String, dynamic> toMap() => {
        "first_run": firstRun == null ? null : firstRun,
        "success": success == null ? null : success,
        "token": token == null ? null : token,
      };
}
