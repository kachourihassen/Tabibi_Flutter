// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_slider_indicator/flutter_slider_indicator.dart';
import 'package:lottie/lottie.dart';
import 'package:tabibiplanet/Login_Screens/LoginScreen.dart';
import 'package:tabibiplanet/Login_Screens/RegisterScreen.dart';
import 'package:tabibiplanet/Login_Screens/core/const.dart';
import 'package:tabibiplanet/Login_Screens/widgets/main_clipper_intro.dart';

import '../NetworkHandler.dart';
import '../pages/home.dart';
import 'Profile.dart';
import 'RegisterDocScreen.dart';

class IntroPage extends StatefulWidget {
  @override
  _IntroPageState createState() => _IntroPageState();
}

class _IntroPageState extends State<IntroPage> {
  final _controller = PageController();
  double _currentIndex = 0;
  var width, height;

  @override
  Widget build(BuildContext context) {
    width = MediaQuery.of(context).size.width;
    height = MediaQuery.of(context).size.height;
    _controller.addListener(() {
      setState(() {
        _currentIndex = _controller.page!;
      });
    });

    return Scaffold(
        body: Stack(children: <Widget>[
      Container(
        color: AppColors.black,
        child: Align(
          alignment: Alignment.bottomCenter,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.fromLTRB(50, 0, 50, 10),
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (_) => LoginScreen()),
                    );
                  },
                  child: const Text(
                    'Login Page',
                    style: TextStyle(
                        fontSize: 18,
                        color: AppColors.black,
                        fontFamily: 'WorkSansBold'),
                  ),
                  style: ElevatedButton.styleFrom(
                      primary: AppColors.white,
                      fixedSize: const Size(220, 40),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(50))),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(50, 0, 50, 10),
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => RegisterScreen()));
                  },
                  child: const Text(
                    'New to Tabibi ?',
                    style: TextStyle(
                        fontSize: 18,
                        color: AppColors.black,
                        fontFamily: 'WorkSansBold'),
                  ),
                  style: ElevatedButton.styleFrom(
                      primary: AppColors.white,
                      fixedSize: const Size(220, 40),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(50))),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(50, 0, 50, 10),
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (_) => RegisterDocScreen()));
                  },
                  child: const Text(
                    'Healthcare Staff',
                    style: TextStyle(
                        fontSize: 18,
                        color: AppColors.white,
                        fontFamily: 'WorkSansBold'),
                  ),
                  style: ElevatedButton.styleFrom(
                      primary: Color(0XFF295fc6).withAlpha(150),
                      fixedSize: const Size(220, 40),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(50))),
                ),
              ),
            ],
          ),
        ),
      ),
      Hero(
        tag: "main-clipper",
        child: ClipPath(
          clipper: MainClipperintro(),
          child: Material(
            child: PageView(controller: _controller, children: <Widget>[
              _buildContent("assets/images/medicine.json"),
              _buildContent("assets/images/doctor.json"),

              //_buildContent("assets/img/ic-login.png"),
              //_buildContent("assets/images/teammeet.png"),

              //_buildContent(),
              //_buildContent(),
            ]),
          ),
        ),
      ),
      Align(
          alignment: Alignment.bottomCenter,
          child: Padding(
            padding: const EdgeInsets.only(bottom: 210),
            child: SliderIndicator(
              length: 2,
              activeIndex: _currentIndex.round(),
              indicator: Container(
                width: 10,
                height: 10,
                margin: EdgeInsets.all(3),
                decoration: BoxDecoration(
                  border: Border.all(
                    color: AppColors.white,
                  ),
                  borderRadius: BorderRadius.all(
                    Radius.circular(10),
                  ),
                ),
              ),
              activeIndicator: Container(
                width: 10,
                height: 10,
                margin: EdgeInsets.all(3),
                decoration: BoxDecoration(
                  border: Border.all(
                    color: AppColors.white,
                  ),
                  color: AppColors.white,
                  borderRadius: BorderRadius.all(
                    Radius.circular(10),
                  ),
                ),
              ),
            ),
          ))
    ]));
  }

  Widget _buildContent(String x) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [AppColors.lightblue, AppColors.blue, AppColors.darkblue],
          begin: Alignment.topLeft,
          end: Alignment.centerRight,
        ),
      ),
      child: ListView(children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(top: 80),
          child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Lottie.asset(
                  '$x',
                  // width: width * .6,
                ),
                /*Image.asset(
                  "$x",
                  //width: width * .6,
                ),*/
              ]),
        ),
      ]),
    );
  }
}
