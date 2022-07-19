import 'package:bottom_navy_bar/bottom_navy_bar.dart';
import 'package:tabibiplanet/pages/account_page.dart';
import 'package:tabibiplanet/pages/chat_page.dart';
import 'package:tabibiplanet/theme/colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../Login_Screens/widgets/ShowProfile.dart';
import 'AI.dart';
import 'ScheduleTab.dart';
import 'doctor_page.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<Widget> _pages = [
    DoctorPageAi(),
    DoctorPage(),
    ChatPage(),
    ScheduleTab(),
    ShowProfile(),
  ];

  int _currentIndex = 0;
  PageController _pageController = new PageController(initialPage: 0);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SizedBox.expand(
          child: PageView(
              controller: _pageController,
              onPageChanged: (index) {
                setState(() => _currentIndex = index);
              },
              children: _pages),
        ),
        bottomNavigationBar: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                  topRight: Radius.circular(30), topLeft: Radius.circular(30)),
              boxShadow: [
                BoxShadow(
                    color: Colors.black38, spreadRadius: 0, blurRadius: 10),
              ],
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(30.0),
                topRight: Radius.circular(30.0),
              ),
              child: BottomNavyBar(
                //containerHeight: 70,
                //backgroundColor: Color.fromARGB(171, 255, 255, 255),
                showElevation: true,
                itemCornerRadius: 24,
                curve: Curves.easeIn,

                selectedIndex: _currentIndex,
                onItemSelected: (index) {
                  setState(() => _currentIndex = index);
                  _pageController.jumpToPage(index);
                },
                items: <BottomNavyBarItem>[
                  BottomNavyBarItem(
                      activeColor: Color.fromARGB(255, 24, 5, 202),
                      inactiveColor: Color.fromARGB(255, 24, 5, 202),
                      title: Text('Home'),
                      icon: Icon(Icons.home)),
                  BottomNavyBarItem(
                      activeColor: Color.fromARGB(255, 24, 5, 202),
                      inactiveColor: Color.fromARGB(255, 24, 5, 202),
                      title: Text('Doctor'),
                      icon: Icon(Icons.medical_services_rounded)),
                  BottomNavyBarItem(
                      activeColor: Color.fromARGB(255, 24, 5, 202),
                      inactiveColor: Color.fromARGB(255, 24, 5, 202),
                      title: Text('Chat'),
                      icon: Icon(CupertinoIcons.chat_bubble_2_fill)),
                  BottomNavyBarItem(
                      activeColor: Color.fromARGB(255, 24, 5, 202),
                      inactiveColor: Color.fromARGB(255, 24, 5, 202),
                      title: Text('Booking'),
                      icon: Icon(Icons.event_note_rounded)),
                  BottomNavyBarItem(
                      activeColor: Color.fromARGB(255, 24, 5, 202),
                      inactiveColor: Color.fromARGB(255, 24, 5, 202),
                      title: Text('Account'),
                      icon: Icon(Icons.manage_accounts_rounded)),
                ],
              ),
            )));
  }
}
