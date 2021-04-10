// To parse this JSON data, do
//
//     final dayAttendance = dayAttendanceFromMap(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

class DayAttendance {
  DayAttendance({
    @required this.attendance,
    @required this.status,
  });

  final List<Attendance> attendance;
  final bool status;

  factory DayAttendance.fromJson(String str) =>
      DayAttendance.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory DayAttendance.fromMap(Map<String, dynamic> json) => DayAttendance(
        attendance: List<Attendance>.from(
            json["attendance"].map((x) => Attendance.fromMap(x))),
        status: json["status"],
      );

  Map<String, dynamic> toMap() => {
        "attendance": List<dynamic>.from(attendance.map((x) => x.toMap())),
        "status": status,
      };
}

class Attendance {
  Attendance({
    @required this.lat,
    @required this.lon,
    @required this.timestamp,
    @required this.available,
  });

  final double lat;
  final double lon;
  final DateTime timestamp;
  final bool available;

  factory Attendance.fromJson(String str) =>
      Attendance.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Attendance.fromMap(Map<String, dynamic> json) => Attendance(
        lat: double.parse(json["lat"].toString()),
        lon: double.parse(json["lon"].toString()),
        timestamp: DateTime.parse(json["timestamp"]),
        available: json["available"],
      );

  Map<String, dynamic> toMap() => {
        "lat": lat,
        "lon": lon,
        "timestamp": timestamp.toIso8601String(),
        "available": available,
      };
}
