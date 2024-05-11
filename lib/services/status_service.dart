import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:evdeneve/models/status.dart';
import 'package:evdeneve/register.dart';
import 'package:http/http.dart';
import 'package:image_picker/image_picker.dart';

import 'storage_service.dart';

class StatusService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  StorageService _storageService = StorageService();
  String mediaUrl = "";
  String mediaUrl1 = "";
  String mediaUrl2 = "";

  //veri ekleme
  Future<Status> addStatus(
      String baslik,
      String aciklama,
      String fiyat,
      String konum,
      XFile pickedFile,
      XFile pickedFile1,
      XFile pickedFile2,
      String name,
      String phone,
      String email) async {
    var ref = _firestore.collection("Sata");

    /*mediaUrl = await _storageService.uploadMedia(File(pickedFile.path));
    mediaUrl1 = await _storageService.uploadMedia(File(pickedFile1.path));
    mediaUrl2 = await _storageService.uploadMedia(File(pickedFile2.path));*/
    var documentRef = await ref.add({
      "id": _firestore.collection("Sata").doc().id,
      "baslik": baslik,
      "aciklama": aciklama,
      "fiyat": fiyat,
      "konum": konum,
      "image": mediaUrl,
      "image1": mediaUrl1,
      "image2": mediaUrl2,
      "name": name,
      "phone": phone,
      "email": email
    });

    return Status(
        id: documentRef.id,
        baslik: baslik,
        aciklama: aciklama,
        fiyat: fiyat,
        konum: konum,
        image: mediaUrl,
        image1: mediaUrl1,
        image2: mediaUrl2,
        name: name,
        phone: phone,
        email: email);
  }

  //veri gösterme
  Stream<QuerySnapshot> getStatus() {
    var ref = _firestore.collection("Sata").snapshots();

    return ref;
  }

  //status silmek için
  Future<void> removeStatus(
    String docId,
  ) {
    var ref = _firestore.collection("Sata").doc(docId).delete();

    return ref;
  }

  /*veri filtreleme
  Stream<QuerySnapshot> getFilteredStatus() {
    var filtered = _firestore.collection('Sata').doc("konum");
    var other = _firestore.collection("Person").doc("sehir").get().toString();

    var son = _firestore
        .collection("Sata")
        .where('konum'.toLowerCase().toString(), isEqualTo: other)
        .snapshots();

    return son;
  }*/
}
