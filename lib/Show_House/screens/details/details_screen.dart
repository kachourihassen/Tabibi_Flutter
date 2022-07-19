import 'package:flutter/material.dart';
import 'package:tabibiplanet/Show_House/model/house.dart';
import 'package:tabibiplanet/Show_House/screens/details/components/bottom_buttons.dart';
import 'package:tabibiplanet/Show_House/screens/details/components/carousel_images.dart';
import 'package:tabibiplanet/Show_House/screens/details/components/custom_app_bar.dart';
import 'package:tabibiplanet/Show_House/screens/details/components/house_details.dart';

class DetailsScreen extends StatefulWidget {
  final house;
  final geoloc;

  const DetailsScreen({Key? key, required this.house, required this.geoloc})
      : super(key: key);

  @override
  _DetailsScreenState createState() => _DetailsScreenState();
}

class _DetailsScreenState extends State<DetailsScreen> {
  @override
  Widget build(BuildContext context) {
    //widget.house.moreImagesUrl.removeAt(1);
    var ints = new List<String>.from(widget.house.moreImagesUrl);
    return Scaffold(
      body: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          Column(
            children: [
              Stack(
                children: [
                  CarouselImages(ints),
                  CustomAppBar(widget.house),
                ],
              ),
              HouseDetails(widget.house),
            ],
          ),
          BottomButtons(
            house: widget.house,
            geoloc: widget.geoloc,
          ),
        ],
      ),
    );
  }
}
