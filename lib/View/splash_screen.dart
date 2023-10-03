import 'dart:async';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tourism_app/Palette/color.dart';
import 'package:tourism_app/Palette/image.dart';
import '../Database/db.dart';
import 'bottom_bar.dart';
import 'home_page.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  // final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  // late Future<int> _counter;
  // int counter = 0;
  // Future<void> _incrementCounter() async {
  //   final SharedPreferences prefs = await _prefs;
  //   counter = (prefs.getInt('counter') ?? 0) + 1;
  //   // counter = (prefs.getInt('counter') ?? 0) - 1;
  //   print(counter);
  //   setState(() {
  //     _counter = prefs.setInt('counter', 1).then((bool success) {
  //       return _counter;
  //     });
  //   });
  // }

  @override
  void initState() {
    // counter == 0 ? DataAddDB() : _incrementCounter();
    // _counter = _prefs.then(
    //   (SharedPreferences prefs) {
    //     return prefs.getInt('counter') ?? 0;
    //   },
    // );
    // _incrementCounter();
    DataAddDB();
    super.initState();
    Timer(
      const Duration(seconds: 3),
      () => Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => const BottomBar(),
        ),
      ),
    );
  }

  void DataAddDB() {
    var ID;
    var CATOGERY;
    var NAME;
    var LOCATION;
    var IMAGE;
    for (int i = 0; i < FullData.length; i++) {
      // print(FullData[i].name);
      ID = FullData[i].id;
      CATOGERY = FullData[i].catogery;
      NAME = FullData[i].name;
      LOCATION = FullData[i].location;
      IMAGE = FullData[i].image;
      // print(FullData[i].name);
      MyDb.instance.defaultInsertData(ID, CATOGERY, NAME, LOCATION, IMAGE);
    }
    // _incrementCounter();
    // print(ID);
    // print(CATOGERY);
    // print(NAME);
    // print(LOCATION);
    // print(IMAGE);

    // print(FullData[0].name);
    // print(ID);
    // print(CATOGERY);
    // print(NAME);
    // print(LOCATION);
    // print(IMAGE);

    // print("mydb.db.rawInsert : ${mydb.db.rawInsert}");
    //   print("done");
  }

  @override
  Widget build(BuildContext context) {
    var h = MediaQuery.of(context).size.height;
    var w = MediaQuery.of(context).size.width;
    return Container(
      color: Colors.white,
      child: Column(
        children: [
          Container(
            height: h,
            width: w,
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.centerRight,
                end: Alignment.centerRight,
                colors: [
                  Color.fromARGB(255, 65, 122, 162),
                  Color.fromARGB(202, 70, 161, 231),
                ],
              ),
            ),
            child: Center(
              child: Container(
                height: h / 2.15,
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage(Appimages.SplashLogo),
                    fit: BoxFit.fill,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
