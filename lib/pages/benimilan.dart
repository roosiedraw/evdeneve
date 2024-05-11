import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:evdeneve/addilan.dart';
import 'package:evdeneve/constants.dart';
import 'package:evdeneve/services/authServices.dart';
import 'package:evdeneve/services/status_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';

class benimIlan extends StatefulWidget {
  const benimIlan({Key? key}) : super(key: key);

  @override
  _benimIlanState createState() => _benimIlanState();
}

FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
bool _isvisible = false;

class _benimIlanState extends State<benimIlan> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _isvisible = true;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      appBar: AppBar(
        backgroundColor: Colors.grey[300],
        elevation: 1,
        backwardsCompatibility: true,
        centerTitle: true,
        title: Text(
          "İlanlarım",
          style: TextStyle(color: Colors.black),
        ),
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
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.grey[300],
                    ),
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height * 0.7,
                    child: _myListdView(context),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  int index = 0;
  String? emailValue = "";
  Widget _myListdView(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
        stream: StatusService().getStatus(),
        builder: (context, snapshot) {
          List? documents = snapshot.data?.docs;

          //dropdownvalue = documents![0].toString();
          DocumentSnapshot? mypost = snapshot.data?.docs[index];
          emailValue = _firebaseAuth.currentUser?.email.toString();
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
                                    Text("${mypost.get("aciklama")}",
                                        style: TextStyle(
                                            overflow: TextOverflow.ellipsis,
                                            fontSize: 15,
                                            color: subtitle)),
                                  ],
                                  initiallyExpanded: false,
                                  title: Text("${mypost.get('baslik')}",
                                      style: TextStyle(
                                          fontSize: 17, color: subtitle)),
                                  subtitle: Text(
                                    "${mypost.get('konum')}",
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
                                          MainAxisAlignment.start,
                                      children: [
                                        Text(
                                          "${mypost.get("fiyat")}",
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
                                        Text(
                                          "TL",
                                          style: TextStyle(
                                            background: Paint()
                                              ..color = fourth
                                              ..strokeWidth = 17
                                              ..style = PaintingStyle.stroke,
                                            color: primary,
                                            fontSize: 14,
                                            wordSpacing: 2,
                                          ),
                                        ),
                                        SizedBox(width: 10),
                                        StreamBuilder<QuerySnapshot>(
                                            stream: AuthService().getStatus(),
                                            builder: (context, snapshot) {
                                              QueryDocumentSnapshot<Object?>?
                                                  mypostauth =
                                                  snapshot.data?.docs[index];

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
                                                      width:
                                                          MediaQuery.of(context)
                                                                  .size
                                                                  .width *
                                                              0.55,
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
                                                            width: MediaQuery.of(
                                                                        context)
                                                                    .size
                                                                    .width *
                                                                0.4,
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
                                                          Visibility(
                                                            maintainSize: true,
                                                            maintainAnimation:
                                                                true,
                                                            maintainState: true,
                                                            visible: _isvisible,
                                                            child: IconButton(
                                                                onPressed:
                                                                    () async {
                                                                  var collection = FirebaseFirestore
                                                                      .instance
                                                                      .collection(
                                                                          'Sata');
                                                                  await collection
                                                                      .doc(mypost
                                                                          .id)
                                                                      .delete();
                                                                }, //Telefon aramasına gidecek
                                                                icon:
                                                                    const Icon(
                                                                  Icons.delete,
                                                                  size: 25,
                                                                  color: Color(
                                                                      0xFFD3041F),
                                                                )),
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
}
