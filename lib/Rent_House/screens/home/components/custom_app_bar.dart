import 'package:flutter/material.dart';
import 'package:tabibiplanet/Rent_House/constants/constants.dart';

import '../../../../pages/Navigation_Drawer.dart';

class CustomAppBar extends StatefulWidget {
  final schedule;

  const CustomAppBar({Key? key, required this.schedule}) : super(key: key);
  @override
  State<CustomAppBar> createState() => _CustomAppBarState();
}

class _CustomAppBarState extends State<CustomAppBar> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Padding(
      padding: const EdgeInsets.only(
        left: appPadding,
        right: appPadding,
        top: appPadding * 2,
      ),
      child: Container(
        height: size.height * 0.22,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                    /*Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(
                          builder: (context) => NavPage(),
                        ),
                        (route) => false);*/
                  },
                  child: Container(
                    height: 50,
                    width: 50,
                    decoration: BoxDecoration(
                        border: Border.all(color: black.withOpacity(0.4)),
                        borderRadius: BorderRadius.circular(15)),
                    child: Icon(Icons.arrow_back_rounded),
                  ),
                ),
              ],
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'City',
                  style: TextStyle(
                    color: black.withOpacity(0.4),
                    fontSize: 18,
                  ),
                ),
                SizedBox(
                  height: size.height * 0.01,
                ),
                Text(
                  widget.schedule['pays'],
                  style: TextStyle(
                      color: black, fontSize: 36, fontWeight: FontWeight.bold),
                ),
              ],
            ),
            Divider(),
          ],
        ),
      ),
    );
  }
}
