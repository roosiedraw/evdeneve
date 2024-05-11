import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:evdeneve/constants.dart';
import 'package:evdeneve/login.dart';
import 'package:evdeneve/pages/benimilan.dart';
import 'package:evdeneve/pages/benimtalep.dart';
import 'package:evdeneve/pages/master.dart';
import 'package:evdeneve/services/authServices.dart';
import 'package:evdeneve/services/profileservices.dart';
import 'package:evdeneve/services/status_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';

import 'package:image_picker/image_picker.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  void initState() {
    super.initState();
    if (FirebaseAuth.instance.currentUser?.email == "1@gmail.com") {
      _mastered = true;
    } else {
      _mastered = false;
    }
  }

  bool _isvisible = true;
  bool _light = true;
  bool _mastered = false;
  var items = [
    "ALTINDAĞ MAHALLESİ",
    "BAHÇELİEVLER MAHALLESİ",
    "BALBEY MAHALLESİ",
    "BARBAROS MAHALLESİ",
    "BAYINDIR MAHALLESİ",
    "CUMHURİYET MAHALLESİ",
    "ÇAĞLAYAN MAHALLESİ",
    "ÇAYBAŞI MAHALLESİ",
    "DEMİRCİKARA MAHALLESİ",
    "DENİZ MAHALLESİ",
    "DOĞUYAKA MAHALLESİ",
    "DUTLUBAHÇE MAHALLESİ",
    "ELMALI MAHALLESİ",
    "ERMENEK MAHALLESİ",
    "ETİLER MAHALLESİ",
    "FENER MAHALLESİ",
    "GEBİZLİ MAHALLESİ",
    "GENÇLİK MAHALLESİ",
    "GÜVENLİK MAHALLESİ",
    "GÜZELBAĞ MAHALLESİ",
    "GÜZELOBA MAHALLESİ",
    "GÜZELOLUK MAHALLESİ",
    "HAŞİMİŞCAN MAHALLESİ",
    "KILINÇARSLAN MAHALLESİ",
    "KIRCAMİ MAHALLESİ",
    "KIŞLA MAHALLESİ",
    "KIZILARIK MAHALLESİ",
    "KIZILSARAY MAHALLESİ",
    "KIZILTOPRAK MAHALLESİ",
    "KONUKSEVER MAHALLESİ",
    "MEHMETÇİK MAHALLESİ",
    "MELTEM MAHALLESİ",
    "MEMUREVLERİ MAHALLESİ",
    "MEYDANKAVAĞI MAHALLESİ",
    "MURATPAŞA MAHALLESİ",
    "SEDİR MAHALLESİ",
    "SELÇUK MAHALLESİ",
    "SİNAN MAHALLESİ",
    "SOĞUKSU MAHALLESİ",
    "ŞİRİNYALI MAHALLESİ",
    "TAHILPAZARI MAHALLESİ",
    "TARIM MAHALLESİ",
    "TOPÇULAR MAHALLESİ",
    "TUZCULAR MAHALLESİ",
    "ÜÇGEN MAHALLESİ",
    "VARLIK MAHALLESİ",
    "YENİGÖL MAHALLESİ",
    "YENİGÜN MAHALLESİ",
    "YEŞİLBAHÇE MAHALLESİ",
    "YEŞİLDERE MAHALLESİ",
    "YEŞİLOVA MAHALLESİ",
    "YILDIZ MAHALLESİ",
    "YÜKSEKALAN MAHALLESİ",
    "ZERDALİLİK MAHALLESİ",
    "ZÜMRÜTOVA MAHALLESİ",
    "AHATLI MAHALLESİ",
    "AKTOPRAK MAHALLESİ",
    "ALTIAYAK MAHALLESİ",
    "ALTINOVA DÜDEN MAHALLESİ",
    "ALTINOVA ORTA MAHALLESİ",
    "ALTINOVA SİNAN MAHALLESİ",
    "ATATÜRK MAHALLESİ",
    "AVNİ TOLUNAY MAHALLESİ",
    "AYANOĞLU MAHALLESİ",
    "AYDOĞMUŞ MAHALLESİ",
    "BARAJ MAHALLESİ",
    "BARIŞ MAHALLESİ",
    "BAŞKÖY MAHALLESİ",
    "BEŞKONAKLILAR MAHALLESİ",
    "ÇAMLIBEL MAHALLESİ",
    "ÇAMLICA MAHALLESİ",
    "ÇANKAYA MAHALLESİ",
    "DEMİREL MAHALLESİ",
    "DUACI MAHALLESİ",
    "DURALİLER MAHALLESİ",
    "DÜDENBAŞI MAHALLESİ",
    "EMEK MAHALLESİ",
    "ERENKÖY MAHALLESİ",
    "ESENTEPE MAHALLESİ",
    "FABRİKALAR MAHALLESİ",
    "FATİH MAHALLESİ",
    "FEVZİ ÇAKMAK MAHALLESİ",
    "GAZİ MAHALLESİ",
    "GAZİLER MAHALLESİ",
    "GÖÇERLER MAHALLESİ",
    "GÖKSU MAHALLESİ",
    "GÜLVEREN MAHALLESİ",
    "GÜNDOĞDU MAHALLESİ",
    "GÜNEŞ MAHALLESİ",
    "HABİBLER MAHALLESİ",
    "HÜSNÜ KARAKAŞ MAHALLESİ",
    "KANAL MAHALLESİ",
    "KARŞIYAKA MAHALLESİ",
    "KAZIM KARABEKİR MAHALLESİ",
    "KEPEZ MAHALLESİ",
    "KIZILLI MAHALLESİ",
    "KİRİŞÇİLER MAHALLESİ",
    "KUZEYYAKA MAHALLESİ",
    "KÜLTÜR MAHALLESİ",
    "KÜTÜKÇÜ MAHALLESİ",
    "MEHMET AKİF ERSOY MAHALLESİ",
    "MENDERES MAHALLESİ",
    "ODABAŞI MAHALLESİ",
    "ÖZGÜRLÜK MAHALLESİ",
    "SANTRAL MAHALLESİ",
    "SÜTÇÜLER MAHALLESİ",
    "ŞAFAK MAHALLESİ",
    "ŞELALE MAHALLESİ",
    "TEOMANPAŞA MAHALLESİ",
    "ULUS MAHALLESİ",
    "ÜNSAL MAHALLESİ",
    "VARSAK ESENTEPE MAHALLESİ",
    "VARSAK KARŞIYAKA MAHALLESİ",
    "VARSAK MENDERES MAHALLESİ",
    "YAVUZ SELİM MAHALLESİ",
    "YENİ MAHALLESİ",
    "YENİ DOĞAN MAHALLESİ",
    "YENİ EMEK MAHALLESİ",
    "YEŞİLTEPE MAHALLESİ",
    "YEŞİLYURT MAHALLESİ",
    "YÜKSELİŞ MAHALLESİ",
    "ZAFER MAHALLESİ",
    "ZEYTİNLİK MAHALLESİ",
  ];
  String dropdownvalue = "ALTINDAĞ MAHALLESİ";
  int index = 0;
  FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  TextEditingController _phoneController = TextEditingController();
  TextEditingController _profilController = TextEditingController();
  XFile? profileImage;
  final ImagePicker _pickerImage = ImagePicker();
  dynamic _pickImage;
  //-----------------------------------
  Widget imagePlace() {
    double height = MediaQuery.of(context).size.height;
    if (profileImage != null) {
      return CircleAvatar(
          backgroundImage: FileImage(File(profileImage!.path)),
          radius: height * 0.08);
    } else {
      if (_pickImage != null) {
        return CircleAvatar(
          backgroundImage: NetworkImage(_pickImage),
          radius: height * 0.08,
        );
      } else
        return CircleAvatar(
          backgroundImage: AssetImage("assets/images/logo.png"),
          radius: height * 0.08,
        );
    }
  }

