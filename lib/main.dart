import 'package:evdeneve/home.dart';
import 'package:evdeneve/pages/imageselect.dart';
import 'package:evdeneve/pages/master.dart';
import 'package:evdeneve/pages/profil.dart';
import 'package:evdeneve/register.dart';
import 'package:evdeneve/services/authServices.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'login.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
      options: FirebaseOptions(
    apiKey: "AIzaSyDHPkASvfPBTGY34KyXpHo_ear6rWqA42M", // Your apiKey
    appId: "XXX", // Your appId
    messagingSenderId: "XXX", // Your messagingSenderId
    projectId: "XXX", // Your projectId
  ));
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Emlak Portalı',
      theme: _configureThemeData(),
      debugShowCheckedModeBanner: false,
      home: fcm(),
    );
  }

  ThemeData _configureThemeData() {
    return ThemeData(
        textTheme: const TextTheme(
            headline1: TextStyle(
                fontSize: 25,
                height: 0.8,
                color: Color(0xFF171329),
                fontWeight: FontWeight.w700),
            subtitle1: TextStyle(
              fontSize: 20,
              color: Color(0xFFFDEFEC),
            ),
            subtitle2: TextStyle(
              fontSize: 12,
              color: Colors.grey,
            ),
            bodyText1: TextStyle(
              fontSize: 15,
              color: Color(0xFF992A13),
            ),
            bodyText2: TextStyle(
              fontSize: 12,
              color: Color(0xFFD66C54),
            )));
  }
}

class fcm extends StatefulWidget {
  const fcm({Key? key}) : super(key: key);

  @override
  _fcmState createState() => _fcmState();
}

class _fcmState extends State<fcm> {
  late FirebaseMessaging messaging;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    messaging = FirebaseMessaging.instance;
    messaging.getToken().then((value) {
      value =
          "dkvqC2V0QGeHPAJ6UwBGaL:APA91bGFvov7vDSM2OSN-X55mUfeL1q5pVCH7vZ-Ny1ZH9a9OrNfiqC0NXH2RhNv8N2X_22kSerJ2FcJyr98xBKZ-ujQ6IkDo9u2S5UN_03kby6kDcQMvXzlx1dwAriDSEZBsIaDJwaJ";
      print(value);
    });

    FirebaseMessaging.onMessage.listen((RemoteMessage event) {
      print("message recieved");
      print(event.notification!.body);
    });
    FirebaseMessaging.onMessageOpenedApp.listen((message) {
      print('Message clicked!');
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Home(),
    );
  }
}
