import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:tabibiplanet/Doctor/Navigation_Drawer_Doc.dart';
import 'package:tabibiplanet/Login_Screens/intro_page.dart';
import 'package:tabibiplanet/NetworkHandler.dart';
import 'package:tabibiplanet/pages/Navigation_Drawer.dart';
import 'package:tabibiplanet/pages/home.dart';
import 'Splash_screen_tabibi/animation_screen.dart';
import 'data/ModelProfil/profileModel.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIOverlays([SystemUiOverlay.bottom]);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Tabibi  طبيبي ',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  Widget page = IntroPage();
  final storage = FlutterSecureStorage();
  NetworkHandler networkHandler = NetworkHandler();
  ProfileModel pro = ProfileModel();

  void initState() {
    super.initState();
    fetchProfilData();
  }

  void fetchProfilData() async {
    var response = await networkHandler.get("/user/profile/getData");
    setState(() {
      ProfileModel.fromJson(response["data"]) != null
          ? pro = ProfileModel.fromJson(response["data"])
          : [];
    });
    checkLogin();
  }

  void checkLogin() async {
    String? token = await storage.read(key: "token");

    print('# ######## #');
    print('# Role is ${pro.role} #');
    print('# ######## #');

    if (token != null) {
      pro.role == 'patient'
          ? setState(() {
              page = NavPage();
            })
          : setState(() {
              page = NavPageDoc();
            });
    } else {
      setState(() {
        page = IntroPage();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Material(
        child: Stack(children: <Widget>[
      // ignore: prefer_const_constructors
      Scaffold(
          /*appBar: AppBar(
            title: const Text('Tabibi App'),
          ),*/
          body: page), //IntroPage()),
      //SidebarPage  LoginScreen
      //body: WelcomePage()),
      IgnorePointer(child: AnimationScreen())
    ]));
  }
}
