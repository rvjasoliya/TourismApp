import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:sqflite/sqlite_api.dart';
import 'package:tourism_app/Palette/image.dart';
import 'package:tourism_app/View/place_detail.dart';
import '../Database/db.dart';
import '../Palette/color.dart';
import '../utils.dart';
import 'add_place.dart';
import 'hotels_detail.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

// Suggestion All
// ignore: non_constant_identifier_names
List<userdata> FullData = [
  //
  // 1
  //
  userdata(
    image: Appimages.Place1,
    name: 'San Antonio',
    location: 'USA',
    id: '0',
    catogery: 'Suggestions',
  ),
  userdata(
    image: Appimages.Place2,
    name: 'New York',
    location: 'Canada',
    id: '0',
    catogery: 'Suggestions',
  ),
  userdata(
    image: Appimages.Place3,
    name: 'San Francisco',
    location: 'USA',
    id: '0',
    catogery: 'Suggestions',
  ),
  //
  //2
  //
  userdata(
    image: Appimages.Place4,
    name: 'The Strip',
    location: 'USA',
    id: '1',
    catogery: 'Top Rated',
  ),
  userdata(
    image: Appimages.Place5,
    name: 'Disney World',
    location: 'London',
    id: '1',
    catogery: 'Top Rated',
  ),
  userdata(
    image: Appimages.Place6,
    name: 'Fort Sumter',
    location: 'Franch',
    id: '1',
    catogery: 'Top Rated',
  ),
//
//
//
  userdata(
    image: Appimages.Place7,
    name: 'Times Square',
    location: 'Japan',
    id: '2',
    catogery: 'Nature',
  ),
  userdata(
    image: Appimages.Place8,
    name: 'White House',
    location: 'Orlando',
    id: '2',
    catogery: 'Nature',
  ),
  userdata(
    image: Appimages.Place9,
    name: 'Road to Hana',
    location: 'New York',
    id: '2',
    catogery: 'Nature',
  ),
//
//
//
  userdata(
    image: Appimages.Place10,
    name: 'Times Strip',
    location: 'Nova Soctia',
    id: '3',
    catogery: 'History',
  ),
  userdata(
    image: Appimages.Place11,
    name: 'Disney House',
    location: 'London',
    id: '3',
    catogery: 'History',
  ),
  userdata(
    image: Appimages.Place12,
    name: 'Square to Sumter',
    location: 'Washington',
    id: '3',
    catogery: 'History',
  ),
// //
// //
// //
  userdata(
    image: Appimages.Place13,
    name: 'Strip',
    location: 'Botson',
    id: '4',
    catogery: 'Religious',
  ),
  userdata(
    image: Appimages.Place14,
    name: 'Sumter House',
    location: 'Winnipag',
    id: '4',
    catogery: 'Religious',
  ),
  userdata(
    image: Appimages.Place15,
    name: 'House to Sumter',
    location: 'USA',
    id: '4',
    catogery: 'Religious',
  ),
];

class _HomePageState extends State<HomePage> {
  List<Map> suggestionplace = [];
  List<Map> topratedplace = [];
  List<Map> natureplace = [];
  List<Map> historyplace = [];
  List<Map> Religiousplace = [];

  @override
  void initState() {
    getPlaceDefualtData();
    getPlaceAddedData();
    super.initState();
  }

  void getPlaceDefualtData() async {
    Database? db = await MyDb.instance.database;
    var DefualtDataAdd =
        await db!.rawQuery("SELECT * FROM ${MyDb.defaultData}");
    for (var i = 0; i < 15; i++) {
      if (DefualtDataAdd[i]['cid'] == 0) {
        suggestionplace.add(DefualtDataAdd[i]);
      }
      if (DefualtDataAdd[i]['cid'] == 1) {
        topratedplace.add(DefualtDataAdd[i]);
      }
      if (DefualtDataAdd[i]['cid'] == 2) {
        natureplace.add(DefualtDataAdd[i]);
      }
      if (DefualtDataAdd[i]['cid'] == 3) {
        historyplace.add(DefualtDataAdd[i]);
      }

      if (DefualtDataAdd[i]['cid'] == 4) {
        Religiousplace.add(DefualtDataAdd[i]);
      }
    }
  }

