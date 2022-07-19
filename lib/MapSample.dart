import 'dart:async';
import 'dart:ffi';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:tabibiplanet/Login_Screens/core/const.dart';
import 'package:tabibiplanet/pages/Navigation_Drawer.dart';
import 'package:tabibiplanet/styles/colors.dart';
import 'Doctor/Navigation_Drawer_Doc.dart';
import 'NetworkHandler.dart';
import 'package:geolocator/geolocator.dart';

const double CAMERA_ZOOM = 16;
const double CAMERA_TILT = 80;
const double CAMERA_BEARING = 30;
const double PIN_VISIBLE_POSITION = 20;
const double PIN_INVISIBLE_POSITION = -220;

class MapSample extends StatefulWidget {
  const MapSample({Key? key, required this.doctor, required this.position})
      : super(key: key);
  final doctor;
  final position;
  @override
  State<MapSample> createState() => MapSampleState();
}

class MapSampleState extends State<MapSample> {
  late GoogleMapController mapController;
  Completer<GoogleMapController> _controller = Completer();
  late BitmapDescriptor sourceIcon;
  late BitmapDescriptor destinationIcon;
  Set<Marker> _markers = Set<Marker>();
  late LatLng currentLocation;
  late LatLng destinationLocation;
  String googleAPiKey = "AIzaSyDXh7PftFF_85GepapVtugZQ4dIh2qNnVg";
  Set<Polyline> _polylines = Set<Polyline>();
  List<LatLng> polylineCoordinates = [];
  late PolylinePoints polylinePoints;
  Map<PolylineId, Polyline> polylines = {};

  /*static final CameraPosition _kLake = CameraPosition(
      bearing: 192.8334901395799,
      target: LatLng(36.796395, 10.178125),
      tilt: 59.440717697143555,
      zoom: 19.151926040649414);*/
  @override
  void initState() {
    super.initState();
    this.setInitialLocation();
    this.setSourceAndDestinationMarkerIcons();
    polylinePoints = PolylinePoints();
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
    currentLocation =
        LatLng(widget.position.latitude, widget.position.longitude);
    destinationLocation = LatLng(double.parse(widget.doctor['address_x']),
        double.parse(widget.doctor['address_y']));
  }

  @override
  Widget build(BuildContext context) {
    final CameraPosition _kGooglePlex = CameraPosition(
      target: LatLng(double.parse(widget.doctor['address_x']),
          double.parse(widget.doctor['address_y'])),
      zoom: 1.4746,
    );
    CameraPosition initialCameraPosition = CameraPosition(
        zoom: CAMERA_ZOOM,
        tilt: CAMERA_TILT,
        bearing: CAMERA_BEARING,
        target: LatLng(double.parse(widget.doctor['address_x']),
            double.parse(widget.doctor['address_y'])));
    return new Scaffold(
      appBar: AppBar(
        title: Text(
          "Tabibi Maps",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontStyle: FontStyle.italic,
            color: Colors.black.withOpacity(0.6),
          ),
        ),
        elevation: 0,
        backgroundColor: Colors.blue.shade100.withAlpha(2),
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios_new),
          onPressed: () {
            Navigator.of(context, rootNavigator: true).pop(context);
            //Navigator.pop(context);
          },
          color: Colors.black,
        ),
      ),
      body: Stack(children: [
        Positioned.fill(
          child: GoogleMap(
            initialCameraPosition: _kGooglePlex,
            myLocationEnabled: true,
            tiltGesturesEnabled: true,
            compassEnabled: true,
            scrollGesturesEnabled: true,
            zoomGesturesEnabled: true,
            onMapCreated: _onMapCreated,
            polygons: myPolygon(),
            mapType: MapType.hybrid,
            markers: _markers,
            polylines: Set<Polyline>.of(polylines.values),
          ),
        ),
        Positioned(
          top: 20,
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
                      borderRadius: BorderRadius.circular(50),
                      border: Border.all(
                        color: AppColors.darkblue,
                        width: 1,
                      )),
                  child: cacheNetImage(),
                ),
                SizedBox(
                  width: 10,
                ),
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  Text(
                    widget.doctor['email'],
                    style: TextStyle(
                      color: Color(MyColors.header01),
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Text(
                    widget.doctor['speciality'],
                    style: TextStyle(
                      color: Color(MyColors.grey02),
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Text(
                    widget.doctor['pays'],
                    style: TextStyle(
                      color: Colors.blue.shade400,
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ]),
                SizedBox(
                  width: 50,
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
      /*floatingActionButton: FloatingActionButton.extended(
        onPressed: _goToTheLake,
        label: Text('To the Position!'),
        icon: Icon(Icons.directions_boat),
      ),*/
    );
  }

  void showPinsOnMap() {
    setState(() {
      _markers.add(Marker(
          markerId: MarkerId('sourcePin'),
          position: LatLng(widget.position.latitude, widget.position.longitude),
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

  /*Future<void> _goToTheLake() async {
    final GoogleMapController controller = await _controller.future;
    controller.animateCamera(CameraUpdate.newCameraPosition(_kLake));
  }*/

  Widget cacheNetImage() {
    var img = NetworkHandler().getImage(widget.doctor['email']);
    String url = widget.doctor['email'];
    return CachedNetworkImage(
      placeholder: (context, url) => CircularProgressIndicator(),
      imageUrl: NetworkHandler().getImageurl(url), //
      errorWidget: (context, url, error) => Icon(null),
    );
  }

  Set<Polygon> myPolygon() {
    List<LatLng> polygonCoords = [];

    polygonCoords
        .add(LatLng(widget.position.latitude, widget.position.longitude));
    polygonCoords.add(
        LatLng(destinationLocation.latitude, destinationLocation.longitude));

    Set<Polygon> polygonSet = Set();
    polygonSet.add(Polygon(
      strokeWidth: 5,
      polygonId: PolygonId('test'),
      points: polygonCoords,
      strokeColor: Color(0xFF08A5CB),
    ));

    return polygonSet;
  }

  Set<Circle> circles = Set.from([
    Circle(
      circleId: CircleId('test'),
      //center: LatLng(    DEST_LOCATION.longitude),
      radius: 400,
      strokeWidth: 2,
      fillColor: Colors.red.withOpacity(0.3),
    )
  ]);

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
      PointLatLng(widget.position.latitude, widget.position.longitude),
      PointLatLng(double.parse(widget.doctor['address_x']),
          double.parse(widget.doctor['address_y'])),
      travelMode: TravelMode.driving,
    );

    if (result.points.isNotEmpty) {
      result.points.forEach((PointLatLng point) {
        polylineCoordinates.add(LatLng(point.latitude, point.longitude));
      });
    }
    _addPolyLine();
  }

  void _onMapCreated(GoogleMapController controller) async {
    mapController = controller;
  }
}
