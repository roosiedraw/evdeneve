// ignore_for_file: curly_braces_in_flow_control_structures

import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:evdeneve/constants.dart';
import 'package:evdeneve/login.dart';
import 'package:evdeneve/services/authServices.dart';
import 'package:evdeneve/services/profileservices.dart';
import 'package:evdeneve/services/status_service.dart';

import 'package:flutter/material.dart';

import 'package:image_picker/image_picker.dart';

class Register extends StatefulWidget {
  const Register({Key? key}) : super(key: key);

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
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
    "ZEYTİNLİK MAHALLESİ"
  ];

  List<XFile>? imagefiles;
  var profileImage;

  final TextEditingController _nameController = TextEditingController();

  final TextEditingController _emailController = TextEditingController();

  final TextEditingController _passwordController = TextEditingController();

  final TextEditingController _telefonController = TextEditingController();

  AuthService _authService = AuthService();

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  StatusService _statusService = StatusService();
  final ImagePicker _pickerImage = ImagePicker();
  dynamic _pickImage;
//-----------------------------------
  Widget imagePlace() {
    double height = MediaQuery.of(context).size.height;
    if (profileImage != null) {
      return FittedBox(
        fit: BoxFit.contain,
        child: CircleAvatar(
            backgroundImage: FileImage(File(profileImage!.path)),
            radius: height * 0.08),
      );
    } else {
      if (_pickImage != null) {
        return FittedBox(
          fit: BoxFit.contain,
          child: CircleAvatar(
            backgroundImage: NetworkImage(_pickImage),
            radius: height * 0.08,
          ),
        );
      } else
        return FittedBox(
          fit: BoxFit.contain,
          child: CircleAvatar(
            backgroundImage: const AssetImage("assets/images/logo.png"),
            radius: height * 0.08,
          ),
        );
    }
  }

