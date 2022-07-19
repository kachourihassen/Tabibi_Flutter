import 'package:flutter/material.dart';
import 'package:tabibiplanet/Rent_House/screens/home/components/bottom_buttons.dart';
import 'package:tabibiplanet/Rent_House/screens/home/components/custom_app_bar.dart';

import 'components/houses.dart';

class HomeScreen extends StatefulWidget {
  final schedule;

  const HomeScreen({Key? key, required this.schedule}) : super(key: key);
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          Column(
            children: [
              CustomAppBar(schedule: widget.schedule),
              //Categories(),
              Houses(schedule: widget.schedule),
            ],
          ),
          //BottomButtons(schedule: widget.schedule),
        ],
      ),
    );
  }
}
