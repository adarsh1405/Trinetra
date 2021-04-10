// To parse this JSON data, do
//
//     final usersAttendance = usersAttendanceFromMap(jsonString);

import 'dart:convert';

class UsersAttendance {
  UsersAttendance({
    this.count,
    this.success,
    this.users,
  });

  int count;
  bool success;
  List<User> users;

  factory UsersAttendance.fromJson(String str) =>
      UsersAttendance.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory UsersAttendance.fromMap(Map<String, dynamic> json) => UsersAttendance(
        count: json["count"] == null ? null : json["count"],
        success: json["success"] == null ? null : json["success"],
        users: json["users"] == null
            ? null
            : List<User>.from(json["users"].map((x) => User.fromMap(x))),
      );

  Map<String, dynamic> toMap() => {
        "count": count == null ? null : count,
        "success": success == null ? null : success,
        "users": users == null
            ? null
            : List<dynamic>.from(users.map((x) => x.toMap())),
      };
}

class User {
  User({
    this.active,
    this.current,
    this.employeeId,
    this.fcm,
    this.isAdmin,
    this.name,
    this.overall,
    this.phone,
    this.photo,
  });

  int active;
  Current current;
  String employeeId;
  String fcm;
  bool isAdmin;
  String name;
  Overall overall;
  String phone;
  String photo;

  factory User.fromJson(String str) => User.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory User.fromMap(Map<String, dynamic> json) => User(
        active: json["active"] == null ? null : json["active"],
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
      );

  Map<String, dynamic> toMap() => {
        "active": active == null ? null : active,
        "current": current == null ? null : current.toMap(),
        "employee_id": employeeId == null ? null : employeeId,
        "fcm": fcm == null ? null : fcm,
        "is_admin": isAdmin == null ? null : isAdmin,
        "name": name == null ? null : name,
        "overall": overall == null ? null : overall.toMap(),
        "phone": phone == null ? null : phone,
        "photo": photo == null ? null : photo,
      };
}

class Current {
  Current({
    this.logs,
    this.timestamp,
  });

  List<Log> logs;
  DateTime timestamp;

  factory Current.fromJson(String str) => Current.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Current.fromMap(Map<String, dynamic> json) => Current(
        logs: json["logs"] == null
            ? null
            : List<Log>.from(json["logs"].map((x) => Log.fromMap(x))),
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

class Log {
  Log({
    this.available,
    this.lat,
    this.lon,
    this.timestamp,
  });

  bool available;
  double lat;
  double lon;
  DateTime timestamp;

  factory Log.fromJson(String str) => Log.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Log.fromMap(Map<String, dynamic> json) => Log(
        available: json["available"] == null ? null : json["available"],
        lat: json["lat"] == null ? null : json["lat"].toDouble(),
        lon: json["lon"] == null ? null : json["lon"].toDouble(),
        timestamp: json["timestamp"] == null
            ? null
            : DateTime.parse(json["timestamp"]),
      );

  Map<String, dynamic> toMap() => {
        "available": available == null ? null : available,
        "lat": lat == null ? null : lat,
        "lon": lon == null ? null : lon,
        "timestamp": timestamp == null ? null : timestamp.toIso8601String(),
      };
}

class Overall {
  Overall({
    this.present,
    this.total,
  });

  int present;
  int total;

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
