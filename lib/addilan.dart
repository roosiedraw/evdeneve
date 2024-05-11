import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:evdeneve/constants.dart';
import 'package:evdeneve/home.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:image_picker/image_picker.dart';

import 'services/status_service.dart';

class AddIlan extends StatefulWidget {
  const AddIlan({Key? key}) : super(key: key);

  @override
  _AddIlanState createState() => _AddIlanState();
}

class _AddIlanState extends State<AddIlan> {
  String dropdownvalue = 'ALTINDAĞ MAHALLESİ';
  List<String> sehirler = ["ANTALYA", "MERSİN"];
  List<String> mersinIlceler = ["MEZİTLİ", "POZCU"];
  List<String> antalyaIlceler = ["KEPEZ", "KONYAALTI", "MURATPAŞA"];
  List<String> kepezMahalle = [
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
  List<String> muratpasaMahalle = [
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
  ];
  List<String> konyaaltiMahalle = [];
  List<String> ilceler = [];
  List<String> mahalle = [];
  String? secilenSehir;
  String? secilenIlce;
  String? secilenMahalle;

  var items = ["a", "b"];
  final ImagePicker _pickerImage = ImagePicker();
  String name = "";
  String phone = "";
  List<XFile>? imagefiles;
  FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  TextEditingController _ilanBaslikController = TextEditingController();
  TextEditingController _ilanAciklamaController = TextEditingController();
  TextEditingController _ilanFiyatController = TextEditingController();
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  StatusService _statusService = StatusService();

  @override
  Widget build(BuildContext context) {
    String? email = _firebaseAuth.currentUser?.email.toString();
    return Material(
      child: Scaffold(
        appBar: AppBar(
          elevation: 0,
          centerTitle: true,
          backgroundColor: Colors.grey[300],
          title: Text(
            "İlan Ekle",
            style: TextStyle(
                color: second, fontSize: 20, fontWeight: FontWeight.w500),
          ),
        ),
        backgroundColor: Colors.grey[300],
        body: Stack(
          children: [
            Positioned(
              top: 0,
              left: 25,
              child: Container(
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width * 0.8,
                child: Column(
                  children: [
                    TextField(
                      maxLines: 1,
                      cursorColor: fourth,
                      cursorHeight: 20,
                      enableSuggestions: true,
                      maxLength: 25,
                      controller: _ilanBaslikController,
                      decoration: InputDecoration(
                          contentPadding: EdgeInsets.symmetric(
                              horizontal: 10, vertical: 10),
                          filled: true,
                          fillColor: Colors.white,
                          hintText: "İlan Başlığı",
                          enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20),
                              borderSide: BorderSide(
                                  color: second,
                                  width: 2,
                                  style: BorderStyle.solid)),
                          focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(30),
                              borderSide: const BorderSide(
                                  color: Colors.greenAccent,
                                  width: 2,
                                  style: BorderStyle.solid))),
                    ),
                    TextField(
                      maxLines: 3,
                      cursorColor: fourth,
                      cursorHeight: 20,
                      enableSuggestions: true,
                      maxLength: 45,
                      controller: _ilanAciklamaController,
                      decoration: InputDecoration(
                          contentPadding: EdgeInsets.symmetric(
                              horizontal: 10, vertical: 10),
                          filled: true,
                          fillColor: Colors.white,
                          hintText: "İlan Açıklaması",
                          enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20),
                              borderSide: BorderSide(
                                  color: second,
                                  width: 2,
                                  style: BorderStyle.solid)),
                          focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(30),
                              borderSide: const BorderSide(
                                  color: Colors.greenAccent,
                                  width: 2,
                                  style: BorderStyle.solid))),
                    ),
                    TextField(
                      maxLines: 1,
                      maxLength: 10,
                      cursorColor: fourth,
                      cursorHeight: 20,
                      controller: _ilanFiyatController,
                      decoration: InputDecoration(
                          contentPadding: EdgeInsets.symmetric(
                              horizontal: 10, vertical: 10),
                          filled: true,
                          fillColor: Colors.white,
                          hintText: "Fiyat",
                          enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20),
                              borderSide: BorderSide(
                                  color: second,
                                  width: 2,
                                  style: BorderStyle.solid)),
                          focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(30),
                              borderSide: BorderSide(
                                  color: Colors.greenAccent,
                                  width: 2,
                                  style: BorderStyle.solid))),
                    ),

                    SizedBox(
                      height: 15,
                    ),
                    //imagePlace(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Container(
                          height: 120,
                          width: MediaQuery.of(context).size.width * 0.66,
                          padding: const EdgeInsets.symmetric(
                              horizontal: 12, vertical: 8),
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(8),
                              border: Border.all(
                                  color: second,
                                  width: 2,
                                  style: BorderStyle.solid)),
                          //DROPDOWN
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  Container(
                                    child: DropdownButton(
                                      alignment: Alignment.center,
                                      hint: Text("            Şehirler"),
                                      value: secilenSehir,
                                      items: sehirler.map((String value) {
                                        return DropdownMenuItem(
                                          value: value,
                                          child: Text(value),
                                        );
                                      }).toList(),
                                      onChanged: (sehirler) {
                                        if (sehirler == 'ANTALYA') {
                                          ilceler = antalyaIlceler;
                                        } else if (sehirler == 'MERSİN') {
                                          ilceler = mersinIlceler;
                                        } else {
                                          mahalle = [];
                                        }
                                        setState(() {
                                          secilenIlce = null;
                                          secilenSehir = sehirler as String;
                                        });
                                      },
                                    ),
                                  ),
                                  Container(
                                    child: DropdownButton(
                                      alignment: Alignment.center,
                                      hint: Text(
                                        "İlçeler",
                                        textAlign: TextAlign.left,
                                      ),
                                      value: secilenIlce,
                                      items: ilceler.map((String value) {
                                        return DropdownMenuItem(
                                          value: value,
                                          child: Text(value),
                                        );
                                      }).toList(),
                                      onChanged: (ilceler) {
                                        if (ilceler == 'KEPEZ') {
                                          mahalle = kepezMahalle;
                                        } else if (ilceler == 'MURATPAŞA') {
                                          mahalle = muratpasaMahalle;
                                        } else {
                                          mahalle = [];
                                        }
                                        setState(() {
                                          secilenMahalle = null;
                                          secilenIlce = ilceler as String;
                                        });
                                      },
                                    ),
                                  ),
                                ],
                              ),

                              // Province Dropdown
                              Container(
                                width: 300,
                                child: DropdownButton<String>(
                                  hint: Text('       mahalle'),
                                  value: secilenMahalle,
                                  isExpanded: true,
                                  items: mahalle.map((String value) {
                                    return DropdownMenuItem<String>(
                                      value: value,
                                      child: Text(
                                        value,
                                      ),
                                    );
                                  }).toList(),
                                  onChanged: (mahalle) {
                                    setState(() {
                                      secilenMahalle = mahalle;
                                    });
                                  },
                                ),
                              ),
                            ],
                          ),
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            InkWell(
                                onTap: () {},
                                /*onTap: () => _onImageButtonPressed(
                                    ImageSource.camera,
                                    context: context),*/
                                child: Container(
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      color: fourth),
                                  child: Padding(
                                    padding: const EdgeInsets.all(3.0),
                                    child: Icon(
                                      Icons.camera_alt,
                                      size: 30,
                                      color: Colors.white,
                                    ),
                                  ),
                                )),
                            SizedBox(
                              height: 5,
                            ),
                            InkWell(
                                onTap: openImages,

                                /*onTap: () => _onImageButtonPressed(
                                ImageSource.gallery,
                                context: context),*/
                                child: Container(
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      color: fourth),
                                  child: Padding(
                                    padding: const EdgeInsets.all(3.0),
                                    child: Icon(
                                      Icons.image,
                                      size: 30,
                                      color: Colors.white,
                                    ),
                                  ),
                                ))
                          ],
                        ),
                      ],
                    ),
                    //open button ----------------

                    Divider(),
                    Text(
                      "Seçilen Fotoğraflar:(Üç Adet Fotoğraf Seçiniz)",
                      style: TextStyle(
                          color: second, fontFamily: "roboto", fontSize: 14),
                    ),
                    Divider(
                      color: primary,
                    ),

                    imagefiles != null
                        ? Wrap(
                            children: imagefiles!.map((imageone) {
                              return Container(
                                  child: Card(
                                child: Container(
                                  height: 90,
                                  width: 90,
                                  child: FittedBox(
                                      fit: BoxFit.cover,
                                      child: Image.file(File(imageone.path))),
                                ),
                              ));
                            }).toList(),
                          )
                        : Container(),
                    SizedBox(
                      height: 15,
                    ),
                    ElevatedButton(
                      onPressed: () {
                        StatusService().addStatus(
                            _ilanBaslikController.text,
                            _ilanAciklamaController.text,
                            _ilanFiyatController.text,
                            secilenMahalle!,
                            imagefiles![0],
                            imagefiles![1],
                            imagefiles![2],
                            name,
                            phone,
                            email!);

                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) => Home()));
                      },
                      child: Text("Paylaş"),
                      style: ElevatedButton.styleFrom(
                          fixedSize: Size(150, 40), primary: fourth),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void openImages() async {
    try {
      var pickedfiles = await _pickerImage.pickMultiImage();
      //you can use ImageCourse.camera for Camera captur

      name = _firebaseAuth.currentUser!.displayName.toString();
      phone = _firebaseAuth.currentUser!.phoneNumber.toString();

      if (pickedfiles?.length == 3) {
        imagefiles = pickedfiles;
        setState(() {});
      } else {
        print("No image is selected.");
      }
    } catch (e) {
      print("error while picking file.");
    }
  }

  /*void _onImageButtonPressed(ImageSource source,
      {required BuildContext context}) async {
    try {
      final pickedFile = await _pickerImage.pickImage(source: source);
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
  }*/
}
/*import 'package:flutter/material.dart';
import 'dart:async';

import 'package:multi_image_picker2/multi_image_picker2.dart';

class AddIlan extends StatefulWidget {
  @override
  _AddIlanState createState() => _AddIlanState();
}

class _AddIlanState extends State<AddIlan> {
  List<Asset> images = <Asset>[];
  String _error = 'No Error Dectected';

  @override
  void initState() {
    super.initState();
  }

  Widget buildGridView() {
    return GridView.count(
      crossAxisCount: 3,
      children: List.generate(images.length, (index) {
        Asset asset = images[index];
        return AssetThumb(
          asset: asset,
          width: 300,
          height: 300,
        );
      }),
    );
  }

  Future<void> loadAssets() async {
    List<Asset> resultList = <Asset>[];
    String error = 'No Error Detected';

    try {
      resultList = await MultiImagePicker.pickImages(
        maxImages: 300,
        enableCamera: true,
        selectedAssets: images,
        cupertinoOptions: CupertinoOptions(
          takePhotoIcon: "chat",
          doneButtonTitle: "Fatto",
        ),
        materialOptions: MaterialOptions(
          actionBarColor: "#abcdef",
          actionBarTitle: "Example App",
          allViewTitle: "All Photos",
          useDetailsView: false,
          selectCircleStrokeColor: "#000000",
        ),
      );
    } on Exception catch (e) {
      error = e.toString();
    }

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) return;

    setState(() {
      images = resultList;
      _error = error;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Plugin example app'),
        ),
        body: Column(
          children: <Widget>[
            Center(child: Text('Error: $_error')),
            ElevatedButton(
              child: Text("Pick images"),
              onPressed: loadAssets,
            ),
            Expanded(
              child: buildGridView(),
            )
          ],
        ),
      ),
    );
  }
}*/
