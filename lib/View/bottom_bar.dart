import 'package:flutter/material.dart';
import 'package:tourism_app/utils.dart';
import '../Database/db.dart';
import 'add_hotels.dart';
import 'home_page.dart';
import 'hotels_detail.dart';
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';

class BottomBar extends StatefulWidget {
  const BottomBar({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _BottomBarState createState() => _BottomBarState();
}

class _BottomBarState extends State<BottomBar> {
  var _selectedIndex = 0;
  @override
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        bottomNavigationBar: SalomonBottomBar(
          items: [
            /// Home
            SalomonBottomBarItem(
              icon: const Icon(Icons.home),
              title: const Text("Home"),
              selectedColor: Colors.purple,
            ),

            /// Attractions
            SalomonBottomBarItem(
              icon: const Icon(Icons.location_on),
              title: const Text("Attractions"),
              selectedColor: Colors.pink,
            ),

            /// Hotels
            SalomonBottomBarItem(
              icon: const Icon(Icons.hotel),
              title: const Text("Hotels"),
              selectedColor: Colors.teal,
            ),

            /// Profile
            SalomonBottomBarItem(
              icon: const Icon(Icons.add),
              title: const Text("Add Hotels"),
              selectedColor: Colors.blue,
            ),
          ],
          currentIndex: _selectedIndex,
          onTap: (i) {
            setState(() {
              _selectedIndex = i;
            });
          },
        ),
        body: _selectedIndex == 0
            ? const HomePage()
            : _selectedIndex == 1
                ? const HotelDetail()
                : _selectedIndex == 2
                    ? const HomePage()
                    : _selectedIndex == 3
                        ? const AddHotels()
                        : const HomePage(),
      ),
    );
  }
}
