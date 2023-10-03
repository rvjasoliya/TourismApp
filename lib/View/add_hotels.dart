import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:icon_loading_button/icon_loading_button.dart';
import 'package:image_picker/image_picker.dart';
import 'package:rate/rate.dart';
import 'package:tourism_app/Database/db.dart';
import 'package:tourism_app/Palette/color.dart';

import '../Palette/image.dart';

class AddHotels extends StatefulWidget {
  const AddHotels({super.key});

  @override
  State<AddHotels> createState() => _AddHotelsState();
}

class _AddHotelsState extends State<AddHotels> {
// Place Name
  TextEditingController hotelname = TextEditingController();
// Place Location
  TextEditingController hotellocation = TextEditingController();
// PlaceDesc
  TextEditingController hotelprice = TextEditingController();

// Save Button
  final IconButtonController _btnController1 = IconButtonController();
  final IconButtonController _btnController2 = IconButtonController();
  var hotelrate;
  XFile? image;

  final ImagePicker? _picker = ImagePicker();
  // MyDb1 mydb1 = new MyDb1();

  @override
  void initState() {
    // mydb1.open();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var h = MediaQuery.of(context).size.height;
    var w = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Palette.primaryColor,
        title: const Text("Add Hotels"),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 30),
            // HotelImage
            InkWell(
              onTap: () {
                _btnController1.reset();
                bottomsheet();
              },
              child: Container(
                height: h / 4.8,
                width: w / 1.8,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(25),
                  image: DecorationImage(
                    image: image == null
                        ? const ExactAssetImage(
                            Appimages.AddImage,
                          ) as ImageProvider
                        : FileImage(
                            File(image!.path),
                          ),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),

            // HotelName

            SizedBox(height: h / 20),
            TitleText('Name : '),
            const SizedBox(height: 8),
            Container(
              width: w / 1.1,
              height: h / 15,
              padding: const EdgeInsets.fromLTRB(10, 0, 0, 0),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  border: Border.all(color: Palette.primaryColor)),
              child: TextField(
                controller: hotelname,
                decoration: const InputDecoration(
                  border: InputBorder.none,
                  labelText: "Name",
                  labelStyle: TextStyle(
                    color: Palette.primaryColor,
                  ),
                ),
                onTap: () {
                  _btnController1.reset();
                },
                cursorColor: Palette.primaryColor,
              ),
            ),
            // HotelLocation
            const SizedBox(height: 25),
            TitleText('Location : '),
            const SizedBox(height: 8),
            Container(
              width: w / 1.1,
              height: h / 15,
              padding: const EdgeInsets.fromLTRB(10, 0, 0, 0),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  border: Border.all(color: Palette.primaryColor)),
              child: TextField(
                controller: hotellocation,
                decoration: const InputDecoration(
                  border: InputBorder.none,
                  labelText: "Location",
                  labelStyle: TextStyle(
                    color: Palette.primaryColor,
                  ),
                ),
                onTap: () {
                  _btnController1.reset();
                },
                cursorColor: Palette.primaryColor,
              ),
            ),

            const SizedBox(height: 25),
            TitleText('Price : '),
            const SizedBox(height: 8),
            // HotelRate
            Container(
              width: w / 1.1,
              height: h / 15,
              padding: const EdgeInsets.fromLTRB(10, 0, 0, 0),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  border: Border.all(color: Palette.primaryColor)),
              child: TextField(
                controller: hotelprice,
                decoration: const InputDecoration(
                  border: InputBorder.none,
                  labelText: "Price",
                  labelStyle: TextStyle(
                    color: Palette.primaryColor,
                  ),
                ),
                onTap: () {
                  _btnController1.reset();
                },
                cursorColor: Palette.primaryColor,
              ),
            ),
            const SizedBox(height: 25),
            TitleText('Rate : '),
            const SizedBox(height: 8),
            // HotelRate
            Rate(
              iconSize: 40,
              color: Palette.primaryColor,
              allowHalf: true,
              allowClear: true,
              initialValue: 0.0,
              readOnly: false,
              // ignore: avoid_print
              onChange: (value) {
                setState(() {
                  hotelrate = value;
                });
                print(hotelrate);
                _btnController1.reset();
              },
            ),
            SizedBox(height: h / 33),
            IconLoadingButton(
              color: Palette.primaryColor,
              // iconColor: const Color(0xff0066ff),
              iconColor: Colors.white,
              valueColor: const Color(0xff0066ff),
              errorColor: const Color(0xffe0333c),
              successColor: const Color(0xff58B09C),
              iconData: Icons.done,
              onPressed: () {
                if (image?.path == null) {
                  _btnController1.error();
                  ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text("Please Select Image")));
                  return;
                }
                if (hotelname.text.isEmpty) {
                  _btnController1.error();
                  ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text("Please Enter Name")));
                  return;
                }
                if (hotellocation.text.isEmpty) {
                  _btnController1.error();
                  ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text("Please Add Location")));
                  return;
                }
                if (hotelprice.text.isEmpty) {
                  _btnController1.error();
                  ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text("Please Enter Price")));
                  return;
                }
                if (hotelrate == 0.0) {
                  _btnController1.error();
                  ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text("Please Rate This Hotel")));
                  return;
                } else {
                  DataAddDB();
                }

                // mydb1.db1.rawInsert(
                //     "INSERT OR REPLACE INTO hotel (name, location, price, rate, image) VALUES (?, ?, ?, ?, ?);",
                //     [
                //       hotelname.text,
                //       hotellocation.text,
                //       hotelprice.text,
                //       hotelrate,
                //       image!.path,
                //     ]);

                ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text("New Place Added")));

                // hotelname.text = '';
                // hotellocation.text = '';
                // hotelprice.text = '';
                // hotelrate = '';

                Future.delayed(const Duration(seconds: 1), () {
                  _btnController1.success();
                  Navigator.pop(context);
                });
              },
              successIcon: Icons.done,
              controller: _btnController1,
              child: const Text(
                'Save',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                ),
              ),
            ),
            //
            //
          ],
        ),
      ),
    );
  }

  void DataAddDB() {
    MyDb.instance.hotelDataInsert('${image!.path}', '${hotelname.text}',
        '${hotellocation.text}', '${hotelprice.text}', '${hotelrate}');
  }

  // ignore: non_constant_identifier_names
  Widget TitleText(var TitleText) {
    return Row(
      children: [
        const SizedBox(width: 20),
        Text(
          "$TitleText",
          style: const TextStyle(
            fontSize: 16,
            color: Colors.black,
          ),
        ),
      ],
    );
  }

  bottomsheet() {
    showModalBottomSheet<void>(
        context: context,
        builder: (BuildContext context) {
          return Column(mainAxisSize: MainAxisSize.min, children: [
            InkWell(
                onTap: () {
                  gallery();
                  Navigator.pop(context);
                },
                child: const ListTile(
                    title: Text("Gallery"), leading: Icon(Icons.image))),
            InkWell(
                onTap: () {
                  camera();
                  Navigator.pop(context);
                },
                child: const ListTile(
                    title: Text("Camera"), leading: Icon(Icons.camera))),
            const SizedBox(height: 30)
          ]);
        });
  }

  gallery() async {
    final XFile? sImage = await _picker?.pickImage(source: ImageSource.gallery);

    setState(() {
      image = sImage;
      // print(image);
    });
  }

  camera() async {
    final XFile? sImage = await _picker?.pickImage(source: ImageSource.camera);

    setState(
      () {
        image = sImage;
      },
    );
  }
}
