import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class TalepModel {
  String id;
  String baslik;
  String aciklama;
  String konum;
  String name;
  String phone;
  String email;
  TalepModel(
      {required this.id,
      required this.baslik,
      required this.aciklama,
      required this.konum,
      required this.name,
      required this.phone,
      required this.email});

  factory TalepModel.fromDocument(Map<String, dynamic> doc) {
    return TalepModel(
        id: doc["id"] ?? '',
        baslik: doc["baslik"],
        aciklama: doc["aciklama"],
        konum: doc["konum"],
        name: doc["name"],
        phone: doc["phone"],
        email: doc["email"]);
  }
}
