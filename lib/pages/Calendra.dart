import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:tabibiplanet/data/Specialite.dart';
import '../NetworkHandler.dart';
import '../data/ModelProfil/profileModel.dart';
import 'package:flutter/cupertino.dart';
import 'package:date_time_picker/date_time_picker.dart';
import 'package:group_button/group_button.dart';
import 'package:custom_radio_grouped_button/custom_radio_grouped_button.dart';

class CalendraScreen extends StatefulWidget {
  const CalendraScreen({Key? key, required this.doctor}) : super(key: key);
  final doctor;

  @override
  State<CalendraScreen> createState() => _CalendraScreenState();
}

class _CalendraScreenState extends State<CalendraScreen> {
  NetworkHandler networkHandler = NetworkHandler();
  ProfileModel profileModel = ProfileModel();
  late bool a = false;
  late bool z = false;
  late bool e = false;
  late bool r = false;
  late bool t = false;
  late bool y = false;
  late bool u = false;
  late bool i = false;
  late bool o = false;
  late bool p = false;
  late bool q = false;
  late bool s = false;
  late bool d = false;
  late bool f = false;
  late bool g = false;
  late bool h = false;
  String timeselected = "";
  String dateselected = "";
  void initState() {
    super.initState();
    fetchProfilData();
  }

  void fetchProfilData() async {
    var response = await networkHandler.get("/user/profile/getData");
    setState(() {
      profileModel = ProfileModel.fromJson(response["data"]);
    });
  }

