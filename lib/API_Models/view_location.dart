// To parse this JSON data, do
//
//     final viewlocation = viewlocationFromJson(jsonString);

import 'dart:convert';

Viewlocation viewlocationFromJson(String str) => Viewlocation.fromJson(json.decode(str));

String viewlocationToJson(Viewlocation data) => json.encode(data.toJson());

class Viewlocation {
  Viewlocation({
    this.id,
    this.location,
    this.place,
    this.success,
  });

  String id;
  List<Location> location;
  String place;
  bool success;

  factory Viewlocation.fromJson(Map<String, dynamic> json) => Viewlocation(
    id: json["id"],
    location: List<Location>.from(json["location"].map((x) => Location.fromJson(x))),
    place: json["place"],
    success: json["success"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "location": List<dynamic>.from(location.map((x) => x.toJson())),
    "place": place,
    "success": success,
  };
}

class Location {
  Location({
    this.lat,
    this.lon,
  });

  String lat;
  String lon;

  factory Location.fromJson(Map<String, dynamic> json) => Location(
    lat: json["lat"],
    lon: json["lon"],
  );

  Map<String, dynamic> toJson() => {
    "lat": lat,
    "lon": lon,
  };
}
