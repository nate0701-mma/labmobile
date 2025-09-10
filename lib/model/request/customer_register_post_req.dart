// To parse this JSON data, do
//
//     final customerRegisterPostReques = customerRegisterPostRequesFromJson(jsonString);

import 'dart:convert';

CustomerRegisterPostReques customerRegisterPostRequesFromJson(String str) =>
    CustomerRegisterPostReques.fromJson(json.decode(str));

String customerRegisterPostRequesToJson(CustomerRegisterPostReques data) =>
    json.encode(data.toJson());

class CustomerRegisterPostReques {
  String fullname;
  String phone;
  String email;
  String image;
  String password;

  CustomerRegisterPostReques({
    required this.fullname,
    required this.phone,
    required this.email,
    required this.image,
    required this.password,
  });

  factory CustomerRegisterPostReques.fromJson(Map<String, dynamic> json) =>
      CustomerRegisterPostReques(
        fullname: json["fullname"],
        phone: json["phone"],
        email: json["email"],
        image: json["image"],
        password: json["password"],
      );

  Map<String, dynamic> toJson() => {
    "fullname": fullname,
    "phone": phone,
    "email": email,
    "image": image,
    "password": password,
  };
}
