import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:evdeneve/constants.dart';
import 'package:evdeneve/models/talepmodel.dart';
import 'package:evdeneve/services/talep_services.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'home.dart';

class AddTalep extends StatefulWidget {
  const AddTalep({Key? key}) : super(key: key);

  @override
  _AddTalepState createState() => _AddTalepState();
}

class _AddTalepState extends State<AddTalep> {
  String dropdownvalue = 'ALTINDAĞ MAHALLESİ';
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
  String name = "";
  String phone = "";
  FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  TextEditingController _talepBaslikController = TextEditingController();
  TextEditingController _talepAciklamaController = TextEditingController();
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  TalepService _talepService = TalepService();

  @override
  Widget build(BuildContext context) {
    String? email = _firebaseAuth.currentUser?.email.toString();
    return Material(
      child: Scaffold(
        appBar: AppBar(
          elevation: 0,
          centerTitle: true,
          backgroundColor: Colors.grey[300],
          title: Text("Talep Ekle",
              style: TextStyle(
                  color: fourth, fontSize: 20, fontWeight: FontWeight.w500)),
        ),
        resizeToAvoidBottomInset: false,
        backgroundColor: Colors.grey[300],
        body: Stack(
          children: [
            Positioned(
              top: 100,
              left: 15,
              right: 15,
              bottom: 200,
              child: Container(
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(
                        color: fourth, style: BorderStyle.solid, width: 2)),
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width * 0.8,
                child: Padding(
                  padding: const EdgeInsets.all(18.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      TextField(
                        style: TextStyle(color: fourth),
                        enableSuggestions: true,
                        maxLength: 25,
                        controller: _talepBaslikController,
                        decoration: InputDecoration(
                            enabledBorder: UnderlineInputBorder(
                                borderSide:
                                    BorderSide(color: fourth, width: 2)),
                            focusedBorder: UnderlineInputBorder(
                                borderSide:
                                    BorderSide(color: fourth, width: 3)),
                            hintText: "Talep Başlığı",
                            hintStyle: TextStyle(color: fourth)),
                      ),
                      TextField(
                        enableSuggestions: true,
                        maxLength: 45,
                        controller: _talepAciklamaController,
                        decoration: InputDecoration(
                            enabledBorder: UnderlineInputBorder(
                                borderSide:
                                    BorderSide(color: fourth, width: 2)),
                            focusedBorder: UnderlineInputBorder(
                                borderSide:
                                    BorderSide(color: fourth, width: 3)),
                            hintText: "Talep Açıklaması",
                            hintStyle: TextStyle(
                              color: fourth,
                            )),
                      ),

                      Container(
                        width: 200,
                        padding: const EdgeInsets.symmetric(
                            horizontal: 12, vertical: 8),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(
                                color: fourth,
                                width: 1,
                                style: BorderStyle.solid)),
                        child: DropdownButton(
                          isExpanded: true,
                          dropdownColor: Colors.white,
                          isDense: true,
                          underline: DropdownButtonHideUnderline(
                            child: Container(),
                          ),
                          style: TextStyle(
                              color: fourth,
                              letterSpacing: 1,
                              fontFamily: "roboto",
                              fontSize: 12),
                          // Initial Value
                          value: dropdownvalue,

                          // Down Arrow Icon
                          icon: const Icon(Icons.keyboard_arrow_down),

                          // Array list of items
                          items: items.map((String items) {
                            return DropdownMenuItem(
                              value: items,
                              child: Text(
                                items,
                                style: TextStyle(fontSize: 12),
                              ),
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
                      ElevatedButton(
                        onPressed: () {
                          name =
                              _firebaseAuth.currentUser!.displayName.toString();
                          phone =
                              _firebaseAuth.currentUser!.phoneNumber.toString();
                          TalepService().addStatus(
                              _talepBaslikController.text,
                              _talepAciklamaController.text,
                              dropdownvalue,
                              name,
                              phone,
                              email!);

                          Navigator.push(context,
                              MaterialPageRoute(builder: (context) => Home()));
                        },
                        child: Text(
                          "Paylaş",
                          style: TextStyle(fontSize: 17),
                        ),
                        style: ElevatedButton.styleFrom(
                          fixedSize: Size(100, 30),
                          elevation: 10,
                          primary: fourth,
                        ),
                      ),
                      //imagePlace(),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
