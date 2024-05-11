import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:evdeneve/services/authServices.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_email_sender/flutter_email_sender.dart';

class Master extends StatefulWidget {
  Master({Key? key}) : super(key: key);

  @override
  State<Master> createState() => _MasterState();
}

class _MasterState extends State<Master> {
  bool _value = false;
  void _onChange(bool value) {
    setState(() {
      _value = value;
    });
  }

  TextEditingController _mesajController = TextEditingController();
  bool isHTML = false;
  List<String> attachments = [];
  String sendEmail = "";
  @override
  Widget build(BuildContext context) {
    return Material(
      child: Scaffold(
        backgroundColor: Colors.blueGrey,
        appBar: AppBar(
          backgroundColor: Colors.blueGrey,
          elevation: 1,
          backwardsCompatibility: true,
          centerTitle: true,
          title: Text(
            "Yönetici Sayfası",
            style: TextStyle(color: Colors.blueGrey.shade100),
          ),
        ),
        body: SingleChildScrollView(
          child: Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Container(
                  width: MediaQuery.of(context).size.width * 0.9,
                  child: Card(
                    color: Colors.blueGrey[200],
                    child: ExpansionTile(
                      trailing: InkWell(
                        child: Icon(Icons.send),
                        onTap: send,
                      ),
                      title: Text(
                        "Kullanıcılara Mesaj Gönder",
                        style: TextStyle(color: Colors.black),
                      ),
                      children: [
                        TextField(
                          controller: _mesajController,
                          style: TextStyle(color: Colors.black),
                          maxLines: 3,
                          cursorColor: Colors.black,
                          cursorHeight: 20,
                          enableSuggestions: true,
                          maxLength: 250,
                          decoration: InputDecoration(
                            contentPadding: EdgeInsets.symmetric(
                                horizontal: 10, vertical: 10),
                            filled: true,
                            fillColor: Colors.white,
                            hintText: "Mesajınız",
                            enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20),
                                borderSide: BorderSide(
                                    color: Colors.black,
                                    width: 2,
                                    style: BorderStyle.solid)),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(30),
                              borderSide: const BorderSide(
                                  color: Colors.redAccent,
                                  width: 2,
                                  style: BorderStyle.solid),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 100),
                Container(
                  child: Text(
                    "Kullanıcı Listesi",
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 20,
                        fontWeight: FontWeight.w600),
                  ),
                ),
                Container(
                  height: MediaQuery.of(context).size.height * 0.5,
                  width: MediaQuery.of(context).size.width * 0.9,
                  color: Colors.blueGrey,
                  child: Card(
                    elevation: 0,
                    color: Colors.blueGrey,
                    child: StreamBuilder<QuerySnapshot>(
                        stream: AuthService().getStatus(),
                        builder: (context, snapshot) {
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
                                  itemCount: snapshot.data!.docs.length,
                                  itemBuilder:
                                      (BuildContext context, int index) {
                                    QueryDocumentSnapshot<Object?>? mypost =
                                        snapshot.data?.docs[index];

                                    return Column(
                                      children: [
                                        Card(
                                            elevation: 3,
                                            color: Colors.white,
                                            child: ListTile(
                                              trailing: InkWell(
                                                onTap: () {
                                                  sendEmail =
                                                      mypost?.get('email');
                                                  send();
                                                },
                                                child: Icon(
                                                  Icons.mail,
                                                  color: Colors.red[200],
                                                ),
                                              ),
                                              textColor: Colors.black,
                                              title: Text(
                                                  "${mypost?.get('name')}"),
                                              subtitle: Text(
                                                  "${mypost?.get('email')}"),
                                            )),
                                      ],
                                    );
                                  },
                                );
                        }),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> send() async {
    print(sendEmail);
    final Email email = Email(
      body: _mesajController.text,
      subject: "Duyuru!!!",
      recipients: [sendEmail],
      attachmentPaths: attachments,
      isHTML: isHTML,
    );

    String platformResponse;

    try {
      await FlutterEmailSender.send(email);
      platformResponse = 'Mesajınız Gönderildi';
    } catch (error) {
      print(error);
      platformResponse = error.toString();
    }

    if (!mounted) return;

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(platformResponse),
      ),
    );
  }
}
