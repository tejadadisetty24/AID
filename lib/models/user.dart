// To parse this JSON data, do
//
//     final AppUser = AppUserFromJson(jsonString);

// ignore_for_file: non_constant_identifier_names

import 'dart:convert';

AppUser appUser = AppUser(
    address: "address",
    gender: "gender",
    mobileNumber: "mobileNumber",
    lastName: "lastName",
    alternativeNumber: "alternativeNumber",
    bloodGroup: "bloodGroup",
    firstName: "firstName",
    age: "age",
    email: "email");
String appUserImgUrl =
    "https://cdn.pixabay.com/photo/2020/07/01/12/58/icon-5359553_1280.png";
AppUser AppUserFromJson(String str) => AppUser.fromJson(json.decode(str));

String AppUserToJson(AppUser data) => json.encode(data.toJson());

class AppUser {
  AppUser(
      {required this.address,
      required this.gender,
      required this.mobileNumber,
      required this.lastName,
      required this.alternativeNumber,
      required this.bloodGroup,
      required this.firstName,
      required this.email,
      required this.age});

  final String address;
  final String gender;
  final String mobileNumber;
  final String lastName;
  final String alternativeNumber;
  final String bloodGroup;
  final String firstName;
  final String email;
  final String age;

  factory AppUser.fromJson(Map<String, dynamic> json) {
    return AppUser(
      address: json["address"],
      gender: json["gender"],
      mobileNumber: json["mobileNumber"],
      lastName: json["last_name"],
      alternativeNumber: json["alternativeNumber"],
      bloodGroup: json["blood_group"],
      firstName: json["first_name"],
      email: json["email"],
      age: json["age"].toString(),
    );
  }

  Map<String, dynamic> toJson() => {
        "address": address,
        "gender": gender,
        "mobileNumber": mobileNumber,
        "last_name": lastName,
        "alternativeNumber": alternativeNumber,
        "blood_group": bloodGroup,
        "first_name": firstName,
        "email": email,
        "age": age,
      };
}
