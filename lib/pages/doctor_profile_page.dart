import 'package:cached_network_image/cached_network_image.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:tabibiplanet/theme/colors.dart';
import 'package:tabibiplanet/widgets/avatar_image.dart';
import 'package:tabibiplanet/widgets/contact_box.dart';
import 'package:tabibiplanet/widgets/doctor_info_box.dart';
import 'package:tabibiplanet/widgets/mybutton.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:url_launcher/url_launcher.dart';

import '../MapSample.dart';
import '../NetworkHandler.dart';
import 'Calendra.dart';

class DoctorProfilePage extends StatefulWidget {
  const DoctorProfilePage({
    Key? key,
    required this.index,
    this.doctor,
  }) : super(key: key);
  final int index;
  final doctor;

  @override
  _DoctorProfilePageState createState() => _DoctorProfilePageState();
}

class _DoctorProfilePageState extends State<DoctorProfilePage> {
  @override
  void initState() {
    super.initState();
    late LatLng currentPostion;
    //this.getCurrentPosition();
    get();
  }

  late GoogleMapController mapController;
  Location location = Location();

  Future<LatLng> get() async {
    final _locationData = await location.getLocation();
    return LatLng(_locationData.latitude!, _locationData.longitude!);
  }

  Position? position;
  /*getCurrentPosition() async {
    position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    return position;
  }*/

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.black),
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text(
          "Doctor's Profile ",
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.w600),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 10),
            child: FutureBuilder<LatLng>(
                future: get(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    final locationModel = snapshot.data!;
                    return GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => MapSample(
                                    doctor: widget.doctor,
                                    position: locationModel,
                                  )),
                        );
                      },
                      child: Image.asset(
                        "assets/svgpin.gif", // Fixes border issues
                        width: 50.0,
                        height: 10.0,
                      ),
                    );
                  }
                  return const CircularProgressIndicator();
                }),
          ),
        ],
      ),
      body: getBody(),
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(left: 20, right: 20),
        child: MyButton(
            disableButton: false,
            bgColor: primary,
            title: "Request For Appointment",
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => CalendraScreen(doctor: widget.doctor),
                ),
              );
            }),
      ),
      floatingActionButtonLocation:
          FloatingActionButtonLocation.miniCenterFloat,
    );
  }

  Widget cacheNetImage() {
    var img = NetworkHandler().getImage(widget.doctor['email']);
    String url = widget.doctor['email'];
    return CachedNetworkImage(
      placeholder: (context, url) => CircularProgressIndicator(),
      imageUrl: NetworkHandler().getImageurl(url), //
      errorWidget: (context, url, error) => Icon(null),
    );
  }

  getBody() {
    var img = NetworkHandler().getImage(widget.doctor['email']);
    String url = widget.doctor['email'];
    return SingleChildScrollView(
      padding: EdgeInsets.only(left: 15, right: 15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text("Patient time 8:00am - 5:00pm",
              style: TextStyle(fontSize: 13, color: Colors.green)),
          SizedBox(
            height: 25,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                      "Dr. ${widget.doctor['first_name']}" +
                          " " +
                          "${widget.doctor['last_name']}",
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.w700)),
                  SizedBox(
                    height: 5,
                  ),
                  Text(
                    "${widget.doctor['speciality']}",
                    style: TextStyle(color: Colors.grey, fontSize: 14),
                  ),
                ],
              ),
              Container(
                height: widget.index.isEven ? 60 : 25,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                ),
                child: cacheNetImage(),
              ),
            ],
          ),
          SizedBox(
            height: 25,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              RatingBar.builder(
                initialRating: 1.24,
                minRating: 1,
                direction: Axis.horizontal,
                allowHalfRating: true,
                itemCount: 5,
                itemPadding: EdgeInsets.symmetric(horizontal: 0.0),
                itemBuilder: (context, _) => Icon(
                  Icons.star,
                  color: Colors.amber,
                ),
                onRatingUpdate: (rating) {
                  print(rating);
                },
              ),
            ],
          ),
          SizedBox(
            height: 5,
          ),
          Text("4.0 Out of 5.0",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700)),
          SizedBox(
            height: 3,
          ),
          Text(
            "340 Patients review",
            style: TextStyle(color: Colors.grey, fontSize: 12),
          ),
          SizedBox(
            height: 25,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              GestureDetector(
                onTap: () async {
                  Uri _url = Uri.parse('https://flutter.dev');
                  if (!await launchUrl(_url)) {
                    throw 'Could not launch $_url';
                  }
                },
                child: ContactBox(
                  icon: Icons.link_rounded,
                  color: Colors.blue,
                ),
              ),
              GestureDetector(
                onTap: () async {
                  final _call = 'tel:${widget.doctor['phone']}';
                  if (await canLaunch(_call)) {
                    await launch(_call);
                  }
                },
                child: ContactBox(
                  icon: Icons.call_end,
                  color: Colors.green,
                ),
              ),
              GestureDetector(
                onTap: () async {
                  final _text = 'sms:${widget.doctor['phone']}';
                  if (await canLaunch(_text)) {
                    await launch(_text);
                  }
                },
                child: ContactBox(
                  icon: Icons.chat_rounded,
                  color: Colors.purple,
                ),
              ),
            ],
          ),
          SizedBox(
            height: 25,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              DoctorInfoBox(
                value: "500+",
                info: "Successful Patients",
                icon: Icons.groups_rounded,
                color: Colors.green,
              ),
              DoctorInfoBox(
                value: "${widget.doctor['year']} Years",
                info: "Experience",
                icon: Icons.medical_services_rounded,
                color: Colors.purple,
              ),
            ],
          ),
          SizedBox(
            height: 35,
          ),
          Column(
            children: [
              Container(
                  //margin:
                  //EdgeInsets.only(left: 30, top: 100, right: 30, bottom: 50),
                  height: 175,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(10),
                        topRight: Radius.circular(10),
                        bottomLeft: Radius.circular(10),
                        bottomRight: Radius.circular(10)),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.1),
                        spreadRadius: 1,
                        blurRadius: 1,
                        offset: Offset(1, 1), // changes position of shadow
                      ),
                    ],
                  ),
                  child: Column(
                    children: [
                      Text(
                        "About:",
                        style: TextStyle(
                            color: Colors.black54,
                            fontSize: 18,
                            fontWeight: FontWeight.w700),
                      ),
                      SizedBox(
                        height: 8,
                      ),
                      Text(
                        "${widget.doctor['about']}",
                        style: TextStyle(
                            color: Colors.grey,
                            fontSize: 18,
                            fontWeight: FontWeight.w500),
                      ),
                    ],
                  )),
            ],
          )
        ],
      ),
    );
  }
}
