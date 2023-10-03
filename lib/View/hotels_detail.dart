import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:rate/rate.dart';
import 'package:tourism_app/Database/db.dart';
import 'package:tourism_app/Palette/color.dart';
import 'package:tourism_app/Palette/image.dart';

import '../utils.dart';

class HotelDetail extends StatefulWidget {
  const HotelDetail({super.key});

  @override
  State<HotelDetail> createState() => _HotelDetailState();
}

// ignore: non_constant_identifier_names
List HomeImage = [
  Appimages.Hotel1,
  Appimages.Hotel2,
  Appimages.Hotel3,
  Appimages.Hotel4,
  Appimages.Hotel5,
  Appimages.Hotel6,
  Appimages.Hotel7,
  Appimages.Hotel8,
  Appimages.Hotel9
];
// ignore: non_constant_identifier_names
List HotelName = [
  'Hotel Ritz Paris',
  "Claridge's",
  'Raffles',
  'Taj Mahal Palace',
  'Beverly Hills Hotel',
  'Peninsula',
  'The Shelbourne Hotel',
  'The Ritz Hotel',
  'Beverly Palace'
];
// ignore: non_constant_identifier_names
List HotelPrice = [
  '1080\$',
  '250\$',
  '1500\$',
  '200\$',
  '850\$',
  '1099\$',
  '350\$',
  '750',
  '599\$'
];
// ignore: non_constant_identifier_names
List HotelLocation = [
  'Paris',
  'London',
  'Singapore',
  'Mumbai',
  'Los Angeles',
  'Hong Kong',
  'Dublin',
  'London',
  'Dubai'
];

class _HotelDetailState extends State<HotelDetail> {
  List<Map> hotellist = [];

  @override
  void initState() {
    // mydb1.open();
    getdata();
    super.initState();
  }

  getdata() {
    Future.delayed(const Duration(milliseconds: 500), () async {
      // hotellist = await mydb1.db1.rawQuery('SELECT * FROM hotel');
      print("call");
      print(hotellist);
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    var h = MediaQuery.of(context).size.height;
    var w = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Palette.primaryColor,
        title: const Text("Find a place to stay.."),
      ),
      body: SafeArea(
        child: Container(
          child: hotellist.length == 0
              ? Center(child: Text("No any Hotels to show."))
              : SingleChildScrollView(
                  child: Column(
                    children: hotellist.map((one) {
                      return Container(
                        width: w,
                        child: Column(
                          children: [
                            SizedBox(height: 10),
                            Card(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(16),
                              ),
                              elevation: 5,
                              child: SizedBox(
                                height: h / 4.3,
                                width: w / 1.08,
                                child: Column(
                                  children: [
                                    Container(
                                      width: w / 1.08,
                                      height: h / 8.1,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(16),
                                        image: DecorationImage(
                                          image: AssetImage(one['image']),
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    ),
                                    Container(
                                      padding: const EdgeInsets.all(10),
                                      child: Column(
                                        children: [
                                          TitleText("${one['name']}",
                                              '${one['price']}'),
                                          const SizedBox(height: 5),
                                          LocationText('${one['location']}'),
                                          const SizedBox(height: 5),
                                          HotelRate('${one['rate']}'),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            const Divider(),
                          ],
                        ),
                      );
                      //  SizedBox(height: 15),
                    }).toList(),
                  ),
                ),
        ),
      ),
    );
  }

  // Widget HotelsList(var name) {
  //   var h = MediaQuery.of(context).size.height;
  //   var w = MediaQuery.of(context).size.width;
  //   return Container(
  //     width: w,
  //     height: h / 1.25,
  //     child: ListView.builder(
  //       itemCount: HotelName.length,
  //       scrollDirection: Axis.vertical,
  //       itemBuilder: (BuildContext context, int index) {
  //         return Column(
  //           children: [
  //             Card(
  //               shape: RoundedRectangleBorder(
  //                 borderRadius: BorderRadius.circular(16),
  //               ),
  //               elevation: 5,
  //               child: Container(
  //                 height: h / 4.3,
  //                 width: w / 1.08,
  //                 child: Column(
  //                   children: [
  //                     Container(
  //                       width: w / 1.08,
  //                       height: h / 8.1,
  //                       decoration: BoxDecoration(
  //                         borderRadius: BorderRadius.circular(16),
  //                         image: DecorationImage(
  //                           image: AssetImage(HomeImage[index]),
  //                           fit: BoxFit.cover,
  //                         ),
  //                       ),
  //                     ),
  //                     Container(
  //                       padding: EdgeInsets.all(10),
  //                       child: Column(
  //                         children: [
  //                           TitleText(
  //                               "${HotelName[index]}", '${HotelPrice[index]}'),
  //                           const SizedBox(height: 5),
  //                           LocationText('${HotelLocation[index]}'),
  //                           const SizedBox(height: 5),
  //                           HotelRate(),
  //                         ],
  //                       ),
  //                     ),
  //                   ],
  //                 ),
  //               ),
  //             ),
  //             const Divider(),
  //           ],
  //         );
  //       },
  //     ),
  //   );
  // }

  // ignore: non_constant_identifier_names
  Widget TitleText(var titleText, var price) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          '$titleText',
          style: const TextStyle(
            color: Palette.BlackColor,
            fontSize: 17,
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(
          '$price',
          style: const TextStyle(
            color: Palette.BlackColor,
            fontSize: 17,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }

  // ignore: non_constant_identifier_names
  Widget LocationText(var locText) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          '$locText',
          style: const TextStyle(
            fontSize: 14,
          ),
        ),
        const Text(
          "Per Night",
          style: TextStyle(
            fontSize: 12,
          ),
        ),
      ],
    );
  }

  // ignore: non_constant_identifier_names
  Widget HotelRate(var rate) {
    return Row(
      children: [
        // Rate(
        //   iconSize: 25,
        //   color: Palette.primaryColor,
        //   allowHalf: true,
        //   allowClear: true,
        //   initialValue: 3.5,
        //   readOnly: false,
        //   // ignore: avoid_print
        //   onChange: (value) {
        //     setState(() {});
        //   },
        // ),

        const Icon(Icons.star, size: 25, color: Palette.YellowColor),
        Text("$rate"),
      ],
    );
  }
}
