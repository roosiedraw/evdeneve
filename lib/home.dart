import 'package:animated_segmented_tab_control/animated_segmented_tab_control.dart';
import 'package:evdeneve/constants.dart';
import 'package:evdeneve/pages/ilanlar.dart';
import 'package:evdeneve/pages/profil.dart';
import 'package:evdeneve/pages/talepler.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> with TickerProviderStateMixin {
  Future<bool> _onWillPop() async {
    return (await showDialog(
          context: context,
          builder: (context) => new AlertDialog(
            title: new Text('Emin misin?'),
            content: new Text('Emlak Portalından çıkmak mı istiyorsun?'),
            actions: <Widget>[
              TextButton(
                onPressed: () => Navigator.of(context).pop(false),
                child: new Text('Hayır'),
              ),
              TextButton(
                onPressed: () => Navigator.of(context).pop(true),
                child: new Text('Evet'),
              ),
            ],
          ),
        )) ??
        false;
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,

      // Provide the [TabController]
      home: WillPopScope(
        onWillPop: _onWillPop,
        child: DefaultTabController(
          length: 3,
          initialIndex: 0,
          child: Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.grey[300],
              elevation: 0,
              toolbarHeight: 10,
            ),
            backgroundColor: Colors.grey[300],
            body: SafeArea(
              child: Stack(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 6.0),
                    child: Container(
                      decoration: BoxDecoration(
                          border: Border.all(color: primary, width: 2),
                          borderRadius: BorderRadius.circular(30)),
                      child: SegmentedTabControl(
                        // Customization of widget
                        radius: const Radius.circular(30),
                        backgroundColor: Colors.grey[300],

                        tabTextColor: fourth,
                        selectedTabTextColor: Colors.white,
                        squeezeIntensity: 2,
                        height: 30,

                        tabPadding: const EdgeInsets.all(8),
                        textStyle: Theme.of(context).textTheme.bodyText2,
                        // Options for selection
                        // All specified values will override the [SegmentedTabControl] setting
                        tabs: [
                          SegmentTab(
                            label: "İLANLAR",

                            // For example, this overrides [indicatorColor] from [SegmentedTabControl]
                            color: second,
                          ),
                          SegmentTab(label: 'TALEPLER', color: third),
                          SegmentTab(label: 'PROFİL', color: fifth),
                        ],
                      ),
                    ),
                  ),
                  // Sample pages
                  const Padding(
                    padding: EdgeInsets.only(top: 38),
                    child: TabBarView(
                      physics: BouncingScrollPhysics(),
                      children: [Ilanlar(), Talepler(), ProfilePage()],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class SampleWidget extends StatelessWidget {
  const SampleWidget({
    Key? key,
    required this.label,
    required this.color,
  }) : super(key: key);

  final String label;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      decoration: BoxDecoration(
          color: Colors.grey[300],
          borderRadius: const BorderRadius.vertical(top: Radius.circular(10))),
      child: Text(label),
    );
  }
}
