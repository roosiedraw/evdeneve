import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ProfileModel {
  String id;
  String konum;
  String name;
  String phone;

  ProfileModel(
      {required this.id,
      required this.konum,
      required this.name,
      required this.phone});

  factory ProfileModel.fromDocument(
    Map<String, dynamic> doc,
  ) {
    return ProfileModel(
        id: doc["id"] ?? '',
        konum: doc["konum"],
        name: doc["name"],
        phone: doc["phone"]);
  }
}
