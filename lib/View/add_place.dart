// ignore_for_file: unnecessary_string_interpolations

import 'dart:io';

import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:icon_loading_button/icon_loading_button.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tourism_app/Database/db.dart';
import 'package:tourism_app/Palette/color.dart';

import '../Palette/image.dart';

class AddPlace extends StatefulWidget {
  const AddPlace({super.key});

  @override
  State<AddPlace> createState() => _AddPlaceState();
}

// Place Name

class _AddPlaceState extends State<AddPlace> {
  // MyDb mydb = new MyDb();

  TextEditingController placename = TextEditingController();
// Place Location
  TextEditingController placeLocation = TextEditingController();
// PlaceDesc
  TextEditingController placeDesc = TextEditingController();
// Save Button
  final IconButtonController _btnController1 = IconButtonController();
  final IconButtonController _btnController2 = IconButtonController();

  XFile? image;
  final ImagePicker? _picker = ImagePicker();

  @override
  void initState() {
    // mydb.open();
    super.initState();
  }

  final List<String> genderItems = [
    'Suggestions',
    'Top Rated',
    'Nature',
    'History',
    'Religious',
  ];

  String? dropselectedValue;

  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    var h = MediaQuery.of(context).size.height;
    var w = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Palette.primaryColor,
        title: const Text("Add Place"),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 30),
            // PlaceImage
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

            SizedBox(height: h / 20),
            TitleText('Catogery : '),
            const SizedBox(height: 10),

            SizedBox(
              width: w / 1.1,
              child: DropdownButtonFormField2(
                decoration: InputDecoration(
                  isDense: true,
                  contentPadding: EdgeInsets.zero,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                ),
                isExpanded: true,
                hint: const Text(
                  'Select Catogery',
                  style: TextStyle(
                    fontSize: 14,
                    color: Palette.primaryColor,
                  ),
                ),
                icon: const Icon(
                  Icons.arrow_drop_down,
                  color: Colors.black45,
                ),
                iconSize: 30,
                buttonHeight: 60,
                buttonPadding: const EdgeInsets.only(left: 20, right: 10),
                dropdownDecoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                ),
                items: genderItems
                    .map((item) => DropdownMenuItem<String>(
                          value: item,
                          child: Text(
                            item,
                            style: const TextStyle(
                              fontSize: 14,
                            ),
                          ),
                        ))
                    .toList(),
                validator: (value) {
                  if (value == null) {
                    return 'Please select gender.';
                  }
                },
                onChanged: (value) {
                  dropselectedValue = value.toString();
                },
                onSaved: (value) {
                  // dropselectedValue = value.toString();
                },
              ),
            ),

            // Placename

            const SizedBox(height: 20),
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
                controller: placename,
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
            // PlaceLocation
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
                controller: placeLocation,
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
            TitleText('Description : '),
            const SizedBox(height: 8),
            // Description
            SizedBox(
              width: w / 1.1,
              height: h / 7.5,
              child: CupertinoTextField(
                controller: placeDesc,
                padding: const EdgeInsets.all(8),
                keyboardType: TextInputType.text,
                maxLength: 150,
                onTap: () {
                  _btnController1.reset();
                },
              ),
            ),

            SizedBox(height: h / 20),
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
                if (dropselectedValue == null) {
                  _btnController1.error();
                  ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text("Please Select Catogery")));
                  return;
                }
                if (placename.text.isEmpty) {
                  _btnController1.error();
                  ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text("Please Enter Name")));
                  return;
                }
                if (placeLocation.text.isEmpty) {
                  _btnController1.error();
                  ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text("Please Add Location")));
                  return;
                } else {
                  DataAddDB();
                }

                // mydb.db.rawInsert(
                //     "INSERT OR REPLACE INTO place (catogery, name, location, description, image) VALUES (?, ?, ?, ?, ?);",
                //     [
                //       dropselectedValue,
                //       placename.text,
                //       placeLocation.text,
                //       placeDesc.text,
                //       image?.path,
                //     ]);

                ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text("New Place Added")));

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

  void DataAddDB() {
    var DropCid;
    if (dropselectedValue == 'Suggestions') {
      setState(() {
        DropCid = 0;
      });
    }
    if (dropselectedValue == 'Top Rated') {
      setState(() {
        DropCid = 1;
      });
    }
    if (dropselectedValue == 'Nature') {
      setState(() {
        DropCid = 2;
      });
    }
    if (dropselectedValue == 'History') {
      setState(() {
        DropCid = 3;
      });
    }

    if (dropselectedValue == 'Religious') {
      setState(() {
        DropCid = 4;
      });
    }
    MyDb.instance.placeDataInsert(
        '$DropCid',
        '$dropselectedValue',
        '${placename.text}',
        '${placeLocation.text}',
        '${placeDesc.text}',
        '${image?.path}');
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
