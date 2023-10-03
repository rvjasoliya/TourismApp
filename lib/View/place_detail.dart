import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:like_button/like_button.dart';
import 'package:tourism_app/Database/db.dart';
import 'package:tourism_app/Palette/color.dart';

import '../Palette/image.dart';

class PlaceDetail extends StatefulWidget {
  var placeimage;
  var name;
  var placename;
  PlaceDetail({super.key, this.placeimage, this.name, this.placename});

  @override
  State<PlaceDetail> createState() => _PlaceDetailState();
}

class _PlaceDetailState extends State<PlaceDetail> {
  @override
  @override
  Widget build(BuildContext context) {
    var h = MediaQuery.of(context).size.height;
    var w = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Column(
        children: [
          Container(
            height: h / 2.5,
            width: w,
            decoration: BoxDecoration(
              color: Colors.blue,
              borderRadius: BorderRadius.only(
                bottomRight: Radius.circular(w / 13),
                bottomLeft: Radius.circular(w / 13),
              ),
              image: DecorationImage(
                image: AssetImage(widget.placeimage),
                fit: BoxFit.cover,
              ),
            ),
            child: Column(
              children: [
                SizedBox(height: h / 22),
                Row(children: [
                  IconButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: const Icon(
                        Icons.arrow_back_ios,
                        size: 25,
                        color: Colors.white,
                      )),
                ]),
              ],
            ),
          ),
          SizedBox(height: h / 35),
          Row(
            children: [
              SizedBox(width: 8),
              Text(
                "${widget.name}",
                style: const TextStyle(
                  color: Palette.BlackColor,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Spacer(),
              LikeButton(
                likeBuilder: (bool isLiked) {
                  return Icon(
                    Icons.favorite,
                    color: isLiked ? Colors.red : Colors.grey,
                    size: 30,
                  );
                },
                bubblesColor: const BubblesColor(
                  dotPrimaryColor: Color(0xff33b5e5),
                  dotSecondaryColor: Color(0xff0099cc),
                ),
              ),
              const SizedBox(width: 25),
            ],
          ),
          SizedBox(height: h / 55),
          Row(
            children: [
              const SizedBox(width: 8),
              Text(
                "${widget.placename}",
                style: const TextStyle(
                  color: Palette.greyColor,
                  fontSize: 15,
                ),
              ),
            ],
          ),
          SizedBox(height: h / 75),
          Container(
            padding: const EdgeInsets.all(10),
            width: w,
            child: Expanded(
              child: Text(
                  "${widget.name} City is situated in the northeastern United States, in southeastern ${widget.name} State, approximately halfway between Washington, D.C. and Boston. ${widget.name}, known officially as the State of ${widget.name}, is a state in the Northeastern United States. It is often called ${widget.name} State to distinguish it from its largest city, ${widget.name} City. The total driving distance from California to ${widget.name} is 2,866 miles or 4 612 kilometers. The total straight line flight distance from California to ${widget.name} is 2,413 miles. This is equivalent to 3 884 kilometers or 2,097 nautical miles."),
            ),
          ),
        ],
      ),
    );
  }
}

// 130