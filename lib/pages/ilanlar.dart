import 'dart:ui';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:evdeneve/addilan.dart';
import 'package:evdeneve/constants.dart';

import 'package:evdeneve/pages/benimtalep.dart';
import 'package:evdeneve/pages/profil.dart';
import 'package:evdeneve/search_widget.dart';
import 'package:evdeneve/services/authServices.dart';
import 'package:evdeneve/services/status_service.dart';
import 'package:evdeneve/services/talep_services.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';

class Ilanlar extends StatefulWidget {
  const Ilanlar({Key? key}) : super(key: key);

  @override
  _IlanlarState createState() => _IlanlarState();
}

FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

class _IlanlarState extends State<Ilanlar> with TickerProviderStateMixin {
  late TabController tabController;
  List? documents = [];
  List _foundUsers = [];
  String? arama;
  List<String> kategori = ["baslık", "konum", "açıklama"];
  @override
  void initState() {
    super.initState();
    _foundUsers = documents!;
    tabController = TabController(
      initialIndex: 0,
      length: 2,
      vsync: this,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      floatingActionButton: FloatingActionButton(
        backgroundColor: second,
        child: Icon(Icons.add),
        onPressed: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => AddIlan()));
        },
      ),
      body: SingleChildScrollView(
        child: Container(
          color: Colors.grey[300],
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              mainAxisSize: MainAxisSize.max,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  //Filtre butonu
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      InkWell(
                          onTap: () {
                            setState(() {
                              dropdownvalue = "";
                              tumuColor = Colors.amberAccent;
                              ColorKonumdef = const Color(0xFF9DE79D);
                            });
                          },
                          child: Container(
                            height: 30,
                            width: 120,
                            padding: const EdgeInsets.symmetric(vertical: 1),
                            decoration: BoxDecoration(
                                border: Border.all(color: primary, width: 2),
                                color: tumuColor,
                                borderRadius: const BorderRadius.all(
                                    Radius.circular(30))),
                            child: Padding(
                              padding: const EdgeInsets.only(
                                  top: 3, bottom: 3, left: 5, right: 5),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Icon(
                                    Icons.list,
                                    size: 18,
                                    color: fourth,
                                  ),
                                  Center(
                                    child: Text(
                                      "Tüm İlanlar",
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          color: fourth,
                                          fontSize: 15,
                                          fontFamily: "roboto"),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          )),
                      SizedBox(
                        width: 20,
                      ),
                      InkWell(
                          onTap: () {
                            setState(() {
                              dropdownvalue = dropdownvaluef;
                              tumuColor = const Color(0xFFB4EEB4);
                              ColorKonumdef = Colors.amberAccent;
                            });
                          },
                          child: Container(
                            height: 30,
                            width: 200,
                            padding: const EdgeInsets.symmetric(vertical: 1),
                            decoration: BoxDecoration(
                                border: Border.all(color: primary, width: 2),
                                color: ColorKonumdef,
                                borderRadius: const BorderRadius.all(
                                    Radius.circular(30))),
                            child: Padding(
                              padding: const EdgeInsets.only(
                                  top: 3, bottom: 3, left: 5, right: 5),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Icon(
                                    Icons.navigation_outlined,
                                    size: 18,
                                    color: fourth,
                                  ),
                                  Center(
                                    child: Text(
                                      "Konumumdaki İlanlar",
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          color: fourth,
                                          fontSize: 15,
                                          fontFamily: "roboto"),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          )),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 18.0, left: 8, right: 8),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Container(
                        width: MediaQuery.of(context).size.width * 0.5,
                        alignment: Alignment.center,
                        height: 40,
                        child: TextField(
                          onChanged: (value) => _runFilter(value),
                          cursorColor: Colors.black,
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.black,
                          ),
                          autofocus: true,
                          decoration: InputDecoration(
                            contentPadding: EdgeInsets.symmetric(
                                horizontal: 10, vertical: 10),
                            labelStyle: TextStyle(
                                color: Colors.green,
                                fontSize: 20,
                                fontWeight: FontWeight.bold),
                            labelText: "Filtrele",
                            focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20.0),
                                borderSide:
                                    BorderSide(color: Colors.green, width: 2)),
                            enabledBorder: OutlineInputBorder(
                                borderSide:
                                    BorderSide(color: Colors.black, width: 2),
                                borderRadius: BorderRadius.circular(10.0)),
                            suffixIcon: const Icon(
                              Icons.search,
                              color: Colors.green,
                            ),
                          ),
                        ),
                      ),
                      DropdownButton(
                        disabledHint: Text("kategori"),
                        alignment: Alignment.center,
                        hint: Text("Kategori"),
                        value: arama,
                        items: kategori.map((String value) {
                          return DropdownMenuItem(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                        onChanged: (katego) {
                          setState(() {
                            arama = katego as String;
                          });
                        },
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.grey[300],
                      ),
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.height * 0.7,
                      child: _foundUsers.isNotEmpty
                          ? ListView.builder(
                              itemCount: _foundUsers.length,
                              itemBuilder: (context, index) => Card(
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10)),
                                elevation: 10,
                                shadowColor: fourth,
                                borderOnForeground: true,
                                color: primary,
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Container(
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(10)),
                                      height:
                                          MediaQuery.of(context).size.height *
                                              0.2,
                                      width: MediaQuery.of(context).size.width,
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.circular(10),
                                        child: Container(
                                          child: CarouselSlider(
                                              items: [
                                                "${documents![index]['image']}",
                                                "${documents![index]['image1']}",
                                                "${documents![index]['image2']}"
                                              ].map((i) {
                                                return Builder(
                                                  builder:
                                                      (BuildContext context) {
                                                    return Container(
                                                        width: MediaQuery.of(
                                                                context)
                                                            .size
                                                            .width,
                                                        margin: const EdgeInsets
                                                                .symmetric(
                                                            horizontal: 5.0),
                                                        decoration:
                                                            BoxDecoration(
                                                          image: DecorationImage(
                                                              fit: BoxFit.cover,
                                                              image:
                                                                  NetworkImage(
                                                                      i)),
                                                        ));
                                                  },
                                                );
                                              }).toList(),
                                              options: CarouselOptions()),
                                          decoration: BoxDecoration(),
                                        ),
                                      ),
                                    ),
                                    ExpansionTile(
                                      trailing: Icon(
                                        Icons.arrow_drop_down,
                                        size: 40,
                                        color: Colors.orangeAccent,
                                      ),
                                      children: [
                                        Text(_foundUsers[index]['aciklama'],
                                            style: TextStyle(
                                                overflow: TextOverflow.ellipsis,
                                                fontSize: 15,
                                                color: subtitle)),
                                      ],
                                      initiallyExpanded: false,
                                      title: Text(_foundUsers[index]['baslik'],
                                          style: TextStyle(
                                              fontSize: 17, color: subtitle)),
                                      subtitle: Text(
                                        _foundUsers[index]["konum"],
                                        style: TextStyle(
                                            fontSize: 11, color: subtext),
                                        maxLines: 1,
                                      ),
                                    ),
                                    Divider(
                                      color: Colors.black26,
                                      indent: 10,
                                      endIndent: 10,
                                      thickness: 0.7,
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: .0),
                                      child: Container(
                                        height:
                                            MediaQuery.of(context).size.height *
                                                0.06,
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceEvenly,
                                          children: [
                                            Text(
                                              "${_foundUsers[index]['fiyat']} TL",
                                              style: TextStyle(
                                                  background: Paint()
                                                    ..color = fourth
                                                    ..strokeWidth = 17
                                                    ..style =
                                                        PaintingStyle.stroke,
                                                  color: primary,
                                                  fontSize: 14,
                                                  wordSpacing: 2,
                                                  overflow: TextOverflow.clip),
                                            ),
                                            StreamBuilder<QuerySnapshot>(
                                                stream:
                                                    AuthService().getStatus(),
                                                builder: (context, snapshot) {
                                                  QueryDocumentSnapshot<
                                                          Object?>? mypostauth =
                                                      snapshot
                                                          .data?.docs[index];
                                                  if (_firebaseAuth
                                                          .currentUser?.email ==
                                                      mypostauth
                                                          ?.get("email")) {
                                                    dropdownvaluef =
                                                        "${mypostauth?.get("sehir")}";
                                                  }
                                                  print(dropdownvaluef);
                                                  return !snapshot.hasData
                                                      ? Center(
                                                          child: Container(
                                                            height: 1,
                                                            width: 1,
                                                            child:
                                                                const CircularProgressIndicator(
                                                              strokeWidth: 1,
                                                            ),
                                                          ),
                                                        )
                                                      : Container(
                                                          height: MediaQuery.of(
                                                                      context)
                                                                  .size
                                                                  .height *
                                                              0.06,
                                                          child: Row(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .center,
                                                            mainAxisSize:
                                                                MainAxisSize
                                                                    .min,
                                                            children: [
                                                              InkWell(
                                                                onTap: () {
                                                                  showDialog(
                                                                      context:
                                                                          context,
                                                                      builder:
                                                                          (BuildContext
                                                                              context) {
                                                                        return AlertDialog(
                                                                          backgroundColor:
                                                                              fifth,
                                                                          shape:
                                                                              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                                                                          scrollable:
                                                                              true,
                                                                          content:
                                                                              Container(
                                                                            width:
                                                                                MediaQuery.of(context).size.width * 0.9,
                                                                            height:
                                                                                MediaQuery.of(context).size.height * 0.7,
                                                                            child:
                                                                                Column(
                                                                              children: [
                                                                                Expanded(
                                                                                  flex: 1,
                                                                                  child: Container(
                                                                                    alignment: Alignment.center,
                                                                                    decoration: BoxDecoration(
                                                                                      borderRadius: BorderRadius.circular(10),
                                                                                      color: primary,
                                                                                    ),
                                                                                    width: MediaQuery.of(context).size.width,
                                                                                    child: Center(
                                                                                      child: Column(
                                                                                        mainAxisAlignment: MainAxisAlignment.center,
                                                                                        children: [
                                                                                          CircleAvatar(
                                                                                            backgroundImage: AssetImage("assets/images/logo.png"),
                                                                                            radius: 30,
                                                                                          ),
                                                                                          Padding(
                                                                                            padding: const EdgeInsets.only(left: 49.0),
                                                                                            child: Row(
                                                                                              mainAxisAlignment: MainAxisAlignment.start,
                                                                                              children: [
                                                                                                Icon(
                                                                                                  Icons.person,
                                                                                                  color: Colors.amber,
                                                                                                ),
                                                                                                Text(
                                                                                                  mypostauth?.get("name"),
                                                                                                  style: TextStyle(
                                                                                                    color: Colors.black,
                                                                                                    fontSize: 22,
                                                                                                    fontWeight: FontWeight.w500,
                                                                                                  ),
                                                                                                ),
                                                                                              ],
                                                                                            ),
                                                                                          ),
                                                                                          Divider(
                                                                                            color: Colors.grey,
                                                                                            thickness: 1,
                                                                                            indent: 70,
                                                                                            endIndent: 70,
                                                                                            height: 1,
                                                                                          ),
                                                                                          SizedBox(height: 10),
                                                                                          Padding(
                                                                                            padding: const EdgeInsets.only(left: 49.0),
                                                                                            child: Row(
                                                                                              mainAxisAlignment: MainAxisAlignment.start,
                                                                                              children: [
                                                                                                Icon(
                                                                                                  Icons.phone_android,
                                                                                                  color: Colors.amber,
                                                                                                ),
                                                                                                Text(
                                                                                                  mypostauth?.get("telefon"),
                                                                                                  style: TextStyle(
                                                                                                    color: Colors.black,
                                                                                                    fontSize: 18,
                                                                                                    fontWeight: FontWeight.w500,
                                                                                                  ),
                                                                                                ),
                                                                                              ],
                                                                                            ),
                                                                                          ),
                                                                                          Divider(
                                                                                            color: Colors.grey,
                                                                                            thickness: 1,
                                                                                            indent: 70,
                                                                                            endIndent: 70,
                                                                                            height: 1,
                                                                                          ),
                                                                                        ],
                                                                                      ),
                                                                                    ),
                                                                                  ),
                                                                                ),
                                                                                Divider(color: fifth),
                                                                                Expanded(
                                                                                  flex: 2,
                                                                                  child: Scaffold(
                                                                                    appBar: TabBar(
                                                                                      indicatorColor: Colors.amber,
                                                                                      controller: tabController,
                                                                                      tabs: [
                                                                                        Padding(
                                                                                          padding: const EdgeInsets.all(8.0),
                                                                                          child: Container(
                                                                                            height: 20,
                                                                                            child: Text(
                                                                                              "İlanlar",
                                                                                              style: TextStyle(color: Colors.black, fontSize: 16),
                                                                                            ),
                                                                                          ),
                                                                                        ),
                                                                                        Text(
                                                                                          "Talepler",
                                                                                          style: TextStyle(color: Colors.black, fontSize: 16),
                                                                                        )
                                                                                      ],
                                                                                    ),
                                                                                    body: Container(
                                                                                      child: TabBarView(
                                                                                        controller: tabController,
                                                                                        children: [
                                                                                          Container(
                                                                                            child: Padding(
                                                                                              padding: const EdgeInsets.symmetric(horizontal: 0.0),
                                                                                              child: myListdView(context),
                                                                                            ),
                                                                                            decoration: BoxDecoration(
                                                                                              borderRadius: BorderRadius.circular(10),
                                                                                              color: primary,
                                                                                            ),
                                                                                          ),
                                                                                          Container(
                                                                                            child: _talepList(context),
                                                                                            decoration: BoxDecoration(
                                                                                              borderRadius: BorderRadius.circular(10),
                                                                                              color: primary,
                                                                                            ),
                                                                                          )
                                                                                        ],
                                                                                      ),
                                                                                    ),
                                                                                  ),
                                                                                ),
                                                                              ],
                                                                            ),
                                                                          ),
                                                                        );
                                                                      });
                                                                },
                                                                child:
                                                                    Container(
                                                                  alignment:
                                                                      Alignment
                                                                          .centerLeft,
                                                                  decoration: BoxDecoration(
                                                                      borderRadius:
                                                                          BorderRadius.circular(
                                                                              10),
                                                                      color:
                                                                          fifth),
                                                                  height: MediaQuery.of(
                                                                              context)
                                                                          .size
                                                                          .height *
                                                                      0.05,
                                                                  child:
                                                                      Padding(
                                                                    padding: const EdgeInsets
                                                                            .symmetric(
                                                                        horizontal:
                                                                            8.0),
                                                                    child: Text(
                                                                      "${mypostauth?.get("name")}"
                                                                          .toString(),
                                                                      overflow:
                                                                          TextOverflow
                                                                              .clip,
                                                                      style: TextStyle(
                                                                          fontSize:
                                                                              13,
                                                                          color:
                                                                              primary,
                                                                          fontWeight:
                                                                              FontWeight.w400),
                                                                    ),
                                                                  ),
                                                                ),
                                                              ),
                                                              IconButton(
                                                                  onPressed:
                                                                      () async {
                                                                    await FlutterPhoneDirectCaller
                                                                        .callNumber(
                                                                            "${mypostauth?.get("telefon")}");
                                                                  }, //Telefon aramasına gidecek
                                                                  icon:
                                                                      const Icon(
                                                                    Icons.phone,
                                                                    size: 25,
                                                                    color: Color(
                                                                        0xFF007700),
                                                                  )),
                                                            ],
                                                          ),
                                                        );
                                                }),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            )
                          : _myListView(context)),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _runFilter(String enteredKeyword) {
    List results = [];
    if (enteredKeyword.isEmpty) {
      // if the search field is empty or only contains white-space, we'll display all users
      results = documents!;
    } else if (enteredKeyword.isNotEmpty && arama == "baslik") {
      results = documents!
          .where((user) => user["baslik"]
              .toLowerCase()
              .contains(enteredKeyword.toLowerCase()))
          .toList();
    } else if (enteredKeyword.isNotEmpty && arama == "konum") {
      results = documents!
          .where((user) => user["konum"]
              .toLowerCase()
              .contains(enteredKeyword.toLowerCase()))
          .toList();
    } else if (enteredKeyword.isNotEmpty && arama == "aciklama") {
      results = documents!
          .where((user) => user["aciklama"]
              .toLowerCase()
              .contains(enteredKeyword.toLowerCase()))
          .toList();
    } else {
      results = documents!
          .where((user) => user["fiyat"]
              .toLowerCase()
              .contains(enteredKeyword.toLowerCase()))
          .toList();

      // we use the toLowerCase() method to make it case-insensitive
    }

    // Refresh the UI
    setState(() {
      _foundUsers = results;
    });
  }

  String dropdownvaluef = "";
  String dropdownvalue = "";

  Widget _myListView(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
        stream: StatusService().getStatus(),
        builder: (context, snapshot) {
          documents = snapshot.data?.docs;

          //dropdownvalue = documents![0].toString();

          if (dropdownvalue.length > 0) {
            documents = documents?.where((index) {
              documents!.length <= 4;

              return index
                  .get('konum')
                  .toString()
                  .toLowerCase()
                  .contains(dropdownvalue.toLowerCase());
            }).toList();
          }

          return !snapshot.hasData
              ? Center(
                  child: Container(
                    height: 50,
                    width: 50,
                    child: const CircularProgressIndicator(
                      strokeWidth: 1,
                    ),
                  ),
                )
              : ListView.builder(
                  itemCount: documents!.length,
                  padding: const EdgeInsets.only(top: 20.0),
                  //snapshot.data!.docs.length,
                  itemBuilder: (context, index) {
                    DocumentSnapshot mypost = snapshot.data!.docs[index];

                    return Center(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20.0, vertical: 10),
                        child: Container(
                          width: MediaQuery.of(context).size.width * 0.8,
                          //height: MediaQuery.of(context).size.height * 0.41,
                          child: Card(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10)),
                            elevation: 10,
                            shadowColor: fourth,
                            borderOnForeground: true,
                            color: primary,
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Container(
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10)),
                                  height:
                                      MediaQuery.of(context).size.height * 0.2,
                                  width: MediaQuery.of(context).size.width,
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(10),
                                    child: Container(
                                      child: CarouselSlider(
                                          items: [
                                            "${documents![index]['image']}",
                                            "${documents![index]['image1']}",
                                            "${documents![index]['image2']}"
                                          ].map((i) {
                                            return Builder(
                                              builder: (BuildContext context) {
                                                return Container(
                                                    width:
                                                        MediaQuery.of(context)
                                                            .size
                                                            .width,
                                                    margin: const EdgeInsets
                                                            .symmetric(
                                                        horizontal: 5.0),
                                                    decoration: BoxDecoration(
                                                      image: DecorationImage(
                                                          fit: BoxFit.cover,
                                                          image:
                                                              NetworkImage(i)),
                                                    ));
                                              },
                                            );
                                          }).toList(),
                                          options: CarouselOptions()),
                                      decoration: BoxDecoration(),
                                    ),
                                  ),
                                ),
                                ExpansionTile(
                                  trailing: Icon(
                                    Icons.arrow_drop_down,
                                    size: 40,
                                    color: Colors.orangeAccent,
                                  ),
                                  children: [
                                    Text("${documents![index]['aciklama']}",
                                        style: TextStyle(
                                            overflow: TextOverflow.ellipsis,
                                            fontSize: 15,
                                            color: subtitle)),
                                  ],
                                  initiallyExpanded: false,
                                  title: Text("${documents![index]['baslik']}",
                                      style: TextStyle(
                                          fontSize: 17, color: subtitle)),
                                  subtitle: Text(
                                    "${documents![index]['konum']}",
                                    style:
                                        TextStyle(fontSize: 11, color: subtext),
                                    maxLines: 1,
                                  ),
                                ),
                                Divider(
                                  color: Colors.black26,
                                  indent: 10,
                                  endIndent: 10,
                                  thickness: 0.7,
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: .0),
                                  child: Container(
                                    height: MediaQuery.of(context).size.height *
                                        0.06,
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: [
                                        Text(
                                          "${documents![index]['fiyat']} TL",
                                          style: TextStyle(
                                              background: Paint()
                                                ..color = fourth
                                                ..strokeWidth = 17
                                                ..style = PaintingStyle.stroke,
                                              color: primary,
                                              fontSize: 14,
                                              wordSpacing: 2,
                                              overflow: TextOverflow.clip),
                                        ),
                                        StreamBuilder<QuerySnapshot>(
                                            stream: AuthService().getStatus(),
                                            builder: (context, snapshot) {
                                              QueryDocumentSnapshot<Object?>?
                                                  mypostauth =
                                                  snapshot.data?.docs[index];
                                              if (_firebaseAuth
                                                      .currentUser?.email ==
                                                  mypostauth?.get("email")) {
                                                dropdownvaluef =
                                                    "${mypostauth?.get("sehir")}";
                                              }
                                              print(dropdownvaluef);
                                              return !snapshot.hasData
                                                  ? Center(
                                                      child: Container(
                                                        height: 1,
                                                        width: 1,
                                                        child:
                                                            const CircularProgressIndicator(
                                                          strokeWidth: 1,
                                                        ),
                                                      ),
                                                    )
                                                  : Container(
                                                      height:
                                                          MediaQuery.of(context)
                                                                  .size
                                                                  .height *
                                                              0.06,
                                                      child: Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .center,
                                                        mainAxisSize:
                                                            MainAxisSize.min,
                                                        children: [
                                                          InkWell(
                                                            onTap: () {
                                                              showDialog(
                                                                  context:
                                                                      context,
                                                                  builder:
                                                                      (BuildContext
                                                                          context) {
                                                                    return AlertDialog(
                                                                      backgroundColor:
                                                                          fifth,
                                                                      shape: RoundedRectangleBorder(
                                                                          borderRadius:
                                                                              BorderRadius.circular(10)),
                                                                      scrollable:
                                                                          true,
                                                                      content:
                                                                          Container(
                                                                        width: MediaQuery.of(context).size.width *
                                                                            0.9,
                                                                        height: MediaQuery.of(context).size.height *
                                                                            0.7,
                                                                        child:
                                                                            Column(
                                                                          children: [
                                                                            Expanded(
                                                                              flex: 1,
                                                                              child: Container(
                                                                                alignment: Alignment.center,
                                                                                decoration: BoxDecoration(
                                                                                  borderRadius: BorderRadius.circular(10),
                                                                                  color: primary,
                                                                                ),
                                                                                width: MediaQuery.of(context).size.width,
                                                                                child: Center(
                                                                                  child: Column(
                                                                                    mainAxisAlignment: MainAxisAlignment.center,
                                                                                    children: [
                                                                                      CircleAvatar(
                                                                                        backgroundImage: AssetImage("assets/images/logo.png"),
                                                                                        radius: 30,
                                                                                      ),
                                                                                      Padding(
                                                                                        padding: const EdgeInsets.only(left: 49.0),
                                                                                        child: Row(
                                                                                          mainAxisAlignment: MainAxisAlignment.start,
                                                                                          children: [
                                                                                            Icon(
                                                                                              Icons.person,
                                                                                              color: Colors.amber,
                                                                                            ),
                                                                                            Text(
                                                                                              mypostauth?.get("name"),
                                                                                              style: TextStyle(
                                                                                                color: Colors.black,
                                                                                                fontSize: 22,
                                                                                                fontWeight: FontWeight.w500,
                                                                                              ),
                                                                                            ),
                                                                                          ],
                                                                                        ),
                                                                                      ),
                                                                                      Divider(
                                                                                        color: Colors.grey,
                                                                                        thickness: 1,
                                                                                        indent: 70,
                                                                                        endIndent: 70,
                                                                                        height: 1,
                                                                                      ),
                                                                                      SizedBox(height: 10),
                                                                                      Padding(
                                                                                        padding: const EdgeInsets.only(left: 49.0),
                                                                                        child: Row(
                                                                                          mainAxisAlignment: MainAxisAlignment.start,
                                                                                          children: [
                                                                                            Icon(
                                                                                              Icons.phone_android,
                                                                                              color: Colors.amber,
                                                                                            ),
                                                                                            Text(
                                                                                              mypostauth?.get("telefon"),
                                                                                              style: TextStyle(
                                                                                                color: Colors.black,
                                                                                                fontSize: 18,
                                                                                                fontWeight: FontWeight.w500,
                                                                                              ),
                                                                                            ),
                                                                                          ],
                                                                                        ),
                                                                                      ),
                                                                                      Divider(
                                                                                        color: Colors.grey,
                                                                                        thickness: 1,
                                                                                        indent: 70,
                                                                                        endIndent: 70,
                                                                                        height: 1,
                                                                                      ),
                                                                                    ],
                                                                                  ),
                                                                                ),
                                                                              ),
                                                                            ),
                                                                            Divider(color: fifth),
                                                                            Expanded(
                                                                              flex: 2,
                                                                              child: Scaffold(
                                                                                appBar: TabBar(
                                                                                  indicatorColor: Colors.amber,
                                                                                  controller: tabController,
                                                                                  tabs: [
                                                                                    Padding(
                                                                                      padding: const EdgeInsets.all(8.0),
                                                                                      child: Container(
                                                                                        height: 20,
                                                                                        child: Text(
                                                                                          "İlanlar",
                                                                                          style: TextStyle(color: Colors.black, fontSize: 16),
                                                                                        ),
                                                                                      ),
                                                                                    ),
                                                                                    Text(
                                                                                      "Talepler",
                                                                                      style: TextStyle(color: Colors.black, fontSize: 16),
                                                                                    )
                                                                                  ],
                                                                                ),
                                                                                body: Container(
                                                                                  child: TabBarView(
                                                                                    controller: tabController,
                                                                                    children: [
                                                                                      Container(
                                                                                        child: Padding(
                                                                                          padding: const EdgeInsets.symmetric(horizontal: 0.0),
                                                                                          child: myListdView(context),
                                                                                        ),
                                                                                        decoration: BoxDecoration(
                                                                                          borderRadius: BorderRadius.circular(10),
                                                                                          color: primary,
                                                                                        ),
                                                                                      ),
                                                                                      Container(
                                                                                        child: _talepList(context),
                                                                                        decoration: BoxDecoration(
                                                                                          borderRadius: BorderRadius.circular(10),
                                                                                          color: primary,
                                                                                        ),
                                                                                      )
                                                                                    ],
                                                                                  ),
                                                                                ),
                                                                              ),
                                                                            ),
                                                                          ],
                                                                        ),
                                                                      ),
                                                                    );
                                                                  });
                                                            },
                                                            child: Container(
                                                              alignment: Alignment
                                                                  .centerLeft,
                                                              decoration: BoxDecoration(
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              10),
                                                                  color: fifth),
                                                              height: MediaQuery.of(
                                                                          context)
                                                                      .size
                                                                      .height *
                                                                  0.05,
                                                              child: Padding(
                                                                padding: const EdgeInsets
                                                                        .symmetric(
                                                                    horizontal:
                                                                        8.0),
                                                                child: Text(
                                                                  "${mypostauth?.get("name")}"
                                                                      .toString(),
                                                                  overflow:
                                                                      TextOverflow
                                                                          .clip,
                                                                  style: TextStyle(
                                                                      fontSize:
                                                                          13,
                                                                      color:
                                                                          primary,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w400),
                                                                ),
                                                              ),
                                                            ),
                                                          ),
                                                          IconButton(
                                                              onPressed:
                                                                  () async {
                                                                await FlutterPhoneDirectCaller
                                                                    .callNumber(
                                                                        "${mypostauth?.get("telefon")}");
                                                              }, //Telefon aramasına gidecek
                                                              icon: const Icon(
                                                                Icons.phone,
                                                                size: 25,
                                                                color: Color(
                                                                    0xFF007700),
                                                              )),
                                                        ],
                                                      ),
                                                    );
                                            }),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    );
                  });
        });
  }

  Widget myListdView(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
        stream: StatusService().getStatus(),
        builder: (context, snapshot) {
          List? documents = snapshot.data?.docs;

          //dropdownvalue = documents![0].toString();
          DocumentSnapshot? mypost = snapshot.data?.docs[index];
          emailValue = mypost?.get("email");
          documents = documents?.where((index) {
            return index
                .get('email')
                .toString()
                .toLowerCase()
                .contains(emailValue!);
          }).toList();

          return !snapshot.hasData
              ? Center(
                  child: Container(
                    height: 51,
                    width: 50,
                    child: const CircularProgressIndicator(
                      strokeWidth: 1,
                    ),
                  ),
                )
              : ListView.builder(
                  itemCount: documents!.length,
                  padding: const EdgeInsets.only(top: 20.0),
                  //snapshot.data!.docs.length,
                  itemBuilder: (context, index) {
                    DocumentSnapshot mypost = snapshot.data!.docs[index];

                    return Center(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20.0, vertical: 10),
                        child: Container(
                          width: MediaQuery.of(context).size.width * 0.8,
                          //height: MediaQuery.of(context).size.height * 0.41,
                          child: Card(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10)),
                            elevation: 10,
                            shadowColor: fourth,
                            borderOnForeground: true,
                            color: primary,
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Container(
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10)),
                                  height:
                                      MediaQuery.of(context).size.height * 0.2,
                                  width: MediaQuery.of(context).size.width,
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(10),
                                    child: Container(
                                      child: CarouselSlider(
                                          items: [
                                            "${mypost.get('image')}",
                                            "${mypost.get('image1')}",
                                            "${mypost.get('image2')}",
                                          ].map((i) {
                                            return Builder(
                                              builder: (BuildContext context) {
                                                return Container(
                                                    width:
                                                        MediaQuery.of(context)
                                                            .size
                                                            .width,
                                                    margin:
                                                        EdgeInsets.symmetric(
                                                            horizontal: 5.0),
                                                    decoration: BoxDecoration(
                                                      image: DecorationImage(
                                                          fit: BoxFit.cover,
                                                          image:
                                                              NetworkImage(i)),
                                                    ));
                                              },
                                            );
                                          }).toList(),
                                          options: CarouselOptions()),
                                      decoration: BoxDecoration(),
                                    ),
                                  ),
                                ),
                                ExpansionTile(
                                  trailing: Icon(
                                    Icons.arrow_drop_down,
                                    size: 40,
                                    color: Colors.orangeAccent,
                                  ),
                                  children: [
                                    Text("${documents![index]['aciklama']}",
                                        style: TextStyle(
                                            overflow: TextOverflow.ellipsis,
                                            fontSize: 15,
                                            color: subtitle)),
                                  ],
                                  initiallyExpanded: false,
                                  title: Text("${documents[index]['baslik']}",
                                      style: TextStyle(
                                          fontSize: 17, color: subtitle)),
                                  subtitle: Text(
                                    "${documents[index]['konum']}",
                                    style:
                                        TextStyle(fontSize: 11, color: subtext),
                                    maxLines: 1,
                                  ),
                                ),
                                Divider(
                                  color: Colors.black26,
                                  indent: 10,
                                  endIndent: 10,
                                  thickness: 0.7,
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 2.0),
                                  child: Container(
                                    height: MediaQuery.of(context).size.height *
                                        0.06,
                                    width:
                                        MediaQuery.of(context).size.width * 0.8,
                                    child: Row(
                                      mainAxisSize: MainAxisSize.max,
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: [
                                        Text(
                                          "${documents[index]['fiyat']} TL",
                                          style: TextStyle(
                                              background: Paint()
                                                ..color = fourth
                                                ..strokeWidth = 17
                                                ..style = PaintingStyle.stroke,
                                              color: primary,
                                              fontSize: 14,
                                              wordSpacing: 2,
                                              overflow: TextOverflow.clip),
                                        ),
                                        StreamBuilder<QuerySnapshot>(
                                            stream: AuthService().getStatus(),
                                            builder: (context, snapshot) {
                                              QueryDocumentSnapshot<Object?>?
                                                  mypostauth =
                                                  snapshot.data?.docs[index];
                                              if (_firebaseAuth
                                                      .currentUser?.email ==
                                                  mypostauth?.get("email")) {
                                                dropdownvaluef =
                                                    "${documents![index]['konum']}";
                                              }
                                              print(dropdownvaluef);
                                              return !snapshot.hasData
                                                  ? Center(
                                                      child: Container(
                                                        height: 1,
                                                        width: 1,
                                                        child:
                                                            const CircularProgressIndicator(
                                                          strokeWidth: 1,
                                                        ),
                                                      ),
                                                    )
                                                  : Container(
                                                      height:
                                                          MediaQuery.of(context)
                                                                  .size
                                                                  .height *
                                                              0.06,
                                                      child: Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .center,
                                                        mainAxisSize:
                                                            MainAxisSize.min,
                                                        children: [
                                                          Container(
                                                            alignment: Alignment
                                                                .centerLeft,
                                                            decoration: BoxDecoration(
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            10),
                                                                color: second),
                                                            height: MediaQuery.of(
                                                                        context)
                                                                    .size
                                                                    .height *
                                                                0.05,
                                                            child: Padding(
                                                              padding: const EdgeInsets
                                                                      .symmetric(
                                                                  horizontal:
                                                                      8.0),
                                                              child: Text(
                                                                "${mypostauth?.get("name")}"
                                                                    .toString(),
                                                                overflow:
                                                                    TextOverflow
                                                                        .clip,
                                                                style: TextStyle(
                                                                    fontSize:
                                                                        13,
                                                                    color:
                                                                        primary,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w400),
                                                              ),
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    );
                                            }),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    );
                  });
        });
  }

  Widget _talepList(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
        stream: TalepService().getStatus(),
        builder: (context, snapshot) {
          List? documents = snapshot.data?.docs;
          //dropdownvalue = documents![0].toString();

          DocumentSnapshot? myposttalep = snapshot.data?.docs[index];
          emailValue = myposttalep?.get("email");
          documents = documents?.where((index) {
            return index
                .get('email')
                .toString()
                .toLowerCase()
                .contains(emailValue!);
          }).toList();

          return !snapshot.hasData
              ? Center(
                  child: Container(
                      height: 50,
                      width: 50,
                      child: const CircularProgressIndicator(
                        strokeWidth: 1,
                      )),
                )
              : ListView.builder(
                  itemCount: documents!.length,
                  itemBuilder: (context, index) {
                    DocumentSnapshot myposttalep = snapshot.data!.docs[index];
                    return Card(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)),
                      elevation: 10,
                      shadowColor: fourth,
                      borderOnForeground: true,
                      color: primary,
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(color: fourth, width: 2),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Card(
                              borderOnForeground: true,
                              child: ExpansionTile(
                                leading: Icon(
                                  Icons.campaign,
                                  color: Colors.redAccent,
                                ),
                                subtitle: Text(
                                  "${documents![index]["konum"]}",
                                  style:
                                      TextStyle(fontSize: 11, color: subtext),
                                ),
                                //childrenPadding: EdgeInsets.all(8),
                                textColor: Colors.black,
                                iconColor: fourth,
                                collapsedBackgroundColor: primary,
                                collapsedTextColor: Colors.black,
                                title: Text(
                                  "${documents![index]["baslik"]}",
                                  style: TextStyle(
                                      fontSize: 17,
                                      color: subtitle,
                                      fontWeight: FontWeight.w500),
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 1,
                                ),
                                children: [
                                  Text(
                                    "${documents![index]["aciklama"]}",
                                    style: TextStyle(
                                        overflow: TextOverflow.ellipsis,
                                        fontSize: 15,
                                        color: subtitle),
                                    maxLines: 2,
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              width: MediaQuery.of(context).size.width * 0.9,
                              height: MediaQuery.of(context).size.height * 0.07,
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisSize: MainAxisSize.min,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  Icon(
                                    Icons.person,
                                    color: Colors.amber,
                                  ),
                                  StreamBuilder<QuerySnapshot>(
                                      stream: AuthService().getStatus(),
                                      builder: (context, snapshot) {
                                        QueryDocumentSnapshot<Object?>?
                                            mypostauth =
                                            snapshot.data?.docs[index];
                                        if (_firebaseAuth.currentUser?.email ==
                                            mypostauth?.get("email")) {
                                          dropdownvaluef =
                                              "${mypostauth?.get("sehir")}";
                                          print("f" + dropdownvaluef);
                                        }
                                        print(dropdownvaluef);
                                        return !snapshot.hasData
                                            ? const Center(
                                                child: SizedBox(
                                                  height: 1,
                                                  width: 1,
                                                  child:
                                                      CircularProgressIndicator(
                                                    strokeWidth: 1,
                                                  ),
                                                ),
                                              )
                                            : Row(
                                                children: [
                                                  Container(
                                                    alignment:
                                                        Alignment.centerLeft,
                                                    decoration: BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(10),
                                                        color: third),
                                                    height:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .height *
                                                            0.05,
                                                    child: Padding(
                                                      padding: const EdgeInsets
                                                              .symmetric(
                                                          horizontal: 8.0),
                                                      child: Text(
                                                          "${mypostauth!.get('name')}"
                                                              .toString(),
                                                          style: TextStyle(
                                                              fontSize: 14,
                                                              color: primary)),
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    width: 50,
                                                  ),
                                                  IconButton(
                                                      onPressed: () async {
                                                        await FlutterPhoneDirectCaller
                                                            .callNumber(
                                                                "${mypostauth.get('telefon')}");
                                                      }, //Telefon aramasına gidecek, //phone ekleme
                                                      icon: const Icon(
                                                        Icons.phone,
                                                        size: 25,
                                                        color:
                                                            Color(0xFF007700),
                                                      )),
                                                ],
                                              );
                                      }),
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    );
                  });
        });
  }
}
