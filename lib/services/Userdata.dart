// To parse this JSON data, do
//
//     final user = userFromJson(jsonString);

import 'dart:convert';

User userFromJson(String str) => User.fromJson(json.decode(str));

String userToJson(User data) => json.encode(data.toJson());

class User {
  User({
    this.count,
    this.success,
    this.users,
  });

  int count;
  bool success;
  List<UserElement> users;

  factory User.fromJson(Map<String, dynamic> json) => User(
    count: json["count"],
    success: json["success"],
    users: List<UserElement>.from(json["users"].map((x) => UserElement.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "count": count,
    "success": success,
    "users": List<dynamic>.from(users.map((x) => x.toJson())),
  };
}

class UserElement {
  UserElement({
    this.current,
    this.employeeId,
    this.fcm,
    this.isAdmin,
    this.name,
    this.overall,
    this.phone,
    this.photo,
  });

  Current current;
  String employeeId;
  String fcm;
  bool isAdmin;
  String name;
  Overall overall;
  String phone;
  String photo;

  factory UserElement.fromJson(Map<String, dynamic> json) => UserElement(
    current: Current.fromJson(json["current"]),
    employeeId: json["employee_id"],
    fcm: json["fcm"],
    isAdmin: json["is_admin"],
    name: json["name"],
    overall: Overall.fromJson(json["overall"]),
    phone: json["phone"],
    photo: json["photo"],
  );

  Map<String, dynamic> toJson() => {
    "current": current.toJson(),
    "employee_id": employeeId,
    "fcm": fcm,
    "is_admin": isAdmin,
    "name": name,
    "overall": overall.toJson(),
    "phone": phone,
    "photo": photo,
  };
}

class Current {
  Current({
    this.logs,
    this.timestamp,
  });

  List<Log> logs;
  String timestamp;

  factory Current.fromJson(Map<String, dynamic> json) => Current(
    logs: List<Log>.from(json["logs"].map((x) => Log.fromJson(x))),
    timestamp: json["timestamp"],
  );

  Map<String, dynamic> toJson() => {
    "logs": List<dynamic>.from(logs.map((x) => x.toJson())),
    "timestamp": timestamp,
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
  String timestamp;

  factory Log.fromJson(Map<String, dynamic> json) => Log(
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

class Overall {
  Overall({
    this.present,
    this.total,
  });

  int present;
  int total;

  factory Overall.fromJson(Map<String, dynamic> json) => Overall(
    present: json["present"],
    total: json["total"],
  );

  Map<String, dynamic> toJson() => {
    "present": present,
    "total": total,
  };
}
