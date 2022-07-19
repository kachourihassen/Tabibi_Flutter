import 'dart:convert';

import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:tabibiplanet/Login_Screens/LoginScreen.dart';
import 'package:tabibiplanet/Login_Screens/widgets/InputWidget.dart';
import 'package:tabibiplanet/Login_Screens/widgets/main_clipper.dart';
import 'package:tabibiplanet/NetworkHandler.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import '../data/Specialite.dart';
import '../main.dart';
import '../pages/Navigation_Drawer.dart';
import 'core/const.dart';

class RegisterScreen extends StatefulWidget {
  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  NetworkHandler networkHandler = NetworkHandler();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _phoneController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  TextEditingController _confpassController = TextEditingController();
  TextEditingController _fnController = TextEditingController();
  TextEditingController _lnController = TextEditingController();
  TextEditingController _addressController = TextEditingController();
  TextEditingController _aboutController = TextEditingController();

  Object? selectedItemcountry;
  String errorText = "";
  bool validate = false;
  bool circular = false;
  var width, height;
  final storage = new FlutterSecureStorage();

  final _globalkey = GlobalKey<FormState>();
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
                height: height * 0.36,
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
                child: Lottie.asset(
                  "assets/images/register.json",
                  width: width * 0.86,
                  height: height * 0.24,
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget _BuildForm(height) {
    return SingleChildScrollView(
      child: Container(
        color: AppColors.black,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 260),
          //padding: EdgeInsets.only(top: height * .39 - 60),
          child: Form(
            key: _globalkey,
            child: Column(children: <Widget>[
              Text(
                "Welcome To Register Page",
                style: TextStyle(
                  fontSize: 26,
                  color: Color.fromARGB(255, 239, 247, 247),
                  fontFamily: "WorkSansBold",
                ),
              ),
              SizedBox(
                height: 22,
              ),
              Row(
                children: [
                  Expanded(
                    child: InputWidgetall(
                      icon: Icons.person_outline,
                      placeholder: 'First name',
                      contr: _fnController,
                      errorText: errorText,
                      validate: validate,
                      msg: "First name can't be empty",
                    ),
                  ),
                  SizedBox(
                    width: 5,
                  ),
                  Expanded(
                    child: InputWidgetall(
                      icon: Icons.family_restroom_sharp,
                      placeholder: 'Last name',
                      contr: _lnController,
                      errorText: errorText,
                      validate: validate,
                      msg: "Last name can't be empty",
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 18,
              ),
              InputWidget(
                  icon: Icons.email,
                  placeholder: 'Email',
                  msg: "Email can't be empty",
                  contr: _emailController,
                  validate: validate,
                  errorText: errorText),
              SizedBox(
                height: 18,
              ),
              InputWidgetall(
                icon: Icons.location_on_outlined,
                placeholder: 'Address',
                contr: _addressController,
                errorText: errorText,
                validate: validate,
                msg: "Address can't be empty",
              ),
              SizedBox(
                height: 18,
              ),
              Row(
                children: [
                  Expanded(
                    flex: 1,
                    child: Container(
                      color: Colors.white,
                      child: DropdownSearch<String>(
                        validator: (v) => v == null ? "required field" : null,
                        mode: Mode.MENU,
                        dropdownSearchDecoration: InputDecoration(
                          hintText: "Select a country",
                          filled: true,
                          border: UnderlineInputBorder(
                            borderSide: BorderSide(color: Color(0xFF01689A)),
                          ),
                        ),
                        showAsSuffixIcons: true,
                        clearButtonBuilder: (_) => Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: const Icon(
                            Icons.clear,
                            size: 24,
                            color: Colors.black,
                          ),
                        ),
                        dropdownButtonBuilder: (_) => Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: const Icon(
                            Icons.arrow_drop_down,
                            size: 24,
                            color: Colors.black,
                          ),
                        ),
                        showSelectedItems: true,
                        items: countrys,
                        showClearButton: true,
                        popupItemDisabled: (String? s) =>
                            s?.startsWith('I') ?? true,
                        selectedItem: "Oman",
                        onChanged: (Object? data) {
                          print(data);
                          selectedItemcountry = data;
                        },
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 5,
                  ),
                  Expanded(
                    child: InputWidgetNumber(
                      icon: Icons.phone,
                      placeholder: 'Phone Number',
                      contr: _phoneController,
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 18,
              ),
              Container(
                decoration: BoxDecoration(
                    color: AppColors.lightblack,
                    borderRadius: BorderRadius.all(Radius.circular(5))),
                height: 120,
                child: Row(children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Icon(
                      Icons.description,
                      color: AppColors.white.withAlpha(75),
                    ),
                  ),
                  Container(
                    width: 1,
                    height: double.infinity,
                    color: AppColors.black,
                  ),
                  Expanded(
                      child: Theme(
                    data: Theme.of(context).copyWith(splashColor: Colors.red),
                    child: TextFormField(
                      controller: _aboutController,
                      validator: (value) {
                        if (value!.isEmpty) return "About can't be empty";

                        return null;
                      },
                      maxLines: 4,
                      decoration: InputDecoration(
                        focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                          color: Colors.orange,
                          width: 2,
                        )),
                        labelStyle: TextStyle(
                          color: AppColors.white.withAlpha(75),
                        ),
                        hintStyle: TextStyle(
                          color: AppColors.blue.withAlpha(75),
                        ),
                        labelText: "About",
                        hintText: "I am Mrs/Mm...",
                        fillColor: Colors.transparent,
                      ),
                    ),
                  ))
                ]),
              ),
              SizedBox(
                height: 18,
              ),
              InputWidgetPassword(
                icon: Icons.lock,
                placeholder: 'Password',
                secret: false,
                msg: "Password can't be empty",
                contr: _passwordController,
              ),
              SizedBox(
                height: 5,
              ),
              SizedBox(
                height: 12,
              ),
              Row(
                children: <Widget>[
                  Expanded(
                    child: circular
                        ? CircularProgressIndicator()
                        : MaterialButton(
                            onPressed: () {},
                            color: AppColors.darkblack,
                            height: 50,
                            shape: RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(5))),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                GestureDetector(
                                  onTap: () async {
                                    setState(() {
                                      //circular = true;
                                    });

                                    //networkHandler.get("");
                                    await checkUseremail();
                                    if (_globalkey.currentState!.validate() &&
                                        validate) {
                                      //_globalkey.currentState!.save();
                                      await networkHandler.get("");
                                      setState(() {
                                        circular = false;
                                      });
                                      Map<String, String> data = {
                                        "first_name": _fnController.text,
                                        "last_name": _lnController.text,
                                        "password": _passwordController.text,
                                        "email": _emailController.text,
                                        "address": _addressController.text,
                                        "address_x": " ",
                                        "address_y": " ",
                                        "pays": selectedItemcountry.toString(),
                                        "phone": _phoneController.text,
                                        "year": " ",
                                        "speciality": "",
                                        "role": "patient",
                                        "about": _aboutController.text
                                      };
                                      await networkHandler.post1(
                                          "/user/register", data);
                                      Map<String, dynamic> data1 = {
                                        "email": _emailController.text,
                                        "password": _passwordController.text,
                                      };
                                      var response = await networkHandler.post1(
                                          "/user/login", data1);

                                      if (response.statusCode == 200 ||
                                          response.statusCode == 201) {
                                        Map<String, dynamic> output =
                                            json.decode(response.body);

                                        print(output["token"]);
                                        await storage.write(
                                            key: "token",
                                            value: output["token"]);

                                        setState(() {
                                          validate = true;
                                          circular = false;
                                        });
                                        Navigator.pushAndRemoveUntil(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) =>
                                                  MyHomePage(),
                                            ),
                                            (route) => false);
                                      }
                                    } else {
                                      Scaffold.of(context).showSnackBar(
                                          SnackBar(
                                              content: Text("Network Error")));
                                      setState(() {
                                        circular = false;
                                      });
                                    }
                                  },
                                  child: Text(
                                    "Sign Up",
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
                      onPressed: () {},
                      height: 50,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(5)),
                      ),
                      child: Container(
                        child: GestureDetector(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (_) => LoginScreen()));
                          },
                          child: Text(
                            "Go To Login Page",
                            style: TextStyle(
                              color: AppColors.white.withAlpha(75),
                              fontFamily: FontWeight.normal.toString(),
                            ),
                          ),
                        ),
                      ),
                    ),
                  )
                ],
              ),
              /*SizedBox(
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
                      padding: const EdgeInsets.all(15.0),
                      child: Text(
                        "Go To Medical Staff",
                        style: TextStyle(fontSize: 20, color: AppColors.white),
                      ),
                    ),
                  ),
                ),
              ),*/
            ]),
          ),
        ),
      ),
    );
  }

  checkUseremail() async {
    if (_emailController.text.length == 0) {
      setState(() {
        //circular = false;
        validate = false;
        errorText = "Email can't be empty";
      });
    } else {
      var response =
          await networkHandler.get("/user/checkemail/${_emailController.text}");
      if (response['Status']) {
        setState(() {
          //circular = false;
          validate = false;
          errorText = "Email already exist";
        });
      } else {
        setState(() {
          //circular = false;
          validate = true;
        });
      }
    }
  }
}
