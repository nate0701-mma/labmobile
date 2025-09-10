// To parse this JSON data, do
//
//     final tripGetRespone = tripGetResponeFromJson(jsonString);

import 'dart:convert';

List<TripGetRespone> tripGetResponeFromJson(String str) =>
    List<TripGetRespone>.from(
      json.decode(str).map((x) => TripGetRespone.fromJson(x)),
    );

String tripGetResponeToJson(List<TripGetRespone> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class TripGetRespone {
  int idx;
  String name;
  String country;
  String coverimage;
  String detail;
  int price;
  int duration;
  String destinationZone;

  TripGetRespone({
    required this.idx,
    required this.name,
    required this.country,
    required this.coverimage,
    required this.detail,
    required this.price,
    required this.duration,
    required this.destinationZone,
  });

  factory TripGetRespone.fromJson(Map<String, dynamic> json) => TripGetRespone(
    idx: json["idx"],
    name: json["name"],
    country: json["country"],
    coverimage: json["coverimage"],
    detail: json["detail"],
    price: json["price"],
    duration: json["duration"],
    destinationZone: json["destination_zone"],
  );

  Map<String, dynamic> toJson() => {
    "idx": idx,
    "name": name,
    "country": country,
    "coverimage": coverimage,
    "detail": detail,
    "price": price,
    "duration": duration,
    "destination_zone": destinationZone,
  };
}
