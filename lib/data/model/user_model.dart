import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  final String adress;

  final Timestamp birthdaydate;
  final String username;
  final String phone;


  UserModel({
    required this.adress,

    required this.birthdaydate,
    required this.phone,
    required this.username,

  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
        adress: json['adress'] ?? '',

        birthdaydate: json['birthdaydate'] ?? Timestamp.now(),
        phone: json['phone'] ?? "",
        username: json['name'] ?? "Client",

        );
  }

  Map<String, dynamic> toJson() {
    return {
      'adress': adress,
      'name': username,
      'birthdaydate': birthdaydate,
      'phone': phone,

    };
  }
}
