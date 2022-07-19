import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:tabibiplanet/Rent_House/constants/constants.dart';
import 'package:flutter_animated_dialog/flutter_animated_dialog.dart';
import 'package:panara_dialogs/panara_dialogs.dart';
import 'package:tabibiplanet/Rent_House/model/house.dart';

import '../../../../NetworkHandler.dart';
import '../../../../pages/Navigation_Drawer.dart';

class CustomAppBar extends StatefulWidget {
  final House house;
  final schedule;
  CustomAppBar(this.house, this.schedule);
  @override
  State<CustomAppBar> createState() => _CustomAppBarState();
}

class _CustomAppBarState extends State<CustomAppBar> {
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    NetworkHandler networkHandler = NetworkHandler();
    bool isFav = true;

    return Padding(
      padding: const EdgeInsets.only(
        left: appPadding,
        right: appPadding,
        top: appPadding,
      ),
      child: Container(
        height: size.height * 0.1,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            InkWell(
              onTap: () {
                Navigator.pop(context);
              },
              child: Container(
                height: 50,
                width: 50,
                decoration: BoxDecoration(
                    border: Border.all(color: black.withOpacity(0.4)),
                    borderRadius: BorderRadius.circular(15)),
                child: Icon(
                  Icons.arrow_back_rounded,
                  color: black,
                ),
              ),
            ),
            Container(
              height: 50,
              width: 50,
              decoration: BoxDecoration(
                  border: Border.all(
                      color: black.withOpacity(0.4)), //white.withOpacity(0.4)
                  borderRadius: BorderRadius.circular(15)),
              child: IconButton(
                color: black,
                icon: const Icon(Icons.favorite_border_rounded),
                onPressed: () {
                  PanaraConfirmDialog.showAnimatedFromBottom(
                    context,
                    imagePath: "assets/conf.jpg",
                    title: "Hello",
                    message: "Please make sure before confirming.",
                    confirmButtonText: "Confirm",
                    cancelButtonText: "Cancel",
                    onTapCancel: () {
                      Navigator.pop(context);
                    },
                    onTapConfirm: () {
                      setState(() async {
                        Map<String, dynamic> data = {
                          'patient': widget.schedule['patient'],
                          'doctor': widget.schedule['doctor'],
                          'date': widget.schedule['date'],
                          'isFav': isFav,
                        };
                        Map<String, String> data1 = {
                          'patient': widget.schedule['patient'],
                          'doctor': widget.schedule['doctor'],
                          'date': widget.schedule['date'],
                          'time': widget.schedule['time'],
                          'type': widget.schedule['type'],
                          'idhome': widget.house.id,
                        };
                        Map<String, String> data2 = {
                          'rent': "yes",
                        };
                        var response = await networkHandler.patch1(
                            "/house/updateHouse/${widget.house.id}", data);
                        var response1 =
                            await networkHandler.post1("/rent/Rent/add", data1);
                        var response2 = await networkHandler.patch1(
                            "/appointment/updaterent/${widget.schedule['_id']}",
                            data2);
                        if (response.statusCode == 200 ||
                            response.statusCode == 201)
                          Navigator.pop(context); //didChangeDependencies();
                        print("Done");
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => NavPage(),
                          ),
                        );

                        PanaraInfoDialog.show(
                          context,
                          imagePath: "assets/congratulation.png",
                          title: "Congratulation",
                          message:
                              "You made a house reservation with a medical appointment.",
                          buttonText: "Okay",
                          onTapDismiss: () {
                            Navigator.pop(context);
                          },
                          panaraDialogType: PanaraDialogType.normal,
                          barrierDismissible:
                              false, // optional parameter (default is true)
                        );
                      });
                      Navigator.pop(context);
                    },
                    panaraDialogType: PanaraDialogType.success,
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
