import 'package:flutter/material.dart';
import 'package:tabibiplanet/Show_House/constants/constants.dart';

class CustomAppBar extends StatelessWidget {
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
                  'Tabibi',
                  style: TextStyle(
                    color: black.withOpacity(0.4),
                    fontSize: 18,
                  ),
                ),
                SizedBox(
                  height: size.height * 0.01,
                ),
                Text(
                  'My Rental List',
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
