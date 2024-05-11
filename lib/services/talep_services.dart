import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:evdeneve/models/talepmodel.dart';

class TalepService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  //veri ekleme
  Future<TalepModel> addStatus(String baslik, String aciklama, String konum,
      String name, String phone, String email) async {
    var ref = _firestore.collection("Talep");

    var documentRef = await ref.add({
      "id": _firestore.collection("Talep").id,
      "baslik": baslik,
      "aciklama": aciklama,
      "konum": konum,
      "name": name,
      "phone": phone,
      "email": email
    });

    return TalepModel(
        id: documentRef.id,
        baslik: baslik,
        aciklama: aciklama,
        konum: konum,
        name: name,
        phone: phone,
        email: email);
  }

  //veri gösterme
  Stream<QuerySnapshot> getStatus() {
    var ref = _firestore.collection("Talep").snapshots();

    return ref;
  }

  //status silmek için
  Future<void> removeStatus(String docId) {
    var ref = _firestore.collection("Talep").doc(docId).delete();

    return ref;
  }
}
