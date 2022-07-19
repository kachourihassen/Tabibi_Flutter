import 'dart:math';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:tabibiplanet/Doctor/Profile_Doc.dart';

import '../Login_Screens/intro_page.dart';
import '../NetworkHandler.dart';
import '../data/ModelProfil/profileModel.dart';
import 'HomePage.dart';

class NavPageDoc extends StatefulWidget {
  @override
  _NavPageDocState createState() => _NavPageDocState();
}

class _NavPageDocState extends State<NavPageDoc> {
  ProfileModel profileModel = ProfileModel();
  double value = 0;
  Widget page = WelcomePage();
  final storage = FlutterSecureStorage();
  NetworkHandler networkHandler = NetworkHandler();
  void initState() {
    super.initState();
    fetchProfilData();
    ImgData();
  }

  void fetchProfilData() async {
    var response = await networkHandler.get("/user/profile/getData");
    setState(() {
      profileModel = ProfileModel.fromJson(response["data"]);
    });
  }

  ImgData() async {
    await NetworkHandler().getImage(profileModel.email);
  }

  void logout() async {
    await storage.delete(key: "token");
    Navigator.pushAndRemoveUntil(context,
        MaterialPageRoute(builder: (context) => IntroPage()), (route) => false);
  }

  @override
  Widget build(BuildContext context) {
    var img = NetworkHandler().getImage(profileModel.email);
    String url = profileModel.email;
    var placeholder = AssetImage('assets/user.jpg');
    return Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
                gradient: LinearGradient(
                    colors: [Colors.blue.shade400, Colors.blue.shade800],
                    begin: Alignment.bottomCenter,
                    end: Alignment.topCenter)),
          ),
          SafeArea(
              child: Container(
            width: 200.0,
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                DrawerHeader(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CachedNetworkImage(
                        imageUrl: NetworkHandler().getImageurl(url),
                        imageBuilder: (context, imageProvider) => Container(
                          height: 55,
                          width: 55,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(50)),
                            image: DecorationImage(
                              image: img,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        placeholder: (context, url) => Container(
                          height: 55,
                          width: 55,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(50)),
                            image: DecorationImage(
                              image: AssetImage("assets/doc.jpg"),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        errorWidget: (context, url, error) => Container(
                          height: 55,
                          width: 55,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(50)),
                            image: DecorationImage(
                              image: AssetImage("assets/images1.png"),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            profileModel.first_name +
                                " " +
                                profileModel.last_name,
                            style: TextStyle(
                                color: Colors.grey[800],
                                fontFamily: "Roboto",
                                fontSize: 18,
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
                      /*const CircleAvatar(
                        radius: 50.0,
                        backgroundImage: NetworkImage(
                            "https://www.pavilionweb.com/wp-content/uploads/2017/03/man-300x300.png"),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      const Text(
                        "User ",
                        style: TextStyle(color: Colors.white, fontSize: 20),
                      ),*/
                    ],
                  ),
                ),
                Expanded(
                    child: ListView(
                  children: [
                    ListTile(
                      onTap: () {},
                      leading: const Icon(
                        Icons.home,
                        color: Colors.white,
                      ),
                      title: const Text(
                        "Home",
                        style: const TextStyle(color: Colors.white),
                      ),
                    ),
                    ListTile(
                      onTap: () {
                        Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(
                              builder: (context) => CreatProfileDoc(),
                            ),
                            (route) => false);
                      },
                      leading: const Icon(
                        Icons.person,
                        color: Colors.white,
                      ),
                      title: const Text(
                        "Profile",
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                    ListTile(
                      onTap: logout,
                      leading: const Icon(
                        Icons.logout,
                        color: Colors.white,
                      ),
                      title: const Text(
                        "Logu out",
                        style: TextStyle(color: Colors.white),
                      ),
                    )
                  ],
                ))
              ],
            ),
          )),
          TweenAnimationBuilder(
              tween: Tween<double>(begin: 0, end: value),
              duration: const Duration(milliseconds: 500),
              curve: Curves.ease,
              builder: (_, double val, __) {
                return (Transform(
                  alignment: Alignment.center,
                  transform: Matrix4.identity()
                    ..setEntry(3, 2, 0.001)
                    ..setEntry(0, 3, 200 * val)
                    ..rotateY(pi / 6 * val),
                  child: page,
                ));
              }),
          _rightClick()
        ],
      ),
    );
  }

  Widget _rightClick() {
    return GestureDetector(
      onHorizontalDragUpdate: (e) {
        if ((e.delta.dx) - 15 > 0) {
          setState(() {
            value = 1;
          });
        } else {
          setState(() {
            value = 0;
          });
        }
      },
    );
  }
}
