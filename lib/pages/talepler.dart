import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:evdeneve/services/authServices.dart';
import 'package:evdeneve/services/status_service.dart';
import 'package:evdeneve/services/talep_services.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';

import '../addtalep.dart';
import '../constants.dart';
import 'benimtalep.dart';

class Talepler extends StatefulWidget {
  const Talepler({Key? key}) : super(key: key);

  @override
  _TaleplerState createState() => _TaleplerState();
}

FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

class _TaleplerState extends State<Talepler> with TickerProviderStateMixin {
  late TabController tabController;
  @override
  void initState() {
    super.initState();
    tabController = TabController(
      initialIndex: 0,
      length: 2,
      vsync: this,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        backgroundColor: third,
        child: Icon(Icons.add),
        onPressed: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => AddTalep()));
        },
      ),
      backgroundColor: Colors.grey[300],
      body: Container(
        color: Colors.grey[300],
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  InkWell(
                      onTap: () {
                        setState(() {
                          dropdownvalue = "";
                          tumuColort = Colors.amberAccent;
                          ColorKonumdeft = const Color(0xFF74A2B8);
                        });
                      },
                      child: Container(
                        height: 30,
                        width: 120,
                        padding: const EdgeInsets.symmetric(vertical: 1),
                        decoration: BoxDecoration(
                            border: Border.all(color: primary, width: 2),
                            color: tumuColort,
                            borderRadius:
                                const BorderRadius.all(Radius.circular(30))),
                        child: Padding(
                          padding: const EdgeInsets.only(
                              top: 3, bottom: 3, left: 5, right: 5),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
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
                          ColorKonumdeft = Colors.amberAccent;
                          tumuColort = const Color(0xFF74A2B8);
                        });
                      },
                      child: Container(
                        height: 30,
                        width: 200,
                        padding: const EdgeInsets.symmetric(vertical: 1),
                        decoration: BoxDecoration(
                            border: Border.all(color: primary, width: 2),
                            color: ColorKonumdeft,
                            borderRadius:
                                const BorderRadius.all(Radius.circular(30))),
                        child: Padding(
                          padding: const EdgeInsets.only(
                              top: 3, bottom: 3, left: 5, right: 5),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
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
              Container(
                height: MediaQuery.of(context).size.height * 0.8,
                width: MediaQuery.of(context).size.width * 0.9,
                child: _talepList(context),
                color: Colors.grey[300],
              ),
            ],
          ),
        ),
      ),
    );
  }

  String dropdownvaluef = "";
  String dropdownvalue = "";
  Widget _talepList(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
        stream: TalepService().getStatus(),
        builder: (context, snapshot) {
          List? documents = snapshot.data?.docs;
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
            print("e" + dropdownvalue);
          }
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
                                  "${myposttalep.get('baslik')}",
                                  style: TextStyle(
                                      fontSize: 17,
                                      color: subtitle,
                                      fontWeight: FontWeight.w500),
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 1,
                                ),
                                children: [
                                  Text(
                                    "${myposttalep.get('aciklama')}",
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
                                                  InkWell(
                                                    onTap: () {
                                                      showDialog(
                                                          context: context,
                                                          builder: (BuildContext
                                                              context) {
                                                            return AlertDialog(
                                                              shape: RoundedRectangleBorder(
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              10)),
                                                              scrollable: true,
                                                              content:
                                                                  Container(
                                                                width: MediaQuery.of(
                                                                            context)
                                                                        .size
                                                                        .width *
                                                                    0.8,
                                                                height: MediaQuery.of(
                                                                            context)
                                                                        .size
                                                                        .height *
                                                                    0.8,
                                                                child: Column(
                                                                  children: [
                                                                    Expanded(
                                                                      flex: 1,
                                                                      child:
                                                                          Container(
                                                                        alignment:
                                                                            Alignment.center,
                                                                        decoration:
                                                                            BoxDecoration(
                                                                          borderRadius:
                                                                              BorderRadius.circular(10),
                                                                          color:
                                                                              fifth,
                                                                        ),
                                                                        width: MediaQuery.of(context)
                                                                            .size
                                                                            .width,
                                                                        child:
                                                                            Center(
                                                                          child:
                                                                              Column(
                                                                            mainAxisAlignment:
                                                                                MainAxisAlignment.center,
                                                                            children: [
                                                                              CircleAvatar(
                                                                                backgroundImage: AssetImage("assets/images/logo.png"),
                                                                                radius: 30,
                                                                              ),
                                                                              Padding(
                                                                                padding: const EdgeInsets.only(left: 48.0),
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
                                                                                        color: Colors.white,
                                                                                        fontSize: 22,
                                                                                        fontWeight: FontWeight.w500,
                                                                                      ),
                                                                                    ),
                                                                                  ],
                                                                                ),
                                                                              ),
                                                                              Divider(
                                                                                color: Colors.grey,
                                                                                thickness: 2,
                                                                                indent: 70,
                                                                                endIndent: 70,
                                                                                height: 1,
                                                                              ),
                                                                              SizedBox(height: 10),
                                                                              Padding(
                                                                                padding: const EdgeInsets.only(left: 48.0),
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
                                                                                        color: Colors.white,
                                                                                        fontSize: 18,
                                                                                        fontWeight: FontWeight.w500,
                                                                                      ),
                                                                                    ),
                                                                                  ],
                                                                                ),
                                                                              ),
                                                                              Divider(
                                                                                color: Colors.grey,
                                                                                thickness: 2,
                                                                                indent: 70,
                                                                                endIndent: 70,
                                                                                height: 1,
                                                                              ),
                                                                            ],
                                                                          ),
                                                                        ),
                                                                      ),
                                                                    ),
                                                                    Expanded(
                                                                      flex: 2,
                                                                      child:
                                                                          Scaffold(
                                                                        appBar:
                                                                            TabBar(
                                                                          indicatorColor:
                                                                              Colors.amber,
                                                                          controller:
                                                                              tabController,
                                                                          tabs: [
                                                                            Container(
                                                                              height: 20,
                                                                              child: Text(
                                                                                "İlanlar",
                                                                                style: TextStyle(color: Colors.black, fontSize: 15),
                                                                              ),
                                                                            ),
                                                                            Text(
                                                                              "Talepler",
                                                                              style: TextStyle(color: Colors.black, fontSize: 15),
                                                                            )
                                                                          ],
                                                                        ),
                                                                        body:
                                                                            Container(
                                                                          child:
                                                                              TabBarView(
                                                                            controller:
                                                                                tabController,
                                                                            children: [
                                                                              Container(
                                                                                child: Padding(
                                                                                  padding: const EdgeInsets.symmetric(horizontal: 0.0),
                                                                                  child: myListdView(context),
                                                                                ),
                                                                                decoration: BoxDecoration(
                                                                                  borderRadius: BorderRadius.circular(10),
                                                                                  color: Colors.blueGrey,
                                                                                ),
                                                                              ),
                                                                              Container(
                                                                                child: _talepList(context),
                                                                                decoration: BoxDecoration(
                                                                                  borderRadius: BorderRadius.circular(10),
                                                                                  color: Colors.blueGrey,
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
                                                        padding:
                                                            const EdgeInsets
                                                                    .symmetric(
                                                                horizontal:
                                                                    8.0),
                                                        child: Text(
                                                            "${mypostauth!.get('name')}"
                                                                .toString(),
                                                            style: TextStyle(
                                                                fontSize: 14,
                                                                color:
                                                                    primary)),
                                                      ),
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    width: 50,
                                                  ),
                                                  IconButton(
                                                      onPressed: () async {
                                                        await FlutterPhoneDirectCaller
                                                            .callNumber(
                                                                "${mypostauth.get('name')}");
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
}
