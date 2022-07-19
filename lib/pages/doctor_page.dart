import 'dart:convert';

import 'package:badges/badges.dart';
import 'package:tabibiplanet/data/ModelSearch/SearchModels.dart';
import 'package:tabibiplanet/pages/doctor_profile_page.dart';
import 'package:tabibiplanet/theme/colors.dart';
import 'package:tabibiplanet/widgets/avatar_image.dart';
import 'package:tabibiplanet/widgets/doctor_box.dart';
import 'package:tabibiplanet/widgets/textbox.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

import '../NetworkHandler.dart';

class DoctorPage extends StatefulWidget {
  const DoctorPage({Key? key}) : super(key: key);

  @override
  _DoctorPageState createState() => _DoctorPageState();
}

class _DoctorPageState extends State<DoctorPage> {
  NetworkHandler networkHandler = NetworkHandler();
  var data = [];
  var searchModelsData = [];

  void initState() {
    super.initState();
    shearchdata();
  }

  shearchdata() async {
    var response = await networkHandler.get("/user/role/chat/getData/doctor");
    setState(() {
      data = (response["data"]);
      searchModelsData = (response["data"]);
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
          "Doctors",
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 10),
            child: Icon(
              Icons.info,
              color: Colors.grey,
            ),
          )
        ],
      ),
      body: getBody(),
    );
  }

  getBody() {
    return SingleChildScrollView(
        child: Padding(
            padding: const EdgeInsets.only(left: 10, right: 10),
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Row(
                children: [
                  Expanded(
                    child: Container(
                      height: 40,
                      decoration: BoxDecoration(
                          color: Colors.grey.shade300,
                          borderRadius: BorderRadius.circular(50)),
                      child: TextField(
                        style: TextStyle(color: Colors.black),
                        decoration: InputDecoration(
                            prefixIcon: Icon(Icons.search, color: Colors.grey),
                            border: InputBorder.none,
                            hintText: "Search",
                            hintStyle:
                                TextStyle(color: Colors.grey, fontSize: 17)),
                        onChanged: searchDoc,
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 5,
                  ),
                ],
              ),
              SizedBox(
                height: 40,
              ),
              getDoctorList()
            ])));
  }

  void searchDoc(String query) {
    final suggestions = searchModelsData.where((data) {
      final searchTitle = data["first_name"].toLowerCase();
      final searchSpeciality = data["speciality"].toLowerCase();
      final searchEmail = data["email"].toLowerCase();
      final input = query.toLowerCase();
      return searchTitle.contains(input) || searchSpeciality.contains(input);
    }).toList();
    setState(() => data = suggestions);
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
        doctor: data[index],
      ),
      staggeredTileBuilder: (int index) =>
          new StaggeredTile.count(2, index.isEven ? 3 : 2),
      mainAxisSpacing: 4,
      crossAxisSpacing: 4,
    );
  }
}
