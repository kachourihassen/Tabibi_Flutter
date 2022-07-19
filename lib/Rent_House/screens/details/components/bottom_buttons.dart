import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';

import 'package:tabibiplanet/Rent_House/constants/constants.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../MAP.dart';

class BottomButtons extends StatefulWidget {
  final house;
  final geoloc;
  const BottomButtons({Key? key, required this.house, required this.geoloc})
      : super(key: key);

  @override
  State<BottomButtons> createState() => _BottomButtonsState();
}

class _BottomButtonsState extends State<BottomButtons> {
  void initState() {
    super.initState();
    get();
  }

  late GoogleMapController mapController;
  Location location = Location();

  Future<LatLng> get() async {
    final _locationData = await location.getLocation();
    return LatLng(_locationData.latitude!, _locationData.longitude!);
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Padding(
      padding: const EdgeInsets.only(bottom: appPadding),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          FutureBuilder<LatLng>(
              future: get(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  final locationModel = snapshot.data!;
                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => MapScreen(
                            house: widget.house,
                            geoloc: locationModel,
                          ),
                        ),
                      );
                    },
                    child: Container(
                      width: size.width * 0.4,
                      height: 60,
                      decoration: BoxDecoration(
                          color: darkBlue,
                          borderRadius: BorderRadius.circular(30),
                          boxShadow: [
                            BoxShadow(
                                color: darkBlue.withOpacity(0.6),
                                offset: Offset(0, 10),
                                blurRadius: 10)
                          ]),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            (Icons.map),
                            color: white,
                          ),
                          Text(
                            ' Maps',
                            style: TextStyle(
                              color: white,
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                            ),
                          )
                        ],
                      ),
                    ),
                  );
                }
                return const CircularProgressIndicator();
              }),
          GestureDetector(
            onTap: () async {
              final _call = 'tel:${widget.house}';
              if (await canLaunch(_call)) {
                await launch(_call);
              }
            },
            child: Container(
              width: size.width * 0.4,
              height: 60,
              decoration: BoxDecoration(
                  color: darkBlue,
                  borderRadius: BorderRadius.circular(30),
                  boxShadow: [
                    BoxShadow(
                        color: darkBlue.withOpacity(0.6),
                        offset: Offset(0, 10),
                        blurRadius: 10)
                  ]),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    (Icons.call_rounded),
                    color: white,
                  ),
                  Text(
                    ' Call',
                    style: TextStyle(
                      color: white,
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
