import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:evdeneve/addilan.dart';
import 'package:evdeneve/services/authServices.dart';
import 'package:evdeneve/services/talep_services.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';

import '../addtalep.dart';
import '../constants.dart';

class benimTalep extends StatefulWidget {
  const benimTalep({Key? key}) : super(key: key);

  @override
  _benimTalepState createState() => _benimTalepState();
}

FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

class _benimTalepState extends State<benimTalep> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.grey[300],
        elevation: 1,
        backwardsCompatibility: true,
        centerTitle: true,
        title: Text(
          "Taleplerim",
          style: TextStyle(color: Colors.black),
        ),
      ),
      backgroundColor: Colors.grey[300],
      body: Container(
        color: Colors.grey[300],
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
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
}

String dropdownvaluef = "";
String dropdownvalue = "";
int index = 0;
String? emailValue = "";
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
                                style: TextStyle(fontSize: 11, color: subtext),
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
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
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
                                                          BorderRadius.circular(
                                                              10),
                                                      color: third),
                                                  height: MediaQuery.of(context)
                                                          .size
                                                          .height *
                                                      0.05,
                                                  width: MediaQuery.of(context)
                                                          .size
                                                          .width *
                                                      0.4,
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
                                                              "${mypostauth.get('name')}");
                                                    }, //Telefon aramasına gidecek, //phone ekleme
                                                    icon: const Icon(
                                                      Icons.phone,
                                                      size: 25,
                                                      color: Color(0xFF007700),
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
