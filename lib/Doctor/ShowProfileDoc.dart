import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:tabibiplanet/NetworkHandler.dart';
import '../../data/ModelProfil/profileModel.dart';
import 'Profile_Doc.dart';
import 'package:cached_network_image/cached_network_image.dart';

class ShowProfileDoc extends StatefulWidget {
  const ShowProfileDoc({Key? key}) : super(key: key);

  @override
  State<ShowProfileDoc> createState() => _ShowProfileDocState();
}

class _ShowProfileDocState extends State<ShowProfileDoc> {
  ProfileModel profileModel = ProfileModel();
  NetworkHandler networkHandler = NetworkHandler();
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
    var img = NetworkHandler().getImage(profileModel.email);
    var placeholder = AssetImage('assets/original.gif');
    String url = profileModel.email;
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        leading: IconButton(
          icon: Icon(Icons.edit_note_sharp),
          onPressed: () {
            Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(
                  builder: (context) => CreatProfileDoc(),
                ),
                (route) => false);
          },
          color: Colors.black,
        ),
      ),
      body: Stack(
        children: <Widget>[
          FutureBuilder<String>(
              future: NetworkHandler().getImagestatus(profileModel.email),
              builder: (context, AsyncSnapshot snapshot) {
                if (snapshot.data == "false") {
                  return SizedBox.expand(
                    child: new Image(
                      image: placeholder,
                      fit: BoxFit.cover,
                    ),
                  );
                } else {
                  return SizedBox.expand(
                    child: CachedNetworkImage(
                      imageUrl: NetworkHandler().getImageurl(url),
                      placeholder: (context, url) => new Icon(null),
                      //new CircularProgressIndicator(),
                      errorWidget: (context, url, error) => new Icon(null),
                    ),
                  );
                }
              }),
          DraggableScrollableSheet(
            minChildSize: 0.1,
            initialChildSize: 0.22,
            builder: (context, scrollController) {
              return SingleChildScrollView(
                controller: scrollController,
                child: Container(
                  constraints: BoxConstraints(
                      minHeight: MediaQuery.of(context).size.height),
                  color: Colors.white,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      //for user profile header
                      Container(
                        padding: EdgeInsets.only(left: 32, right: 32, top: 32),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            SizedBox(
                                height: 100,
                                width: 100,
                                child: ClipOval(
                                  child: FutureBuilder<String>(
                                      future: NetworkHandler()
                                          .getImagestatus(profileModel.email),
                                      builder: (context, snapshot) {
                                        if (snapshot.data == "false") {
                                          return new Image(
                                            image: placeholder,
                                            fit: BoxFit.cover,
                                          );
                                        } else {
                                          return CachedNetworkImage(
                                            imageUrl: NetworkHandler()
                                                .getImageurl(url),
                                            placeholder: (context, url) =>
                                                new Icon(null),
                                            /*new Image(
                                              image: img,
                                              fit: BoxFit.cover,
                                            ),*/
                                            errorWidget:
                                                (context, url, error) =>
                                                    new Icon(null),
                                          );
                                        }
                                      }),
                                )),
                            SizedBox(
                              width: 16,
                            ),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Text(
                                    profileModel.first_name +
                                        " " +
                                        profileModel.last_name,
                                    style: TextStyle(
                                        color: Colors.grey[800],
                                        fontFamily: "Roboto",
                                        fontSize: 36,
                                        fontWeight: FontWeight.w700),
                                  ),
                                  Text(
                                    profileModel.role,
                                    style: TextStyle(
                                        color: Colors.grey[500],
                                        fontFamily: "Roboto",
                                        fontSize: 16,
                                        fontWeight: FontWeight.w400),
                                  ),
                                ],
                              ),
                            ),
                            Icon(
                              Icons.sms,
                              color: Colors.blue,
                              size: 40,
                            )
                          ],
                        ),
                      ),

                      SizedBox(
                        height: 16,
                      ),
                      Container(
                        padding: EdgeInsets.all(32),
                        color: Colors.blue,
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Column(
                                children: <Widget>[
                                  Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: <Widget>[
                                      SizedBox(
                                        width: 4,
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ]),
                      ),
                      Column(
                        children: [
                          SizedBox(
                            height: 26,
                          ),
                          Container(
                            //padding: const EdgeInsets.only(left: 120),
                            child: Column(
                              children: <Widget>[
                                Text(
                                  "Address Email",
                                  style: TextStyle(
                                      color: Colors.grey[800],
                                      fontWeight: FontWeight.w700,
                                      fontFamily: "Roboto",
                                      fontSize: 18),
                                ),
                                SizedBox(
                                  height: 8,
                                ),
                                Text(
                                  profileModel.email,
                                  style: TextStyle(
                                      fontFamily: "Roboto", fontSize: 15),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 26,
                          ),
                          //container for about me

                          Container(
                            ////padding: EdgeInsets\.only\(left: 120\),
                            child: Column(
                              children: <Widget>[
                                Text(
                                  "Phone",
                                  style: TextStyle(
                                      color: Colors.grey[800],
                                      fontWeight: FontWeight.w700,
                                      fontFamily: "Roboto",
                                      fontSize: 18),
                                ),
                                SizedBox(
                                  height: 8,
                                ),
                                Text(
                                  profileModel.phone,
                                  style: TextStyle(
                                      fontFamily: "Roboto", fontSize: 15),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 26,
                          ),

                          //container for about me
                          Container(
                            //padding: EdgeInsets\.only\(left: 120\),
                            child: Column(
                              children: <Widget>[
                                Text(
                                  "Address",
                                  style: TextStyle(
                                      color: Colors.grey[800],
                                      fontWeight: FontWeight.w700,
                                      fontFamily: "Roboto",
                                      fontSize: 18),
                                ),
                                SizedBox(
                                  height: 8,
                                ),
                                Text(
                                  profileModel.address,
                                  style: TextStyle(
                                      fontFamily: "Roboto", fontSize: 15),
                                ),
                              ],
                            ),
                          ),

                          SizedBox(
                            height: 26,
                          ),
                          Container(
                            //padding: EdgeInsets\.only\(left: 120\),
                            child: Column(
                              children: <Widget>[
                                Text(
                                  "Location",
                                  style: TextStyle(
                                      color: Colors.grey[800],
                                      fontWeight: FontWeight.w700,
                                      fontFamily: "Roboto",
                                      fontSize: 18),
                                ),
                                SizedBox(
                                  height: 8,
                                ),
                                Text(
                                  profileModel.pays,
                                  style: TextStyle(
                                      fontFamily: "Roboto", fontSize: 15),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 26,
                          ),
                          //container for about me

                          Container(
                            //padding: EdgeInsets\.only\(left: 120\),
                            child: Column(
                              children: <Widget>[
                                Text(
                                  "About Me",
                                  style: TextStyle(
                                      color: Colors.grey[800],
                                      fontWeight: FontWeight.w700,
                                      fontFamily: "Roboto",
                                      fontSize: 18),
                                ),
                                SizedBox(
                                  height: 20,
                                ),
                                Container(
                                  margin: const EdgeInsets.only(
                                      left: 20.0, right: 20.0),
                                  child: Text(
                                    profileModel.about,
                                    style: TextStyle(
                                        fontFamily: "Roboto", fontSize: 15),
                                  ),
                                ),
                              ],
                            ),
                          ),

                          SizedBox(
                            height: 16,
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              );
            },
          )
        ],
      ),
    );
  }
}
