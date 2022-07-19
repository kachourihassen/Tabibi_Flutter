import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:tabibiplanet/Login_Screens/LoginScreen.dart';
import 'package:tabibiplanet/Login_Screens/widgets/InputWidget.dart';
import 'package:tabibiplanet/Login_Screens/widgets/main_clipper.dart';
import 'package:tabibiplanet/NetworkHandler.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:tabibiplanet/data/Specialite.dart';
import 'package:tabibiplanet/main.dart';
import '../data/Specialite.dart';
import '../pages/Navigation_Drawer.dart';
import 'core/const.dart';

class RegisterDocScreen extends StatefulWidget {
  RegisterDocScreen({Key? key}) : super(key: key);

  @override
  State<RegisterDocScreen> createState() => _RegisterDocScreenState();
}

class _RegisterDocScreenState extends State<RegisterDocScreen> {
  final _formKey = GlobalKey<FormState>();
  final _openDropDownProgKey = GlobalKey<DropdownSearchState<String>>();
  final _multiKey = GlobalKey<DropdownSearchState<String>>();
  final _userEditTextController = TextEditingController(text: 'Mrs');

  NetworkHandler networkHandler = NetworkHandler();
  TextEditingController _fnController = TextEditingController();
  TextEditingController _lnController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _phoneController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  TextEditingController _addressController = TextEditingController();
  TextEditingController _experController = TextEditingController();
  TextEditingController _aboutController = TextEditingController();
  Object? selectedItemUser;
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
              clipper: MainClipperRegisterDoc(),
              child: Container(
                height: height * 0.18,
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
                    Padding(
                      padding: const EdgeInsets.only(top: 18, left: 35),
                      child: Text(
                        "Welcome to Staff Medical",
                        style: TextStyle(
                          fontSize: 26,
                          color: Color.fromARGB(255, 239, 247, 247),
                          fontFamily: "WorkSansBold",
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget _BuildForm(height) {
    String dropdownvalue = "Select your Specialty";
    return SingleChildScrollView(
      child: Container(
        color: AppColors.black,
        child: Padding(
          //padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 100),
          padding: EdgeInsets.only(top: 120, bottom: (height / 0.1)),
          child: Form(
            key: _globalkey,
            child: Column(children: <Widget>[
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
                    child: Container(
                      color: Colors.white,
                      child: Row(
                        children: [
                          Expanded(
                            flex: 1,
                            child: DropdownSearch<String>(
                              validator: (v) =>
                                  v == null ? "required field" : null,
                              mode: Mode.MENU,
                              dropdownSearchDecoration: InputDecoration(
                                hintText: "Your country",
                                filled: true,
                                border: UnderlineInputBorder(
                                  borderSide:
                                      BorderSide(color: Color(0xFF01689A)),
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
                              //selectedItem: "Oman",
                              onChanged: (Object? data) {
                                print(data);
                                selectedItemcountry = data;
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 5,
                  ),
                  Expanded(
                    flex: 1,
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

              Row(
                children: [
                  Expanded(
                    flex: 2,
                    child: Container(
                      color: Colors.white,
                      child: DropdownSearch<String>(
                        mode: Mode.BOTTOM_SHEET,
                        items: items,
                        dropdownSearchDecoration: InputDecoration(
                          //labelText: "Speciality",
                          contentPadding: EdgeInsets.fromLTRB(12, 6, 0, 0),
                        ),
                        //onChanged: print,
                        onChanged: (Object? data) {
                          print(data);
                          selectedItemUser = data;
                        },
                        selectedItem: "Your speciality",

                        popupShape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(24),
                            topRight: Radius.circular(24),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Divider(),
                  Expanded(
                    flex: 2,
                    child: InputWidgetYear(
                      icon: Icons.timelapse_sharp,
                      placeholder: 'Experiences',
                      contr: _experController,
                    ),
                  ),
                ],
              ),
              //Divider(),
              SizedBox(
                height: 5,
              ),
              /*TextFormField(
                decoration: InputDecoration(
                  filled: true,
                  labelText: "About you ...",
                  fillColor: Color.fromARGB(255, 252, 251, 251),
            
                ),
                //controller: about,
                validator: (value) {
                  if (value!.isEmpty) return "About can't be empty";

                  return null;
                },
              ),*/
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
                height: 15,
              ),
              InputWidgetPassword(
                icon: Icons.lock,
                placeholder: 'Password',
                secret: false,
                msg: "Password can't be empty",
                contr: _passwordController,
              ),
              SizedBox(
                height: 18,
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
                                        "year": _experController.text,
                                        "speciality":
                                            selectedItemUser.toString(),
                                        "role": "doctor",
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
                                          content: Text('Network Error'),
                                        ),
                                      );
                                      /*Scaffold.of(context).showSnackBar(
                                          SnackBar(
                                              content: Text("Network Error")));*/
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
