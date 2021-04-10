// To parse this JSON data, do
//
//     final profileModel = profileModelFromMap(jsonString);

import 'dart:convert';

import 'package:trinetra/models/day_attendance.dart';

class ProfileModel {
  ProfileModel({
    this.current,
    this.employeeId,
    this.fcm,
    this.isAdmin,
    this.name,
    this.overall,
    this.phone,
    this.photo,
    this.success,
  });

  final Current current;
  final String employeeId;
  final String fcm;
  final bool isAdmin;
  final String name;
  final Overall overall;
  final String phone;
  final String photo;
  final bool success;

  factory ProfileModel.fromJson(String str) =>
      ProfileModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory ProfileModel.fromMap(Map<String, dynamic> json) => ProfileModel(
        current:
            json["current"] == null ? null : Current.fromMap(json["current"]),
        employeeId: json["employee_id"] == null ? null : json["employee_id"],
        fcm: json["fcm"] == null ? null : json["fcm"],
        isAdmin: json["is_admin"] == null ? null : json["is_admin"],
        name: json["name"] == null ? null : json["name"],
        overall:
            json["overall"] == null ? null : Overall.fromMap(json["overall"]),
        phone: json["phone"] == null ? null : json["phone"],
        photo: json["photo"] == null ? null : json["photo"],
        success: json["success"] == null ? null : json["success"],
      );

  Map<String, dynamic> toMap() => {
        "current": current == null ? null : current.toMap(),
        "employee_id": employeeId == null ? null : employeeId,
        "fcm": fcm == null ? null : fcm,
        "is_admin": isAdmin == null ? null : isAdmin,
        "name": name == null ? null : name,
        "overall": overall == null ? null : overall.toMap(),
        "phone": phone == null ? null : phone,
        "photo": photo == null ? null : photo,
        "success": success == null ? null : success,
      };
}

class Current {
  Current({
    this.logs,
    this.timestamp,
  });

  final List<Attendance> logs;
  final DateTime timestamp;

  factory Current.fromJson(String str) => Current.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Current.fromMap(Map<String, dynamic> json) => Current(
        logs: json["logs"] == null
            ? null
            : List<Attendance>.from(
                json["logs"].map((x) => Attendance.fromMap(x))),
        timestamp: json["timestamp"] == null
            ? null
            : DateTime.parse(json["timestamp"]),
      );

  Map<String, dynamic> toMap() => {
        "logs": logs == null
            ? null
            : List<dynamic>.from(logs.map((x) => x.toMap())),
        "timestamp": timestamp == null ? null : timestamp.toIso8601String(),
      };
}

class Overall {
  Overall({
    this.present,
    this.total,
  });

  final int present;
  final int total;

  factory Overall.fromJson(String str) => Overall.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Overall.fromMap(Map<String, dynamic> json) => Overall(
        present: json["present"] == null ? null : json["present"],
        total: json["total"] == null ? null : json["total"],
      );

  Map<String, dynamic> toMap() => {
        "present": present == null ? null : present,
        "total": total == null ? null : total,
      };
}
