import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:lottie/lottie.dart';
import 'package:tabibiplanet/Login_Screens/Otp.dart';
import 'package:tabibiplanet/Login_Screens/RegisterScreen.dart';
import 'package:tabibiplanet/Login_Screens/widgets/InputWidget.dart';
import 'package:tabibiplanet/Login_Screens/widgets/main_clipper.dart';
import 'package:tabibiplanet/NetworkHandler.dart';
//import 'package:tabibiplanet/pages/home.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import '../Doctor/Navigation_Drawer_Doc.dart';
import '../data/ModelProfil/profileModel.dart';
import '../pages/Navigation_Drawer.dart';
import 'core/const.dart';
import 'intro_page.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  Widget page = IntroPage();
  NetworkHandler networkHandler = NetworkHandler();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  String errorText = "";
  bool validate = false;
  bool circular = false;
  final storage = new FlutterSecureStorage();
  ProfileModel pro = ProfileModel();

  var width, height;

  @override
  Widget build(BuildContext context) {
    width = MediaQuery.of(context).size.width;
    height = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Stack(
        children: <Widget>[
          _BuildForm(height),
          Hero(
              tag: "main-clipper",
              child: ClipPath(
                clipper: MainClipper(),
                child: Container(
                  height: height * 0.58,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        AppColors.lightblue,
                        AppColors.blue,
                        AppColors.darkblue
                      ],
                      begin: Alignment.topLeft,
                      end: Alignment.centerRight,
                    ),
                  ),
                  alignment: Alignment.center,
                  child: ListView(
                    children: [
                      Image.asset(
                        "assets/img/ic-login.png",
                        //width: width * 1.02,
                      ),
                    ],
                  ),
                ),
              ))
        ],
      ),
    );
  }

  final textFieldFocusNode = FocusNode();
  bool _obscured = true;

  void _toggleObscured() {
    setState(() {
      _obscured = !_obscured;
      if (textFieldFocusNode.hasPrimaryFocus) return;
      textFieldFocusNode.canRequestFocus = false;
    });
  }

  Widget _BuildForm(height) {
    return SingleChildScrollView(
      child: Container(
        color: AppColors.black,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 122),
          child: Padding(
            padding: EdgeInsets.only(top: height * .44 - 60),
            child: Form(
              key: formKey,
              child: Column(children: <Widget>[
                Text(
                  "Login to your Account",
                  style: TextStyle(
                    fontSize: 26,
                    color: Color.fromARGB(255, 239, 247, 247),
                    fontFamily: "WorkSansBold",
                  ),
                ),
                SizedBox(
                  height: 24,
                ),
                InputWidget(
                  icon: Icons.email,
                  placeholder: 'Email',
                  msg: "Email can't be empty",
                  contr: _emailController,
                  validate: false,
                  errorText: "",
                ),
                SizedBox(
                  height: 24,
                ),
                Container(
                  decoration: BoxDecoration(
                      color: AppColors.lightblack,
                      borderRadius: BorderRadius.all(Radius.circular(5))),
                  height: 50,
                  child: Row(children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Icon(
                        Icons.lock_rounded,
                        color: AppColors.white.withAlpha(75),
                      ),
                    ),
                    Container(
                      width: 1,
                      height: double.infinity,
                      color: AppColors.black,
                    ),
                    Expanded(
                      child: TextFormField(
                        style: TextStyle(color: Colors.white),
                        controller: _passwordController,
                        keyboardType: TextInputType.visiblePassword,
                        obscureText: _obscured,
                        focusNode: textFieldFocusNode,
                        decoration: InputDecoration(
                          fillColor: AppColors.lightblack,
                          filled: true,
                          contentPadding:
                              EdgeInsets.symmetric(horizontal: 12.0),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.orange,
                              width: 2,
                            ),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          labelText: "Password",
                          labelStyle: TextStyle(
                            color: AppColors.white.withAlpha(75),
                          ),
                          hintStyle: TextStyle(
                            color: AppColors.blue.withAlpha(75),
                          ),
                          /*prefixIcon: Icon(
                            Icons.lock_rounded,
                            size: 24,
                            color: AppColors.white.withAlpha(75),
                          ),*/
                          suffixIcon: Padding(
                            padding: const EdgeInsets.fromLTRB(0, 0, 4, 0),
                            child: GestureDetector(
                              onTap: _toggleObscured,
                              child: Icon(
                                _obscured
                                    ? Icons.visibility_rounded
                                    : Icons.visibility_off_rounded,
                                size: 24,
                                color: AppColors.white.withAlpha(75),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ]),
                ),
                /*InputWidgetPassword(
                  icon: Icons.lock,
                  placeholder: 'Password',
                  secret: true,
                  msg: validate ? "" : errorText,
                  contr: _passwordController,
                ),*/
                SizedBox(
                  height: 12,
                ),
                Row(
                  children: <Widget>[
                    Expanded(
                      child: circular
                          ? CircularProgressIndicator()
                          : MaterialButton(
                              onPressed: () async {
                                setState(() {
                                  circular = true;
                                });
                                Map<String, dynamic> data = {
                                  "email": _emailController.text,
                                  "password": _passwordController.text,
                                };
                                var response = await networkHandler.post(
                                    "/user/login", data);
                                var email = _emailController.text;
                                var response1 =
                                    await networkHandler.get1("/user/$email");
                                setState(() {
                                  pro =
                                      ProfileModel.fromJson(response1["data"]);
                                });
                                print("######################");
                                print(pro.role);
                                print("######################");
                                if (response.statusCode == 200 ||
                                    response.statusCode == 201) {
                                  Map<String, dynamic> output =
                                      json.decode(response.body);

                                  print(output["token"]);
                                  await storage.write(
                                      key: "token", value: output["token"]);

                                  setState(() {
                                    validate = true;
                                    circular = false;
                                  });

                                  if (pro.role == 'patient') {
                                    setState(() {
                                      Navigator.pushAndRemoveUntil(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) => NavPage(),
                                          ),
                                          (route) => false);
                                    });
                                  } else {
                                    setState(() {
                                      Navigator.pushAndRemoveUntil(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) => NavPageDoc(),
                                          ),
                                          (route) => false);
                                    });
                                  }
                                } else {
                                  String output = json.decode(response.body);
                                  setState(() {
                                    validate = false;
                                    errorText = output;
                                    circular = false;
                                    ScaffoldMessenger.of(context).showSnackBar(
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
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        Text(
                                                          "Alert!",
                                                          style: TextStyle(
                                                              fontSize: 18,
                                                              color:
                                                                  Colors.white),
                                                        ),
                                                        const Spacer(),
                                                        Text(
                                                          '$errorText',
                                                          style: TextStyle(
                                                              fontSize: 16,
                                                              color:
                                                                  Colors.white),
                                                          maxLines: 2,
                                                          overflow: TextOverflow
                                                              .ellipsis,
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
                                                borderRadius:
                                                    const BorderRadius.only(
                                                  bottomLeft:
                                                      Radius.circular(20),
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
                                              child: Stack(
                                                  alignment: Alignment.center,
                                                  children: [
                                                    SvgPicture.asset(
                                                      "assets/fail.svg",
                                                      height: 40,
                                                    ),
                                                    /*Positioned(
                                                      top: 10,
                                                      child: SvgPicture.asset(
                                                        "assets/fail.svg",
                                                        height: 40,
                                                      ),
                                                    ),*/
                                                  ]),
                                            ),
                                          ],
                                        ),
                                        behavior: SnackBarBehavior.floating,
                                        backgroundColor: Colors.transparent,
                                        elevation: 0,
                                      ),
                                    );
                                  });
                                }
                              },
                              color: AppColors.darkblack,
                              height: 50,
                              shape: RoundedRectangleBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(5))),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  Container(
                                    color: AppColors.black,
                                    child: Text(
                                      "Sign In",
                                      style: TextStyle(color: AppColors.white),
                                    ),
                                  ),
                                  SizedBox(
                                    width: 32,
                                  ),
                                  Icon(
                                    Icons.arrow_forward,
                                    size: 12,
                                    color: AppColors.white,
                                  )
                                ],
                              ),
                            ),
                    ),
                    SizedBox(
                      width: 12,
                    ),
                    Expanded(
                      child: MaterialButton(
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => Otp(),
                              ));
                        },
                        height: 50,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(5)),
                        ),
                        child: Text(
                          "Forget Password?",
                          style: TextStyle(
                            color: AppColors.white.withAlpha(75),
                            fontFamily: FontWeight.normal.toString(),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 23,
                ),
                Container(
                  color: AppColors.black,
                  child: GestureDetector(
                    onTap: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (_) => RegisterScreen()));
                    },
                    child: Align(
                      alignment: Alignment.bottomCenter,
                      child: Padding(
                        padding: const EdgeInsets.all(18.0),
                        child: Text(
                          "Sign Up Page",
                          style:
                              TextStyle(fontSize: 20, color: AppColors.white),
                        ),
                      ),
                    ),
                  ),
                ),
              ]),
            ),
          ),
        ),
      ),
    );
  }
}
