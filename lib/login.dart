import 'package:evdeneve/constants.dart';
import 'package:evdeneve/home.dart';
import 'package:evdeneve/register.dart';
import 'package:evdeneve/services/authServices.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_email_sender/flutter_email_sender.dart';
import 'package:fluttertoast/fluttertoast.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  AuthService _authService = AuthService();
  String sendPassword = "";
  String sendEmail = "";
  bool isHTML = false;
  List<String> attachments = [];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Material(
          child: Stack(
            children: [
              Container(
                child: Padding(
                  padding: const EdgeInsets.only(
                      left: 8.0, right: 8, bottom: 8, top: 30),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Material(
                        borderRadius: BorderRadius.circular(20),
                        elevation: 20,
                        child: Container(
                          width: MediaQuery.of(context).size.width * 0.8,
                          height: MediaQuery.of(context).size.height * 0.33,
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(20),
                              border: Border.all(
                                  color: primary,
                                  width: 2,
                                  style: BorderStyle.solid)),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 8, vertical: 10),
                            child: Image.asset("assets/images/logo.png",
                                fit: BoxFit.contain),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(" Hoş Geldiniz",
                            style: TextStyle(
                                fontSize: 22,
                                fontWeight: FontWeight.w500,
                                fontFamily: "Lato",
                                color: fourth)),
                      ),
                      Divider(
                        indent: 120,
                        endIndent: 120,
                        thickness: 2,
                        color: third,
                        height: 1,
                      ),
                    ],
                  ),
                ),
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                decoration: BoxDecoration(color: primary),
              ),
              Positioned(
                top: MediaQuery.of(context).size.height * 0.45,
                bottom: MediaQuery.of(context).size.height * 0.1,
                left: MediaQuery.of(context).size.width * 0.1,
                right: MediaQuery.of(context).size.width * 0.1,
                child: Container(
                  child: Padding(
                    padding: const EdgeInsets.only(
                        top: 15.0, bottom: 8.0, left: 17, right: 8),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        TextFormField(
                          controller: _emailController,
                          cursorColor: Colors.white,
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.white,
                          ),
                          autofocus: true,
                          decoration: InputDecoration(
                            contentPadding: EdgeInsets.symmetric(
                                horizontal: 10, vertical: 10),
                            labelStyle:
                                TextStyle(color: Colors.white, fontSize: 15),
                            labelText: "Email",
                            focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20.0),
                                borderSide: BorderSide(color: Colors.white)),
                            enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.white),
                                borderRadius: BorderRadius.circular(10.0)),
                            prefixIcon: const Icon(
                              Icons.email,
                              color: Colors.white,
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        TextFormField(
                          controller: _passwordController,
                          obscureText: true,
                          cursorColor: Colors.white,
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.white,
                          ),
                          autofocus: true,
                          decoration: InputDecoration(
                            contentPadding: EdgeInsets.symmetric(
                                horizontal: 10, vertical: 10),
                            labelStyle:
                                TextStyle(color: Colors.white, fontSize: 15),
                            labelText: "Şifre",
                            focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20.0),
                                borderSide: BorderSide(color: Colors.white)),
                            enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.white),
                                borderRadius: BorderRadius.circular(10.0)),
                            prefixIcon: const Icon(
                              Icons.password,
                              color: Colors.white,
                            ),
                          ),
                        ),
                        TextButton(
                            onPressed: () {
                              sendEmail = _emailController.text;

                              send();
                            },
                            child: Text("Şifremi unuttum",
                                style: TextStyle(
                                    fontSize: 14, color: Colors.white54))),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                    primary: second,
                                    elevation: 15,
                                    shape: StadiumBorder(
                                        side: BorderSide(
                                            color: Colors.white, width: 2)),
                                    minimumSize: Size(150, 40)),
                                onPressed: () {
                                  _authService
                                      .signIn(_emailController.text,
                                          _passwordController.text)
                                      .then((value) {
                                    return Navigator.of(context)
                                        .pushAndRemoveUntil(
                                            MaterialPageRoute(
                                                builder: (context) => Home()),
                                            (Route<dynamic> route) => false);
                                  });
                                },
                                child: Text("Giriş Yap",
                                    style: TextStyle(
                                        color: primary, fontSize: 16))),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            TextButton(
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => Register()),
                                  );
                                },
                                child: Text(
                                  "Üye değil misin? Üye ol",
                                  style: TextStyle(
                                      fontSize: 14,
                                      color: Colors.white70,
                                      fontWeight: FontWeight.w700),
                                )),
                          ],
                        )
                      ],
                    ),
                  ),
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height,
                  decoration: BoxDecoration(
                      color: third,
                      borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(45),
                          topRight: Radius.circular(45),
                          bottomLeft: Radius.circular(45),
                          bottomRight: Radius.circular(45))),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Future<void> send() async {
    print(sendPassword);
    final Email email = Email(
      body: sendPassword,
      subject: "bbb",
      recipients: [sendEmail],
      attachmentPaths: attachments,
      isHTML: isHTML,
    );

    String platformResponse;

    try {
      await FlutterEmailSender.send(email);
      platformResponse = 'success';
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
