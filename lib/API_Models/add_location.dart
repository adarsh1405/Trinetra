// To parse this JSON data, do
//
//     final addlocation = addlocationFromJson(jsonString);

import 'dart:convert';

Addlocation addlocationFromJson(String str) => Addlocation.fromJson(json.decode(str));

String addlocationToJson(Addlocation data) => json.encode(data.toJson());

class Addlocation {
  Addlocation({
    this.id,
    this.location,
    this.place,
    this.success,
  });

  String id;
  List<Location> location;
  String place;
  bool success;

  factory Addlocation.fromJson(Map<String, dynamic> json) => Addlocation(
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
