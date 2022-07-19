import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:tabibiplanet/data/ModelProfil/profileModel.dart';
import 'package:tabibiplanet/pages/home.dart';
import '../NetworkHandler.dart';
import 'package:animated_background/animated_background.dart';

import '../pages/Navigation_Drawer.dart';
import 'Navigation_Drawer_Doc.dart';

class CreatProfileDoc extends StatefulWidget {
  CreatProfileDoc({Key? key}) : super(key: key);

  @override
  _CreatProfileDocState createState() => _CreatProfileDocState();
}

class _CreatProfileDocState extends State<CreatProfileDoc>
    with TickerProviderStateMixin {
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

  bool circular = false;
  PickedFile? _imageFile;
  TextEditingController _fname = TextEditingController();
  TextEditingController _lname = TextEditingController();
  TextEditingController _address = TextEditingController();
  TextEditingController _address_x = TextEditingController();
  TextEditingController _address_y = TextEditingController();
  TextEditingController _phone = TextEditingController();
  TextEditingController _pays = TextEditingController();
  TextEditingController _about = TextEditingController();
  final ImagePicker _picker = ImagePicker();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios_new),
          onPressed: () {
            Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(
                  builder: (context) => NavPageDoc(),
                ),
                (route) => false);
          },
          color: Colors.black,
        ),
      ),
      body: AnimatedBackground(
        behaviour: RandomParticleBehaviour(
            options: const ParticleOptions(
                spawnMaxRadius: 10,
                spawnMinSpeed: 10.00,
                particleCount: 168,
                spawnMaxSpeed: 50,
                minOpacity: 0.3,
                spawnOpacity: 0.4,
                baseColor: Colors.blue)),
        /*behaviour: RacingLinesBehaviour(
          direction: LineDirection.Rtl,
          numLines: 150,
        ),*/
        vsync: this,
        child: SingleChildScrollView(
            child: Container(
                width: double.infinity,
                height: size.height,
                child: Stack(alignment: Alignment.center, children: <Widget>[
                  SizedBox(height: size.height * 0.05),
                  SizedBox(
                    height: 10,
                  ),
                  Form(
                    child: ListView(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 30),
                      children: <Widget>[
                        imageProfile(),
                        SizedBox(
                          height: 20,
                        ),
                        Row(
                          children: [
                            Expanded(
                              child: fnameTextField(),
                            ),
                            SizedBox(
                              width: 5,
                            ),
                            Expanded(
                              child: lnameTextField(),
                            )
                          ],
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        phoneTextField(),
                        SizedBox(
                          height: 20,
                        ),
                        addressTextField(),
                        SizedBox(
                          height: 20,
                        ),
                        Row(
                          children: [
                            Expanded(
                              child: altTextField(),
                            ),
                            SizedBox(
                              width: 5,
                            ),
                            Expanded(
                              child: latTextField(),
                            )
                          ],
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        aboutTextField(),
                        SizedBox(
                          height: 20,
                        ),
                        InkWell(
                          onTap: () async {
                            setState(() {
                              circular = true;
                            });

                            Map<String, String> data = {
                              'first_name': _fname.text,
                              'last_name': _lname.text,
                              'address': _address.text,
                              'address_x': _address_x.text,
                              'address_y': _address_y.text,
                              'pays': _pays.text,
                              'phone': _phone.text,
                              'about': _about.text,
                            };
                            File(_imageFile!.path);
                            var response = await networkHandler.patch(
                                "/user/updateuser/", data);
                            if (response.statusCode == 200 ||
                                response.statusCode == 201) {
                              if (_imageFile?.path != null) {
                                var imageResponse =
                                    await networkHandler.patchImage(
                                        "/user/add/image",
                                        _imageFile!.path); // File().toString()

                                print('# file path is ${_imageFile?.path} #');
                                if (imageResponse.statusCode == 200) {
                                  setState(() {
                                    circular = false;
                                  });
                                  Navigator.of(context).pushAndRemoveUntil(
                                      MaterialPageRoute(
                                          builder: (context) => NavPageDoc()),
                                      (route) => false);
                                }
                              } else {
                                setState(() {
                                  circular = false;
                                });
                                Navigator.of(context).pushAndRemoveUntil(
                                    MaterialPageRoute(
                                        builder: (context) => NavPageDoc()),
                                    (route) => false);
                              }
                            }
                          },
                          child: Center(
                            child: Container(
                              width: 200,
                              height: 50,
                              decoration: BoxDecoration(
                                color: Colors.teal,
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Center(
                                child: circular
                                    ? CircularProgressIndicator()
                                    : Text(
                                        "Submit",
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ]))),
      ),
    );
  }

  Widget imageProfile() {
    return Center(
      child: Stack(children: <Widget>[
        CircleAvatar(
          radius: 80.0,
          backgroundImage: _imageFile == null
              ? AssetImage("assets/images/imageoffer.jpg")
              : FileImage(File(_imageFile!.path)) as ImageProvider,
        ),
        Positioned(
          bottom: 20.0,
          right: 20.0,
          child: InkWell(
            onTap: () {
              showModalBottomSheet(
                context: context,
                builder: ((builder) => bottomSheet()),
              );
            },
            child: Icon(
              Icons.camera_alt,
              color: Colors.teal,
              size: 28.0,
            ),
          ),
        ),
      ]),
    );
  }

  Widget bottomSheet() {
    return Container(
      height: 100.0,
      width: MediaQuery.of(context).size.width,
      margin: EdgeInsets.symmetric(
        horizontal: 20,
        vertical: 20,
      ),
      child: Column(
        children: <Widget>[
          Text(
            "Choose Profile photo",
            style: TextStyle(
              fontSize: 20.0,
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Row(mainAxisAlignment: MainAxisAlignment.center, children: <Widget>[
            FlatButton.icon(
              icon: Icon(Icons.camera),
              onPressed: () {
                takePhoto(ImageSource.camera);
              },
              label: Text("Camera"),
            ),
            FlatButton.icon(
              icon: Icon(Icons.image),
              onPressed: () {
                takePhoto(ImageSource.gallery);
              },
              label: Text("Gallery"),
            ),
          ])
        ],
      ),
    );
  }

  void takePhoto(ImageSource source) async {
    final pickedFile = await _picker.getImage(
      source: source,
    );
    setState(() {
      _imageFile = pickedFile;
    });
  }

  Widget fnameTextField() {
    return Material(
        elevation: 20.0,
        shadowColor: Colors.black12,
        child: TextFormField(
          controller: _fname,
          decoration: InputDecoration(
            border: OutlineInputBorder(
                borderSide: BorderSide(
              color: Colors.teal,
            )),
            focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(
              color: Colors.orange,
              width: 2,
            )),
            prefixIcon: Icon(
              Icons.person,
              color: Colors.green,
            ),
            labelText: "First Name",
          ),
        ));
  }

  Widget lnameTextField() {
    return Material(
        elevation: 20.0,
        shadowColor: Colors.black12,
        child: TextFormField(
          controller: _lname,
          decoration: InputDecoration(
            border: OutlineInputBorder(
                borderSide: BorderSide(
              color: Colors.teal,
            )),
            focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(
              color: Colors.orange,
              width: 2,
            )),
            prefixIcon: Icon(
              Icons.family_restroom_sharp,
              color: Colors.green,
            ),
            labelText: "Last Name",
          ),
        ));
  }

  Widget phoneTextField() {
    return Material(
        elevation: 20.0,
        shadowColor: Colors.black12,
        child: TextFormField(
          controller: _phone,
          decoration: InputDecoration(
            border: OutlineInputBorder(
                borderSide: BorderSide(
              color: Colors.teal,
            )),
            focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(
              color: Colors.orange,
              width: 2,
            )),
            prefixIcon: Icon(
              Icons.phone,
              color: Colors.green,
            ),
            labelText: "Phone number ",
          ),
        ));
  }

  Widget addressTextField() {
    return Material(
        elevation: 20.0,
        shadowColor: Colors.black12,
        child: TextFormField(
          controller: _address,
          decoration: InputDecoration(
            border: OutlineInputBorder(
                borderSide: BorderSide(
              color: Colors.teal,
            )),
            focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(
              color: Colors.orange,
              width: 2,
            )),
            prefixIcon: Icon(
              Icons.location_on_outlined,
              color: Colors.green,
            ),
            labelText: "Address",
          ),
        ));
  }

  Widget altTextField() {
    return Material(
        elevation: 20.0,
        shadowColor: Colors.black12,
        child: TextFormField(
          controller: _address_x,
          decoration: InputDecoration(
            border: OutlineInputBorder(
                borderSide: BorderSide(
              color: Colors.teal,
            )),
            focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(
              color: Colors.orange,
              width: 2,
            )),
            prefixIcon: Icon(
              Icons.location_searching,
              color: Colors.green,
            ),
            labelText: "Altitude",
          ),
        ));
  }

  Widget latTextField() {
    return Material(
        elevation: 20.0,
        shadowColor: Colors.black12,
        child: TextFormField(
          controller: _address_y,
          decoration: InputDecoration(
            border: OutlineInputBorder(
                borderSide: BorderSide(
              color: Colors.teal,
            )),
            focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(
              color: Colors.orange,
              width: 2,
            )),
            prefixIcon: Icon(
              Icons.location_searching,
              color: Colors.green,
            ),
            labelText: "Latitude",
          ),
        ));
  }

  Widget aboutTextField() {
    return Material(
        elevation: 20.0,
        shadowColor: Colors.black12,
        child: TextFormField(
          controller: _about,
          maxLines: 4,
          decoration: InputDecoration(
            border: OutlineInputBorder(
                borderSide: BorderSide(
              color: Colors.teal,
            )),
            focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(
              color: Colors.orange,
              width: 2,
            )),
            labelText: "About",
          ),
        ));
  }
}
