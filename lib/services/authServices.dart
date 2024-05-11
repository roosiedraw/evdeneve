import 'dart:io';

import 'package:evdeneve/login.dart';
import 'package:evdeneve/models/profilemodel.dart';
import 'package:evdeneve/services/storage_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  StorageService _storageService = StorageService();
  var phone;

  var merge;
  String mediaurl = "";
//Giriş Yap fonksiyonu
  Future<User?> signIn(String email, String password) async {
    var user = await _auth.signInWithEmailAndPassword(
        email: email, password: password);

    return user.user;
  }

//Çıkış Yap fonksiyonu
  signOut() async {
    return await _auth.signOut();
  }

//Kayıt ol fonksiyonu
  Future<User?> createPerson(String name, String email, String password,
      String telefon, String dropdownvalue, XFile pickedFile) async {
    var user = await _auth.createUserWithEmailAndPassword(
        email: email, password: password);
    mediaurl = await _storageService.uploadMedia(File(pickedFile.path));
    _firestore.collection("Person").doc(user.user?.uid).set({
      'name': name,
      'email': email,
      'telefon': telefon,
      'password': password,
      'sehir': dropdownvalue,
      'profilfoto': mediaurl
    });

    return user.user;
  }

  //veri gösterme
  Stream<QuerySnapshot<Map<String, dynamic>>> getStatus() {
    var ref = _firestore.collection("Person").snapshots();

    return ref;
  }

  //update
  Future<DocumentReference<Map<String, dynamic>>> updatePerson(String name,
      String telefon, String dropdownvalue, XFile pickedFile) async {
    var user = await _auth.currentUser!.uid;
    var ref = _firestore.collection("Person").doc(user);
    mediaurl = await _storageService.uploadMedia(File(pickedFile.path));
    var documentRef = ref.update({
      'name': name,
      'phone': telefon,
      'sehir': dropdownvalue,
      "profilfoto": mediaurl,
    });
    SetOptions(merge: false);

    return ref;
  }

  Future getCurrentUser() async {
    var user = await FirebaseAuth.instance.currentUser!;

    if (user != null) {
      return user;
    } else {
      return Login();
    }
  }

  //deleteuser
  Future deleteUser(String email, String password) async {
    try {
      var user = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      AuthCredential credentials =
          EmailAuthProvider.credential(email: email, password: password);
      print(user);

      await user.user!.delete();
      return true;
    } catch (e) {
      print(e.toString());
      return null;
    }
  }
}