  void getPlaceAddedData() async {
    Database? db = await MyDb.instance.database;
    var PlaceDataAdd = await db!.rawQuery("SELECT * FROM ${MyDb.place}");
    for (var j = 0; j <= PlaceDataAdd.length; j++) {
      if (PlaceDataAdd[j]['cid'] == 0) {
        suggestionplace.add(PlaceDataAdd[j]);
      }
      if (PlaceDataAdd[j]['cid'] == 1) {
        topratedplace.add(PlaceDataAdd[j]);
      }
      if (PlaceDataAdd[j]['cid'] == 2) {
        natureplace.add(PlaceDataAdd[j]);
      }
      if (PlaceDataAdd[j]['cid'] == 3) {
        historyplace.add(PlaceDataAdd[j]);
      }
      if (PlaceDataAdd[j]['cid'] == 4) {
        Religiousplace.add(PlaceDataAdd[j]);
      }
    }
  }
  // getdata() {
  //   Future.delayed(Duration(milliseconds: 500), () async {
  //     // First
  //     suggestionplace = await mydb.db
  //         .rawQuery("SELECT * FROM place WHERE catogery LIKE 'Suggestions'");
  //     // Second
  //     topratedplace = await mydb.db
  //         .rawQuery("SELECT * FROM place WHERE catogery LIKE 'Top Rated'");
  //     // Third
  //     natureplace = await mydb.db
  //         .rawQuery("SELECT * FROM place WHERE catogery LIKE 'Nature'");
  //     // Fourth
  //     historyplace = await mydb.db
  //         .rawQuery("SELECT * FROM place WHERE catogery LIKE 'History'");
  //     // Fifth
  //     Religiousplace = await mydb.db
  //         .rawQuery("SELECT * FROM place WHERE catogery LIKE 'Religious'");
  //     setState(() {});
  //     // print("suggestionplace List : $suggestionplace[]");
  //     // print("topratedplace List : $topratedplace");
  //     // print("natureplace List : $natureplace");
  //     // print("historyplace List : $historyplace");
  //     // print("Religiousplace List : $Religiousplace");
  //     // print("${historyplace[0]['image']}");
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    var h = MediaQuery.of(context).size.height;
    var w = MediaQuery.of(context).size.width;
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        backgroundColor: Palette.primaryColor,
        onPressed: () {
          // getdata();
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => const AddPlace()));
        },
        child: const Icon(Icons.add),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: h / 2.5,
              width: w,
              decoration: BoxDecoration(
                color: Palette.BlueColor,
                borderRadius: BorderRadius.only(
                  bottomRight: Radius.circular(w / 11),
                  bottomLeft: Radius.circular(w / 11),
                ),
                image: const DecorationImage(
                  image: AssetImage(Appimages.Background1),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            //
            //
            //
            // Text("No Any data To Show"),
            SizedBox(height: 15),
            TitleText('Suggestions'),
            const SizedBox(height: 20),
            PlaceListView(suggestionplace),
            //
            //
            //
            const SizedBox(height: 15),
            TitleText('Top Rated'),
            const SizedBox(height: 20),
            PlaceListView(topratedplace),
            //
            //
            //
            const SizedBox(height: 15),
            TitleText('Nature'),
            const SizedBox(height: 20),
            PlaceListView(natureplace),
            //
            //
            //
            const SizedBox(height: 15),
            TitleText('History'),
            const SizedBox(height: 20),
            PlaceListView(historyplace),
            //
            //
            //
            const SizedBox(height: 15),
            TitleText('Religious'),
            const SizedBox(height: 20),
            PlaceListView(Religiousplace),
            //
            //
            //
          ],
        ),
      ),
    );
  }

  // ignore: non_constant_identifier_names
  Widget TitleText(var titletext) {
    return Row(
      children: [
        const SizedBox(width: 10),
        Text(
          "$titletext",
          style: const TextStyle(
            color: Palette.BlackColor,
            fontSize: 17,
            fontWeight: FontWeight.bold,
          ),
        ),
        const Spacer(),
        IconButton(
          onPressed: () {},
          icon: const Icon(
            Icons.arrow_forward_rounded,
            size: 25,
          ),
        ),
        const SizedBox(width: 10),
      ],
    );
  }

  // ignore: non_constant_identifier_names
  Widget PlaceListView(List<Map> place) {
    var h = MediaQuery.of(context).size.height;
    var w = MediaQuery.of(context).size.width;
    // ignore: unnecessary_null_comparison
    return place.length == 0
        ? const Text(
            "No Any Data To Show",
            style: TextStyle(color: Colors.black, fontSize: 15),
          )
        : SizedBox(
            height: h / 6,
            width: w,
            child: ListView.builder(
              itemCount: place.length,
              scrollDirection: Axis.horizontal,
              itemBuilder: (BuildContext context, int index) {
                return Row(
                  children: [
                    const SizedBox(width: 10),
                    InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => PlaceDetail(
                              placeimage: place[index]['image'],
                              name: place[index]['name'],
                              placename: place[index]['location'],
                            ),
                          ),
                        );
                      },
                      child: Card(
                        elevation: 2,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Container(
                          height: h / 6.3,
                          width: w / 2.9,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Column(
                            children: [
                              Container(
                                height: h / 11,
                                decoration: BoxDecoration(
                                  image: DecorationImage(
                                    image: AssetImage(place[index]['image']),
                                    fit: BoxFit.cover,
                                  ),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
                              const SizedBox(height: 5),
                              Row(
                                children: [
                                  const SizedBox(width: 7),
                                  Text(
                                    '${place[index]['name']}',
                                    style: const TextStyle(
                                      color: Palette.BlackColor,
                                      fontSize: 15,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 3),
                              Row(
                                children: [
                                  const SizedBox(width: 7),
                                  Text(
                                    '${place[index]['location']}',
                                    style: const TextStyle(
                                      fontSize: 12,
                                      color: Palette.greyColor,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                );
              },
            ),
          );
  }
}

class userdata {
  String? image;
  String? name;
  String? location;
  String? id;
  String? catogery;
  userdata({this.image, this.name, this.location, this.id, this.catogery});
}