  @override
  Widget build(BuildContext context) {
    var img = NetworkHandler().getImage(widget.doctor['email']);
    String url = widget.doctor['email'];
    DateTime date = DateTime.now();
    final controller = GroupButtonController();
    var placeholder = AssetImage('assets/original.gif');
    return Scaffold(
      appBar: AppBar(
        elevation: 5.0,
        backgroundColor: Color(0xff053F5E),
        centerTitle: true,
        title: Text(
          "Doctor Appointment Plan",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 190,
              decoration: BoxDecoration(
                  color: Color(0xff053F5E),
                  borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(30),
                      bottomRight: Radius.circular(30))),
              child: Container(
                margin: EdgeInsets.only(left: 30, bottom: 30),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    SizedBox(
                        height: 120,
                        width: 120,
                        child: ClipOval(
                          child: FutureBuilder<String>(
                              future: NetworkHandler()
                                  .getImagestatus(widget.doctor['email']),
                              builder: (context, snapshot) {
                                if (snapshot.data == "false") {
                                  return new Image(
                                    image: placeholder,
                                    fit: BoxFit.cover,
                                  );
                                } else {
                                  return CachedNetworkImage(
                                    imageUrl: NetworkHandler().getImageurl(url),
                                    placeholder: (context, url) =>
                                        new Icon(null),
                                    errorWidget: (context, url, error) =>
                                        new Icon(null),
                                  );
                                }
                              }),
                        )),
                    SizedBox(
                      width: 16,
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.only(top: 50),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              widget.doctor['first_name'] +
                                  " " +
                                  widget.doctor['last_name'],
                              style: TextStyle(
                                  color: Colors.black,
                                  fontFamily: "Roboto",
                                  fontSize: 30,
                                  fontWeight: FontWeight.w700),
                            ),
                            Text(
                              widget.doctor['role'],
                              style: TextStyle(
                                  color: Colors.grey[500],
                                  fontFamily: "Roboto",
                                  fontSize: 18,
                                  fontWeight: FontWeight.w400),
                            ),
                            Text(
                              widget.doctor['email'],
                              style: TextStyle(
                                  color: Colors.blue[500],
                                  fontFamily: "Roboto",
                                  fontSize: 16,
                                  fontWeight: FontWeight.w400),
                            ),
                          ],
                        ),
                      ),
                    ),
                    /* Icon(
                          Icons.document_scanner_rounded,
                          color: Colors.blue,
                          size: 20,
                        ),*/
                  ],
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.only(left: 20, top: 30),
              child: Text(
                months[DateTime.now().month - 1] +
                    ' ' +
                    DateTime.now().day.toString(),
                style: TextStyle(
                  color: Color(0xff363636),
                  fontSize: 20,
                  fontFamily: 'Roboto',
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.only(left: 20, top: 20, right: 20),
              height: 30,
              child: Column(
                children: [
                  Expanded(
                      child: Text(
                    "Select date",
                    style: TextStyle(
                      color: Color(0xff363636),
                      fontSize: 14,
                      fontFamily: 'Roboto',
                      fontWeight: FontWeight.w700,
                    ),
                  )),
                  Expanded(
                    child: DateTimePicker(
                      initialValue: '',
                      firstDate: DateTime.now(),
                      lastDate: DateTime(2100),
                      //dateLabelText: '',
                      onChanged: (val) => dateselected = val,
                      validator: (val) {
                        print(val);
                        return null;
                      },
                      onSaved: (val) => print(val),
                    ),
                  ),
                ],
              ),

              /*ListView(
                scrollDirection: Axis.vertical,
                children: [
                  demoDates("Mon", "21", true),
                  demoDates("Tue", "22", false),
                  demoDates("Wed", "23", false),
                  demoDates("Thur", "24", false),
                  demoDates("Fri", "25", false),
                  demoDates("Sat", "26", false),
                  demoDates("Sun", "27", false),
                  demoDates("Mon", "28", false),
                ],
              ),*/
            ),
            Container(
              margin: EdgeInsets.only(left: 20, top: 30),
              child: Text(
                'Morning',
                style: TextStyle(
                  color: Color(0xff363636),
                  fontSize: 23,
                  fontFamily: 'Roboto',
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.only(right: 20),
              child: GridView.count(
                shrinkWrap: true,
                crossAxisCount: 3,
                physics: NeverScrollableScrollPhysics(),
                childAspectRatio: 2.7,
                children: [
                  GestureDetector(
                    child: doctorTimingsData("08:00 AM", a),
                    onTap: () {
                      setState(() {
                        a = true;
                        z = false;
                        e = false;
                        r = false;
                        t = false;
                        y = false;
                        u = false;
                        i = false;
                        o = false;
                        p = false;
                        q = false;
                        s = false;
                        d = false;
                        f = false;
                        g = false;
                        h = false;
                        timeselected = "08:00 AM";
                        print(timeselected);
                      });
                    },
                  ),
                  GestureDetector(
                    child: doctorTimingsData("08:30 AM", z),
                    onTap: () {
                      setState(() {
                        a = false;
                        z = true;
                        e = false;
                        r = false;
                        t = false;
                        y = false;
                        u = false;
                        i = false;
                        o = false;
                        p = false;
                        q = false;
                        s = false;
                        d = false;
                        f = false;
                        g = false;
                        h = false;
                        timeselected = "08:30 AM";
                        print(timeselected);
                      });
                    },
                  ),
                  GestureDetector(
                    child: doctorTimingsData("09:00 AM", e),
                    onTap: () {
                      setState(() {
                        a = false;
                        z = false;
                        e = true;
                        r = false;
                        t = false;
                        y = false;
                        u = false;
                        i = false;
                        o = false;
                        p = false;
                        q = false;
                        s = false;
                        d = false;
                        f = false;
                        g = false;
                        h = false;
                        timeselected = "09:00 AM";
                        print(timeselected);
                      });
                    },
                  ),
                  GestureDetector(
                    child: doctorTimingsData("09:30 AM", r),
                    onTap: () {
                      setState(() {
                        a = false;
                        z = false;
                        e = false;
                        r = true;
                        t = false;
                        y = false;
                        u = false;
                        i = false;
                        o = false;
                        p = false;
                        q = false;
                        s = false;
                        d = false;
                        f = false;
                        g = false;
                        h = false;
                        timeselected = "09:30 AM";
                        print(timeselected);
                      });
                    },
                  ),
                  GestureDetector(
                    child: doctorTimingsData("10:00 AM", t),
                    onTap: () {
                      setState(() {
                        a = false;
                        z = false;
                        e = false;
                        r = false;
                        t = true;
                        y = false;
                        u = false;
                        i = false;
                        o = false;
                        p = false;
                        q = false;
                        s = false;
                        d = false;
                        f = false;
                        g = false;
                        h = false;
                        timeselected = "10:00 AM";
                        print(timeselected);
                      });
                    },
                  ),
                  GestureDetector(
                    child: doctorTimingsData("10:30 AM", y),
                    onTap: () {
                      setState(() {
                        a = false;
                        z = false;
                        e = false;
                        r = false;
                        t = false;
                        y = true;
                        u = false;
                        i = false;
                        o = false;
                        p = false;
                        q = false;
                        s = false;
                        d = false;
                        f = false;
                        g = false;
                        h = false;
                        timeselected = "10:30 AM";
                        print(timeselected);
                      });
                    },
                  ),
                  GestureDetector(
                    child: doctorTimingsData("11:00 AM", u),
                    onTap: () {
                      setState(() {
                        a = false;
                        z = false;
                        e = false;
                        r = false;
                        t = false;
                        y = false;
                        u = true;
                        i = false;
                        o = false;
                        p = false;
                        q = false;
                        s = false;
                        d = false;
                        f = false;
                        g = false;
                        h = false;
                        timeselected = "11:00 AM";
                        print(timeselected);
                      });
                    },
                  ),
                  GestureDetector(
                    child: doctorTimingsData("11:30 AM", i),
                    onTap: () {
                      setState(() {
                        a = false;
                        z = false;
                        e = false;
                        r = false;
                        t = false;
                        y = false;
                        u = false;
                        i = true;
                        o = false;
                        p = false;
                        q = false;
                        s = false;
                        d = false;
                        f = false;
                        g = false;
                        h = false;
                        timeselected = "11:30 AM";
                        print(timeselected);
                      });
                    },
                  ),
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.only(left: 25, top: 30),
              child: Text(
                'Evening',
                style: TextStyle(
                  color: Color(0xff363636),
                  fontSize: 23,
                  fontFamily: 'Roboto',
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.only(right: 20),
              child: GridView.count(
                shrinkWrap: true,
                crossAxisCount: 3,
                physics: NeverScrollableScrollPhysics(),
                childAspectRatio: 2.6,
                children: [
                  GestureDetector(
                    child: doctorTimingsData("13:00 AM", o),
                    onTap: () {
                      setState(() {
                        a = false;
                        z = false;
                        e = false;
                        r = false;
                        t = false;
                        y = false;
                        u = false;
                        i = false;
                        o = true;
                        p = false;
                        q = false;
                        s = false;
                        d = false;
                        f = false;
                        g = false;
                        h = false;
                        timeselected = "13:00 AM";
                        print(timeselected);
                      });
                    },
                  ),
                  GestureDetector(
                    child: doctorTimingsData("13:30 AM", p),
                    onTap: () {
                      setState(() {
                        a = false;
                        z = false;
                        e = false;
                        r = false;
                        t = false;
                        y = false;
                        u = false;
                        i = false;
                        o = false;
                        p = true;
                        q = false;
                        s = false;
                        d = false;
                        f = false;
                        g = false;
                        h = false;
                        timeselected = "13:30 AM";
                        print(timeselected);
                      });
                    },
                  ),
                  GestureDetector(
                    child: doctorTimingsData("14:00 AM", q),
                    onTap: () {
                      setState(() {
                        a = false;
                        z = false;
                        e = false;
                        r = false;
                        t = false;
                        y = false;
                        u = false;
                        i = false;
                        o = false;
                        p = false;
                        q = true;
                        s = false;
                        d = false;
                        f = false;
                        g = false;
                        h = false;
                        timeselected = "14:00 AM";
                        print(timeselected);
                      });
                    },
                  ),
                  GestureDetector(
                    child: doctorTimingsData("14:30 AM", s),
                    onTap: () {
                      setState(() {
                        a = false;
                        z = false;
                        e = false;
                        r = false;
                        t = false;
                        y = false;
                        u = false;
                        i = false;
                        o = false;
                        p = false;
                        q = false;
                        s = true;
                        d = false;
                        f = false;
                        g = false;
                        h = false;
                        timeselected = "14:30 AM";
                        print(timeselected);
                      });
                    },
                  ),
                  GestureDetector(
                    child: doctorTimingsData("15:00 AM", d),
                    onTap: () {
                      setState(() {
                        a = false;
                        z = false;
                        e = false;
                        r = false;
                        t = false;
                        y = false;
                        u = false;
                        i = false;
                        o = false;
                        p = false;
                        q = false;
                        s = false;
                        d = true;
                        f = false;
                        g = false;
                        h = false;
                        timeselected = "15:00 AM";
                        print(timeselected);
                      });
                    },
                  ),
                  GestureDetector(
                    child: doctorTimingsData("15:30 AM", f),
                    onTap: () {
                      setState(() {
                        a = false;
                        z = false;
                        e = false;
                        r = false;
                        t = false;
                        y = false;
                        u = false;
                        i = false;
                        o = false;
                        p = false;
                        q = false;
                        s = false;
                        d = false;
                        f = true;
                        g = false;
                        h = false;
                        timeselected = "15:30 AM";
                        print(timeselected);
                      });
                    },
                  ),
                  GestureDetector(
                    child: doctorTimingsData("16:00 AM", g),
                    onTap: () {
                      setState(() {
                        a = false;
                        z = false;
                        e = false;
                        r = false;
                        t = false;
                        y = false;
                        u = false;
                        i = false;
                        o = false;
                        p = false;
                        q = false;
                        s = false;
                        d = false;
                        f = false;
                        g = true;
                        h = false;
                        timeselected = "16:00 AM";
                        print(timeselected);
                      });
                    },
                  ),
                  GestureDetector(
                    child: doctorTimingsData("16:30 AM", h),
                    onTap: () {
                      setState(() {
                        a = false;
                        z = false;
                        e = false;
                        r = false;
                        t = false;
                        y = false;
                        u = false;
                        i = false;
                        o = false;
                        p = false;
                        q = false;
                        s = false;
                        d = false;
                        f = false;
                        g = false;
                        h = true;
                        timeselected = "16:30 AM";
                        print(timeselected);
                      });
                    },
                  ),
                ],
              ),
            ),
            GestureDetector(
              onTap: (() async {
                await verifyCondition(context);
              }),
              child: Container(
                alignment: Alignment.center,
                width: MediaQuery.of(context).size.width,
                height: 54,
                margin: EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Color(0xff107163),
                  borderRadius: BorderRadius.circular(5),
                  boxShadow: [
                    BoxShadow(
                      color: Color(0x17000000),
                      offset: Offset(0, 15),
                      blurRadius: 15,
                      spreadRadius: 0,
                    ),
                  ],
                ),
                child: Text(
                  'Make An Appointment',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontFamily: 'Roboto',
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget demoDates(String day, String date, bool isSelected) {
    return isSelected
        ? Container(
            width: 70,
            margin: EdgeInsets.only(right: 15),
            decoration: BoxDecoration(
              color: Color(0xff107163),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  child: Text(
                    day,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontFamily: 'Roboto',
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(top: 10),
                  padding: EdgeInsets.all(7),
                  child: Text(
                    date,
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 15,
                        fontFamily: 'Roboto',
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
          )
        : Container(
            width: 70,
            margin: EdgeInsets.only(right: 15),
            decoration: BoxDecoration(
              color: Color(0xffEEEEEE),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  child: Text(
                    day,
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 20,
                      fontFamily: 'Roboto',
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(top: 10),
                  padding: EdgeInsets.all(7),
                  child: Text(
                    date,
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 15,
                        fontFamily: 'Roboto',
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
          );
  }

  Widget doctorTimingsData(String time, bool isSelected) {
    return isSelected
        ? Container(
            margin: EdgeInsets.only(left: 20, top: 10),
            decoration: BoxDecoration(
              color: Color(0xff107163),
              borderRadius: BorderRadius.circular(5),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  margin: EdgeInsets.only(right: 2),
                  child: Icon(
                    Icons.access_time,
                    color: Colors.white,
                    size: 18,
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(left: 2),
                  child: Text(
                    '${time}',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 17,
                      fontFamily: 'Roboto',
                    ),
                  ),
                ),
              ],
            ),
          )
        : Container(
            margin: EdgeInsets.only(left: 20, top: 10),
            decoration: BoxDecoration(
              color: Color(0xffEEEEEE),
              borderRadius: BorderRadius.circular(5),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  margin: EdgeInsets.only(right: 2),
                  child: Icon(
                    Icons.access_time,
                    color: Colors.black,
                    size: 18,
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(left: 2),
                  child: Text(
                    '${time}',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 17,
                      fontFamily: 'Roboto',
                    ),
                  ),
                ),
              ],
            ),
          );
  }

  verifyCondition(context) async {
    print(timeselected.toString());
    print(dateselected.toString());
    print(widget.doctor['email']);
    print(profileModel.email);
    var result1 = await networkHandler.get1(
        "/appointment/checkappdate/${dateselected.toString()}/${widget.doctor['email']}/${profileModel.email}");
    var result = await networkHandler.get1(
        "/appointment/checkapp/${dateselected.toString()}/${timeselected.toString()}");

    if (dateselected.toString().length == 0) {
      setState(() {
        errorMessage(context, "Please select the Date");
      });
    } else {
      if (timeselected.toString().length == 0) {
        setState(() {
          errorMessage(context, "Please select the Time");
        });
      } else {
        if (result1['Status'] == true) {
          setState(() {
            errorMessage(context, "This Appointment it was selected");
          });
        } else {
          if (result['Status'] == true) {
            setState(() {
              errorMessage(context, "This Appointment it was selected");
            });
          } else {
            Map<String, dynamic> data = {
              "patient": profileModel.email,
              "doctor": widget.doctor['email'],
              "date": dateselected.toString(),
              "time": timeselected.toString(),
              "type": "Upcoming",
              "speciality": widget.doctor['speciality'],
              "pays": widget.doctor['pays'],
              "rent": "not",
            };
            var response =
                await networkHandler.post("/appointment/Appointment/add", data);

            if (response.statusCode == 200 || response.statusCode == 201) //{

              setState(() {
                Map<String, dynamic> output = json.decode(response.body);
                Navigator.pop(context);
              });
          }
        }
      }
    }
  }
}

errorMessage(context, String text) {
  return ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Stack(
        clipBehavior: Clip.none,
        children: [
          Container(
            padding: EdgeInsets.all(16),
            height: 90,
            decoration: BoxDecoration(
              color: Color(0xFFC72C41),
              borderRadius: BorderRadius.all(
                Radius.circular(20),
              ),
            ),
            child: Row(
              children: [
                const SizedBox(
                  width: 48,
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Alert!",
                        style: TextStyle(fontSize: 18, color: Colors.white),
                      ),
                      const Spacer(),
                      Text(
                        '${text} ',
                        style: TextStyle(fontSize: 16, color: Colors.white),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            bottom: 0,
            child: ClipRRect(
              borderRadius: const BorderRadius.only(
                bottomLeft: Radius.circular(20),
              ),
              child: SvgPicture.asset(
                "assets/bubbles.svg",
                height: 48,
                width: 40,
                //color: Color(0xFF801336),
              ),
            ),
          ),
          Positioned(
            top: -20,
            left: 0,
            child: Stack(alignment: Alignment.center, children: [
              SvgPicture.asset(
                "assets/fail.svg",
                height: 40,
              ),
            ]),
          ),
        ],
      ),
      behavior: SnackBarBehavior.floating,
      backgroundColor: Colors.transparent,
      elevation: 0,
    ),
  );
}
