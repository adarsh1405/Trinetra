// To parse this JSON data, do
//
//     final adduser = adduserFromJson(jsonString);

import 'dart:convert';

import 'package:adminpanelflutter/API_Models/user_attendance.dart';

Adduser adduserFromJson(String str) => Adduser.fromJson(json.decode(str));

String adduserToJson(Adduser data) => json.encode(data.toJson());

class Adduser {
  Adduser({
    this.current,
    this.employeeId,
    this.isAdmin,
    this.name,
    this.overall,
    this.phone,
    this.photo,
    this.success,
  });

  Current current;
  String employeeId;
  bool isAdmin;
  String name;
  Overall overall;
  String phone;
  String photo;
  bool success;

  factory Adduser.fromJson(Map<String, dynamic> json) => Adduser(
        current: Current.fromJson(json["current"]),
        employeeId: json["employee_id"],
        isAdmin: json["is_admin"],
        name: json["name"],
        overall: Overall.fromJson(json["overall"]),
        phone: json["phone"],
        photo: json["photo"],
        success: json["success"],
      );

  Map<String, dynamic> toJson() => {
        "current": current.toJson(),
        "employee_id": employeeId,
        "is_admin": isAdmin,
        "name": name,
        "overall": overall.toJson(),
        "phone": phone,
        "photo": photo,
        "success": success,
      };
}
