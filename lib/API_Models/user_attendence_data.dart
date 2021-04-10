// To parse this JSON data, do
//
//     final userattendence = userattendenceFromJson(jsonString);

import 'dart:convert';

Userattendence userattendenceFromJson(String str) => Userattendence.fromJson(json.decode(str));

String userattendenceToJson(Userattendence data) => json.encode(data.toJson());

class Userattendence {
  Userattendence({
    this.attendance,
    this.success,
  });

  List<Attendance> attendance;
  bool success;

  factory Userattendence.fromJson(Map<String, dynamic> json) => Userattendence(
    attendance: List<Attendance>.from(json["attendance"].map((x) => Attendance.fromJson(x))),
    success: json["success"],
  );

  Map<String, dynamic> toJson() => {
    "attendance": List<dynamic>.from(attendance.map((x) => x.toJson())),
    "success": success,
  };
}

class Attendance {
  Attendance({
    this.available,
    this.lat,
    this.lon,
    this.timestamp,
  });

  bool available;
  double lat;
  double lon;
  String timestamp;

  factory Attendance.fromJson(Map<String, dynamic> json) => Attendance(
    available: json["available"],
    lat: json["lat"].toDouble(),
    lon: json["lon"].toDouble(),
    timestamp: json["timestamp"],
  );

  Map<String, dynamic> toJson() => {
    "available": available,
    "lat": lat,
    "lon": lon,
    "timestamp": timestamp,
  };
}
