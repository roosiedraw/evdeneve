import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:evdeneve/models/profilemodel.dart';
import 'package:evdeneve/models/status.dart';
import 'package:image_picker/image_picker.dart';

import 'storage_service.dart';

class ProfileService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  StorageService _storageService = StorageService();
  String mediaUrl = "";

  //veri ekleme
  Future<ProfileModel> addProfile(
      String name, String phone, String konum) async {
    var ref = _firestore.collection("Profil");

    //mediaUrl = await _storageService.uploadMedia(File(pickedFile.path));

    var documentRef = await ref.add({
      "id": _firestore.collection("Profil").id,
      "konum": konum,
      "name": name,
      "phone": phone
    });

    return ProfileModel(
        id: documentRef.id, name: name, phone: phone, konum: konum);
  }

  //veri gösterme
  Stream<QuerySnapshot> getStatus() {
    var ref = _firestore.collection("Profile").snapshots();

    return ref;
  }
}
