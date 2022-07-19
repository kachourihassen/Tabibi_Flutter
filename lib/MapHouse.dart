import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:tabibiplanet/Login_Screens/core/const.dart';
import 'package:tabibiplanet/styles/colors.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:tabibiplanet/NetworkHandler.dart';
import 'package:location/location.dart';

import 'Show_House/model/house.dart';

class MapHouseScreen extends StatefulWidget {
  final House house;
  final geoloc;
  const MapHouseScreen({Key? key, required this.house, required this.geoloc})
      : super(key: key);
  @override
  _MapHouseScreenState createState() => _MapHouseScreenState();
}

class _MapHouseScreenState extends State<MapHouseScreen> {
  late GoogleMapController mapController;
  Map<MarkerId, Marker> markers = {};
  Map<PolylineId, Polyline> polylines = {};
  List<LatLng> polylineCoordinates = [];
  PolylinePoints polylinePoints = PolylinePoints();
  String googleAPiKey = "AIzaSyDXh7PftFF_85GepapVtugZQ4dIh2qNnVg";
  late BitmapDescriptor sourceIcon;
  late BitmapDescriptor destinationIcon;
  Set<Marker> _markers = Set<Marker>();
  late LatLng currentLocation;
  late LatLng destinationLocation;

  @override
  void initState() {
    super.initState();
    this.setInitialLocation();
    this.setSourceAndDestinationMarkerIcons();

    _getPolyline();
  }

  void setSourceAndDestinationMarkerIcons() async {
    sourceIcon = await BitmapDescriptor.fromAssetImage(
        ImageConfiguration(devicePixelRatio: 5.0), 'assets/sourceIcon.png');
    destinationIcon = await BitmapDescriptor.fromAssetImage(
        ImageConfiguration(devicePixelRatio: 2.0),
        'assets/destinationIcon.png');
    showPinsOnMap();
  }

  void setInitialLocation() {
    currentLocation = LatLng(widget.geoloc.latitude, widget.geoloc.longitude);
    destinationLocation = LatLng(double.parse(widget.house.address_x),
        double.parse(widget.house.address_y));
  }

  void showPinsOnMap() {
    setState(() {
      _markers.add(Marker(
          markerId: MarkerId('sourcePin'),
          position: currentLocation,
          icon: sourceIcon,
          onTap: () {
            setState(() {
              //this.userBadgeSelected = true;
            });
          }));

      _markers.add(Marker(
          markerId: MarkerId('destinationPin'),
          position: destinationLocation,
          icon: destinationIcon,
          onTap: () {
            setState(() {
              //this.pinPillPosition = PIN_VISIBLE_POSITION;
            });
          }));
    });
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: Stack(children: [
        Positioned.fill(
          child: GoogleMap(
            initialCameraPosition: CameraPosition(
                target: LatLng(widget.geoloc.latitude, widget.geoloc.longitude),
                zoom: 1),
            myLocationEnabled: true,
            tiltGesturesEnabled: true,
            compassEnabled: true,
            scrollGesturesEnabled: true,
            zoomGesturesEnabled: true,
            onMapCreated: _onMapCreated,
            polygons: myPolygon(),
            mapType: MapType.hybrid,
            //markers: Set<Marker>.of(markers.values),
            markers: _markers,
            polylines: Set<Polyline>.of(polylines.values),
          ),
        ),
        Positioned(
          top: 5,
          left: 20,
          child: IconButton(
            icon: Icon(Icons.arrow_back_ios_new),
            onPressed: () {
              Navigator.of(context, rootNavigator: true).pop(context);
              //Navigator.pop(context);
            },
            color: Colors.black,
          ),
        ),
        Positioned(
          top: 40,
          left: 0,
          right: 0,
          child: Container(
            padding: EdgeInsets.all(12),
            margin: EdgeInsets.only(
              top: 10,
              bottom: 10,
              left: 20,
              right: 20,
            ),
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(100),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.2),
                    blurRadius: 10,
                    offset: Offset.zero,
                  )
                ]),
            child: Row(
              children: [
                Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage(widget.house.imageUrl),
                      fit: BoxFit.fill,
                    ),
                    shape: BoxShape.circle,
                  ),
                ),
                SizedBox(
                  width: 10,
                ),
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  Text(
                    'Address: ${widget.house.address}',
                    style: TextStyle(
                      color: Color(MyColors.grey02),
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Text(
                    'Price: ${widget.house.price}',
                    style: TextStyle(
                      color: Colors.blue.shade400,
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ]),
                SizedBox(
                  width: 110,
                ),
                Image.asset(
                  "assets/destinationIcon.png", // Fixes border issues
                  width: 70.0,
                  height: 40.0,
                ),
              ],
            ),
          ),
        ),
      ]),
    );
  }

  Set<Polygon> myPolygon() {
    List<LatLng> polygonCoords = [];

    polygonCoords.add(LatLng(widget.geoloc.latitude, widget.geoloc.longitude));
    polygonCoords.add(LatLng(double.parse(widget.house.address_x),
        double.parse(widget.house.address_y)));

    Set<Polygon> polygonSet = Set();
    polygonSet.add(Polygon(
      strokeWidth: 10,
      polygonId: PolygonId('test'),
      points: polygonCoords,
      strokeColor: Color(0xFF08A5CB),
    ));

    return polygonSet;
  }

  void _onMapCreated(GoogleMapController controller) async {
    mapController = controller;
  }

  _addMarker(LatLng position, String id, BitmapDescriptor descriptor) {
    MarkerId markerId = MarkerId(id);
    Marker marker =
        Marker(markerId: markerId, icon: descriptor, position: position);
    markers[markerId] = marker;
  }

  _addPolyLine() {
    PolylineId id = PolylineId("poly");
    Polyline polyline = Polyline(
        polylineId: id, color: Colors.red, points: polylineCoordinates);
    polylines[id] = polyline;
    setState(() {});
  }

  _getPolyline() async {
    PolylineResult result = await polylinePoints.getRouteBetweenCoordinates(
      googleAPiKey,
      PointLatLng(widget.geoloc.latitude, widget.geoloc.longitude),
      PointLatLng(double.parse(widget.house.address_x),
          double.parse(widget.house.address_y)),
      travelMode: TravelMode.driving,
    );
    if (result.points.isNotEmpty) {
      result.points.forEach((PointLatLng point) {
        polylineCoordinates.add(LatLng(point.latitude, point.longitude));
      });
    }
    _addPolyLine();
  }
}
