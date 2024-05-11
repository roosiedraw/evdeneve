import 'package:flutter/material.dart';

class IlanSayfa extends StatefulWidget {
  const IlanSayfa({Key? key}) : super(key: key);

  @override
  _IlanSayfaState createState() => _IlanSayfaState();
}

class _IlanSayfaState extends State<IlanSayfa> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text("İlan detay sayfası"),
    );
  }
}
