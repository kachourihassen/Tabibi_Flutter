import 'dart:convert';

import 'package:badges/badges.dart';
import 'package:tabibiplanet/pages/doctor_profile_page.dart';
import 'package:tabibiplanet/pages/textboxDoc.dart';
import 'package:tabibiplanet/theme/colors.dart';
import 'package:tabibiplanet/widgets/avatar_image.dart';
import 'package:tabibiplanet/widgets/doctor_box.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

import '../NetworkHandler.dart';

class DoctorPageAi extends StatefulWidget {
  const DoctorPageAi({Key? key}) : super(key: key);

  @override
  _DoctorPageAiState createState() => _DoctorPageAiState();
}

class _DoctorPageAiState extends State<DoctorPageAi> {
  NetworkHandler networkHandler = NetworkHandler();
  TextEditingController _search = TextEditingController();

  var data = [];
  bool verif = false;
  void didChangeDependencies() {
    super.didChangeDependencies();
    setState(() {});
  }

  shearchdata(String speciality) async {
    var response =
        await networkHandler.get("/user/speciality/Data/${speciality}");
    setState(() {
      data = (response["data"]);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: appBgColor,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text(
          "Home",
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 10),
            child: Icon(
              Icons.health_and_safety_outlined,
              color: Colors.grey,
            ),
          ),
        ],
      ),
      body: getBody(),
    );
  }

  getBody() {
    return SingleChildScrollView(
        child: Padding(
            padding: const EdgeInsets.only(top: 40, left: 10, right: 10),
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Row(
                children: [
                  Expanded(child: CustomTextBoxDoc(search: _search)),
                  SizedBox(
                    width: 5,
                  ),
                  GestureDetector(
                    onTap: () async {
                      var response = await networkHandler
                          .post_py("/ai", {'data': _search.text});
                      if (response.statusCode == 200 ||
                          response.statusCode == 201) {
                        print(
                            " Hi from Python output:########### ${(response.body)}");
                        if (response.body != "") {
                          setState(() {
                            switch (response.body) {
                              case "polymyalgiarheumaticaandgca":
                                shearchdata("Rheumatologists");
                                verif = true;
                                break;
                              case "depression":
                                shearchdata("Psychiatry");
                                verif = true;
                                break;
                              case "mitrazapine":
                                shearchdata("Therapist");
                                verif = true;
                                break;
                              case "hipreplacement":
                                shearchdata("Orthopedic");
                                verif = true;
                                break;
                              case "irritablebowelsyndrome":
                                shearchdata("Gastroenterologist");
                                verif = true;
                                break;
                              case "menopause":
                                shearchdata("gynecologist");
                                verif = true;
                                break;
                              case "kneeproblems":
                                shearchdata("Rheumatologists");
                                verif = true;
                                break;
                            }
                          });
                        }
                      }
                    },
                    child: Icon(
                      Icons.manage_search_sharp,
                      color: primary,
                      size: 35,
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 40,
              ),
              verif == false ? new Container() : getDoctorList()
            ])));
  }

  getDoctorList() {
    return new StaggeredGridView.countBuilder(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      crossAxisCount: 4,
      itemCount: data.length,
      itemBuilder: (BuildContext context, int index) => DoctorBox(
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) =>
                        DoctorProfilePage(index: index, doctor: data[index])));
          },
          index: index,
          doctor: data[index]),
      staggeredTileBuilder: (int index) =>
          new StaggeredTile.count(2, index.isEven ? 3 : 2),
      mainAxisSpacing: 4,
      crossAxisSpacing: 4,
    );
  }
}