//-----------------------------------
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        resizeToAvoidBottomInset: false,
        body: SingleChildScrollView(
          child: Stack(
            children: [
              Container(
                  child: Padding(
                    padding: const EdgeInsets.only(
                        right: 80.0, left: 80, top: 50, bottom: 50),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(
                          height: 10,
                        ),
                        TextFormField(
                          controller: _nameController,
                          cursorColor: second,
                          style: TextStyle(
                            fontSize: 16,
                            color: fourth,
                          ),
                          autofocus: true,
                          decoration: InputDecoration(
                            labelStyle: TextStyle(
                                color: fourth,
                                fontSize: 15,
                                fontWeight: FontWeight.bold),
                            labelText: "Ad Soyad",
                            focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(30.0),
                                borderSide:
                                    BorderSide(color: second, width: 2)),
                            enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: second),
                                borderRadius: BorderRadius.circular(20.0)),
                            prefixIcon: const Icon(
                              Icons.person,
                              color: Colors.green,
                            ),
                          ),
                        ),
                        SizedBox(height: 13),
                        TextFormField(
                          controller: _emailController,
                          cursorColor: second,
                          style: TextStyle(
                            fontSize: 16,
                            color: fourth,
                          ),
                          autofocus: true,
                          decoration: InputDecoration(
                            labelStyle: TextStyle(
                                color: fourth,
                                fontSize: 15,
                                fontWeight: FontWeight.bold),
                            labelText: "Email",
                            focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(30.0),
                                borderSide:
                                    BorderSide(color: second, width: 2)),
                            enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: second),
                                borderRadius: BorderRadius.circular(20.0)),
                            prefixIcon: const Icon(
                              Icons.person,
                              color: Colors.green,
                            ),
                          ),
                        ),
                        SizedBox(height: 13),
                        TextFormField(
                          controller: _telefonController,
                          cursorColor: second,
                          style: TextStyle(
                            fontSize: 16,
                            color: fourth,
                          ),
                          autofocus: true,
                          decoration: InputDecoration(
                            labelStyle: TextStyle(
                                color: fourth,
                                fontSize: 15,
                                fontWeight: FontWeight.bold),
                            labelText: "Telefon",
                            focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(30.0),
                                borderSide:
                                    BorderSide(color: second, width: 2)),
                            enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: second),
                                borderRadius: BorderRadius.circular(20.0)),
                            prefixIcon: const Icon(
                              Icons.person,
                              color: Colors.green,
                            ),
                          ),
                        ),
                        SizedBox(height: 13),
                        TextFormField(
                          controller: _passwordController,
                          cursorColor: second,
                          style: TextStyle(
                            fontSize: 16,
                            color: fourth,
                          ),
                          autofocus: true,
                          decoration: InputDecoration(
                            labelStyle: TextStyle(
                                color: fourth,
                                fontSize: 15,
                                fontWeight: FontWeight.bold),
                            labelText: "Şifre Oluştur",
                            focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(30.0),
                                borderSide:
                                    BorderSide(color: second, width: 2)),
                            enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: second),
                                borderRadius: BorderRadius.circular(20.0)),
                            prefixIcon: const Icon(
                              Icons.person,
                              color: Colors.green,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: DropdownButton(
                            // Initial Value
                            dropdownColor: primary,
                            value: dropdownvalue,
                            isExpanded: true,
                            // Down Arrow Icon
                            icon: const Icon(Icons.keyboard_arrow_down),

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
                        SizedBox(height: 10),
                        ElevatedButton(
                            onPressed: () {
                              _authService
                                  .createPerson(
                                      _nameController.text,
                                      _emailController.text,
                                      _passwordController.text,
                                      _telefonController.text,
                                      dropdownvalue,
                                      profileImage)
                                  .then((_) {
                                ProfileService().addProfile(
                                  _nameController.text,
                                  _telefonController.text,
                                  dropdownvalue,
                                );
                                print("succeed");
                                return Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => Login()),
                                );
                              });
                            },
                            style: ElevatedButton.styleFrom(
                                elevation: 15,
                                minimumSize: Size(200, 60),
                                primary: fourth,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(20),
                                        bottomRight: Radius.circular(20)))),
                            child: Text("Ödemeye İlerle",
                                style: TextStyle(color: primary, fontSize: 20)))
                      ],
                    ),
                  ),
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height,
                  decoration: BoxDecoration(
                    color: primary,
                  )),
              Positioned(
                top: MediaQuery.of(context).size.height * -0.25,
                bottom: MediaQuery.of(context).size.height * 0.75,
                left: MediaQuery.of(context).size.width * 0.0,
                right: MediaQuery.of(context).size.width * 0.0,
                child: Container(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        colorFilter: new ColorFilter.mode(
                            Colors.black.withOpacity(0.2), BlendMode.dstATop),
                        image: AssetImage("assets/images/apartman.png"),
                        fit: BoxFit.cover,
                      ),
                      borderRadius:
                          BorderRadius.only(bottomLeft: Radius.circular(90)),
                      color: fourth,
                    )),
              ),
              Positioned(
                  top: MediaQuery.of(context).size.height * 0.16,
                  bottom: MediaQuery.of(context).size.height * 0.73,
                  left: MediaQuery.of(context).size.width * 0.0,
                  right: MediaQuery.of(context).size.width * 0.0,
                  child: imagePlace()),
              Positioned(
                  top: MediaQuery.of(context).size.height * 0.23,
                  bottom: MediaQuery.of(context).size.height * 0.71,
                  left: MediaQuery.of(context).size.width * 0.55,
                  right: MediaQuery.of(context).size.width * 0.35,
                  child: Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30),
                        border: Border.all(
                            color: Colors.amber,
                            style: BorderStyle.solid,
                            width: 1),
                        color: Colors.amberAccent),
                    child: Padding(
                      padding: const EdgeInsets.all(2.0),
                      child: InkWell(
                        onTap: () {
                          _onImageButtonPressed(ImageSource.gallery,
                              context: context);
                        },
                        child: Icon(
                          Icons.add_a_photo,
                          size: 25,
                          color: Colors.black87,
                        ),
                      ),
                    ),
                  )),
              Positioned(
                  top: MediaQuery.of(context).size.height * 0.1,
                  bottom: MediaQuery.of(context).size.height * 0.84,
                  left: MediaQuery.of(context).size.width * 0.05,
                  right: MediaQuery.of(context).size.width * 0.0,
                  child: Text("Üye ol",
                      style: TextStyle(
                          color: primary,
                          fontSize: 25,
                          fontWeight: FontWeight.bold))),
            ],
          ),
        ),
      ),
    );
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
