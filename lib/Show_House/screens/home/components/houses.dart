import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:geolocator/geolocator.dart';
import 'package:tabibiplanet/Show_House/constants/constants.dart';
import 'package:tabibiplanet/Show_House/model/house.dart';
import 'package:tabibiplanet/Show_House/screens/details/details_screen.dart';

import '../../../../../NetworkHandler.dart';
import '../../../../data/ModelProfil/profileModel.dart';

class Houses extends StatefulWidget {
  @override
  _HousesState createState() => _HousesState();
}

NetworkHandler networkHandler = NetworkHandler();
ProfileModel profileModel = ProfileModel();
var data = [];

class _HousesState extends State<Houses> {
  void initState() {
    super.initState();

    fetchProfilData();
    this.getCurrentPosition();
  }

  Position? position;
  getCurrentPosition() async {
    position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    return position;
  }

  void fetchProfilData() async {
    var response = await networkHandler.get("/user/profile/getData");
    setState(() {
      profileModel = ProfileModel.fromJson(response["data"]);
    });
    houseData();
  }

  void houseData() async {
    var response = await networkHandler
        .get1("/house/house/getdatapays/${profileModel.email}");
    setState(() {
      data = (response["data"]);
    });
  }

  Widget _buildHouse(BuildContext context, int index) {
    House house = House.fromJson(data[index]);
    Size size = MediaQuery.of(context).size;

    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => DetailsScreen(
              house: house,
              geoloc: position,
            ),
          ),
        );
      },
      child: Padding(
        padding: EdgeInsets.symmetric(
            horizontal: appPadding, vertical: appPadding / 2),
        child: Container(
          height: 250,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Stack(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: Image(
                      height: 180,
                      width: size.width,
                      fit: BoxFit.cover,
                      image: AssetImage(house.imageUrl),
                    ),
                  ),
                  Positioned(
                    right: appPadding / 2,
                    top: appPadding / 2,
                    child: Container(
                      decoration: BoxDecoration(
                          color: white,
                          borderRadius: BorderRadius.circular(15)),
                      child: IconButton(
                        icon: house.isFav
                            ? Icon(
                                Icons.favorite_rounded,
                                color: red,
                              )
                            : Icon(
                                Icons.favorite_border_rounded,
                                color: black,
                              ),
                        onPressed: () {
                          setState(() {
                            house.isFav = !house.isFav;
                          });
                        },
                      ),
                    ),
                  )
                ],
              ),
              Row(
                children: [
                  Text(
                    '\$${house.price.toStringAsFixed(3)}',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Expanded(
                    child: Text(
                      house.address,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                          fontSize: 15, color: black.withOpacity(0.4)),
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  Text(
                    '${house.bedRooms} bedrooms / ',
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Text(
                    '${house.bathRooms} bathrooms / ',
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Text(
                    '${house.sqFeet} sqft',
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.builder(
        physics: BouncingScrollPhysics(),
        itemCount: data.length,
        itemBuilder: (context, index) {
          return _buildHouse(context, index);
        },
      ),
    );
  }
}
