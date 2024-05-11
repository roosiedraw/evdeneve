import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Status {
  String id;
  String baslik;
  String aciklama;
  String fiyat;
  String konum;
  String image;
  String image1;
  String image2;
  String name;
  String phone;
  String email;

  Status(
      {required this.id,
      required this.baslik,
      required this.aciklama,
      required this.fiyat,
      required this.konum,
      required this.image,
      required this.image1,
      required this.image2,
      required this.name,
      required this.phone,
      required this.email});

  factory Status.fromDocument(Map<String, dynamic> doc) {
    return Status(
      id: doc["id"] ?? '',
      baslik: doc["baslik"],
      aciklama: doc["aciklama"],
      fiyat: doc["fiyat"],
      konum: doc["konum"],
      image: doc["image"],
      image1: doc["image1"],
      image2: doc["image2"],
      name: doc["name"],
      phone: doc["phone"],
      email: doc["email"],
    );
  }
}