//-----------------------------------

  //-----------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<DocumentSnapshot>(
        stream: FirebaseFirestore.instance
            .collection("Person")
            .doc(_firebaseAuth.currentUser?.uid)
            .snapshots(),
        builder: (context, AsyncSnapshot) {
          return Scaffold(
              backgroundColor: Colors.grey[300],
              body: Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                child: Stack(
                  children: [
                    Positioned(
                      top: -10,
                      left: 10,
                      right: 10,
                      child: Material(
                        elevation: 1,
                        borderRadius: BorderRadius.circular(10),
                        child: Container(
                          width: MediaQuery.of(context).size.width,
                          height: MediaQuery.of(context).size.height * 0.35,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.grey[300],
                            border: Border.all(style: BorderStyle.none),
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              imagePlace(),
                              SizedBox(
                                height: 5,
                              ),
                              Container(
                                child: Padding(
                                  padding: const EdgeInsets.all(12.0),
                                  child: Visibility(
                                    maintainSize: true,
                                    maintainAnimation: true,
                                    maintainState: true,
                                    visible: _isvisible,
                                    child: Text(
                                      "${AsyncSnapshot.data?.get("name")}",
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 18),
                                    ),
                                  ),
                                ),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  border: Border.all(
                                      color: fifth,
                                      style: BorderStyle.solid,
                                      width: 2),
                                ),
                              ),
                              Visibility(
                                  maintainSize: true,
                                  maintainAnimation: true,
                                  maintainState: true,
                                  visible: _isvisible,
                                  child: Text(
                                      "${AsyncSnapshot.data?.get("sehir")}")),
                            ],
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      top: 150,
                      left: 70,
                      right: 60,
                      child: Visibility(
                        maintainSize: true,
                        maintainAnimation: true,
                        maintainState: true,
                        visible: !_isvisible,
                        child: DropdownButton(
                          isExpanded: false,
                          // Initial Value
                          value: dropdownvalue,

                          // Down Arrow Icon
                          icon: const Icon(
                            Icons.keyboard_arrow_down,
                            color: Colors.amber,
                          ),

                          // Array list of items
                          items: items.map((String items) {
                            return DropdownMenuItem(
                              value: items,
                              child: Text(items),
                            );
                          }).toList(),
                          // After selecting the desired option,it will
                          // change button value to selected value
                          onChanged: (String? newValue) {
                            setState(() {
                              dropdownvalue = newValue!;
                            });
                          },
                        ),
                      ),
                    ),
                    Positioned(
                        top: 175,
                        right: 20,
                        child: InkWell(
                          onTap: () {
                            setState(() {
                              _isvisible = !_isvisible;
                              print(_isvisible.toString());
                            });
                          },
                          child: Icon(
                            Icons.edit,
                            color: Colors.blueGrey,
                          ),
                        )),
                    Positioned(
                        top: 20,
                        right: 20,
                        child: Visibility(
                            maintainSize: true,
                            maintainAnimation: true,
                            maintainState: true,
                            visible: _mastered,
                            child: InkWell(
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => Master()));
                                },
                                child: Icon(
                                  Icons.settings,
                                  color: Colors.blueGrey,
                                )))),
                    Positioned(
                      top: 120,
                      left: 145,
                      child: Visibility(
                        child: SizedBox(
                          height: 30,
                          width: 130,
                          child: TextField(
                            controller: _profilController,
                            cursorColor: Colors.black,
                            style: TextStyle(color: fourth),
                            decoration: const InputDecoration(
                                enabledBorder: UnderlineInputBorder(
                                    borderSide:
                                        BorderSide(color: Colors.black)),
                                focusedBorder: UnderlineInputBorder(
                                    borderSide:
                                        BorderSide(color: Colors.black)),
                                hintText: "Ad Soyad",
                                hintStyle: TextStyle(color: Colors.black38)),
                          ),
                        ),
                        maintainSize: true,
                        maintainAnimation: true,
                        maintainState: true,
                        visible: !_isvisible,
                      ),
                    ),
                    Positioned(
                        top: 240,
                        left: 30,
                        right: 30,
                        child: Container(
                          width: MediaQuery.of(context).size.width,
                          height: MediaQuery.of(context).size.height * 0.06,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Color(0xFF050A41),
                            border: Border.all(style: BorderStyle.none),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              SizedBox(
                                width: 10,
                              ),
                              Icon(
                                Icons.email,
                                color: Colors.white,
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Text(
                                "${AsyncSnapshot.data?.get("email")}",
                                style: TextStyle(
                                    color: primary,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 15),
                              ),
                            ],
                          ),
                        )),
                    Positioned(
                        top: 77,
                        left: 230,
                        child: Visibility(
                          maintainSize: true,
                          maintainAnimation: true,
                          maintainState: true,
                          visible: !_isvisible,
                          child: InkWell(
                            onTap: () {
                              _onImageButtonPressed(ImageSource.gallery,
                                  context: context);
                            },
                            child: Icon(
                              Icons.add_a_photo,
                              size: 25,
                              color: Colors.amber,
                            ),
                          ),
                        )),
                    Positioned(
                      top: 285,
                      left: 30,
                      right: 30,
                      child: Container(
                        width: MediaQuery.of(context).size.width,
                        height: MediaQuery.of(context).size.height * 0.06,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Color(0xFF05412F),
                          border: Border.all(style: BorderStyle.none),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            SizedBox(
                              width: 10,
                            ),
                            Icon(
                              Icons.phone,
                              color: Colors.white,
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Visibility(
                              child: Text(
                                "${AsyncSnapshot.data?.get("telefon")}",
                                style: TextStyle(
                                    fontSize: 15, color: Colors.white),
                              ),
                              maintainSize: false,
                              maintainAnimation: false,
                              maintainState: false,
                              visible: _isvisible,
                            ),
                            Visibility(
                              child: SizedBox(
                                child: TextField(
                                  controller: _phoneController,
                                  cursorColor: Colors.white,
                                  style: const TextStyle(color: Colors.white),
                                  decoration: const InputDecoration(
                                      enabledBorder: UnderlineInputBorder(
                                          borderSide:
                                              BorderSide(color: Colors.white)),
                                      focusedBorder: UnderlineInputBorder(
                                          borderSide:
                                              BorderSide(color: Colors.white)),
                                      hintText: "phone",
                                      hintStyle:
                                          TextStyle(color: Colors.white60)),
                                ),
                                width: 200,
                              ),
                              maintainSize: true,
                              maintainAnimation: true,
                              maintainState: true,
                              visible: !_isvisible,
                            ),
                          ],
                        ),
                      ),
                    ),
                    Positioned(
                        top: 350,
                        left: 20,
                        right: 20,
                        child: Card(
                          shadowColor: const Color(0xFF05412F),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10)),
                          elevation: 20,
                          child: Container(
                            decoration: BoxDecoration(
                              //border: Border.all(width: 2, color: Color(0xFF05412F)),
                              borderRadius: BorderRadius.circular(10),
                              color: Colors.grey[300],
                            ),
                            width: MediaQuery.of(context).size.width * 0.5,
                            height: MediaQuery.of(context).size.height * 0.08,
                            child: ListTile(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => benimIlan()));
                              },
                              title: const Text(
                                "İlanlarım",
                                style: TextStyle(
                                    fontSize: 20, color: Color(0xFF05412F)),
                              ),
                              leading: const Icon(
                                Icons.book,
                                color: Color(0xFF05412F),
                              ),
                              trailing: const Icon(
                                Icons.arrow_forward_ios,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        )),
                    Positioned(
                        top: 420,
                        left: 20,
                        right: 20,
                        child: Card(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10)),
                          elevation: 20,
                          child: Container(
                            decoration: BoxDecoration(
                              //border: Border.all(width: 1, color: Color(0xFF050A41)),
                              borderRadius: BorderRadius.circular(10),
                              color: Colors.grey[300],
                            ),
                            width: MediaQuery.of(context).size.width * 0.5,
                            height: MediaQuery.of(context).size.height * 0.08,
                            child: ListTile(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => benimTalep()));
                              },
                              title: const Text(
                                "Taleplerim",
                                style: TextStyle(
                                    fontSize: 20, color: Color(0xFF050A41)),
                              ),
                              leading: const Icon(
                                Icons.wrap_text,
                                color: Color(0xFF050A41),
                              ),
                              trailing: const Icon(
                                Icons.arrow_forward_ios,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        )),
                    Positioned(
                        top: 510,
                        left: 115,
                        child: Container(
                          height: 40,
                          width: 150,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: Colors.white,
                              border: Border.all(
                                color: Colors.red,
                                width: 2,
                              )),
                          child: InkWell(
                            onTap: () {
                              AuthService().signOut();
                              Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => Login()));
                            },
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: const [
                                Icon(
                                  Icons.exit_to_app,
                                  size: 30,
                                  color: Colors.red,
                                ),
                                Text(
                                  "Çıkış Yap",
                                  style: TextStyle(
                                      fontSize: 20, color: Colors.red),
                                )
                              ],
                            ),
                          ),
                        )),
                    Positioned(
                        top: 506,
                        left: 115,
                        child: Visibility(
                          maintainSize: true,
                          maintainAnimation: true,
                          maintainState: true,
                          visible: !_isvisible,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                primary: Colors.green,
                                shape: ContinuousRectangleBorder(
                                    borderRadius: BorderRadius.circular(20)),
                                fixedSize: const Size(150, 40)),
                            onPressed: () {
                              AuthService().updatePerson(
                                _profilController.text,
                                _phoneController.text,
                                dropdownvalue,
                                profileImage!,
                              );

                              setState(() {
                                _isvisible = !_isvisible;
                              });
                            },
                            child: Text(
                              "Kaydet",
                              style: TextStyle(fontSize: 20),
                            ),
                          ),
                        )),
                    Positioned(
                        top: 556,
                        left: 115,
                        child: ElevatedButton(
                          onPressed: () async {
                            var user = await FirebaseAuth.instance.currentUser!;
                            user.delete();

                            Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => Login()));
                          },
                          child: Text(
                            "Üyeliğimi Sil",
                            style: TextStyle(color: Colors.white),
                          ),
                          style: ElevatedButton.styleFrom(
                              primary: Colors.black,
                              shape: ContinuousRectangleBorder(
                                  borderRadius: BorderRadius.circular(20)),
                              fixedSize: const Size(150, 40)),
                        ))
                  ],
                ),
              ));
        });
  }

  void _onImageButtonPressed(ImageSource source,
      {required BuildContext context}) async {
    try {
      final pickedFile =
          await _pickerImage.pickImage(source: ImageSource.camera);
      setState(() {
        profileImage = pickedFile!;
        print("dosyaya geldim: $profileImage");
        if (profileImage != null) {}
      });
      print('aaa');
    } catch (e) {
      setState(() {
        _pickImage = e;
        print("Image Error: " + _pickImage);
      });
    }
  }
}
