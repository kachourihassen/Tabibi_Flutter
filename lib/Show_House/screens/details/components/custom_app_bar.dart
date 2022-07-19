import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:tabibiplanet/Show_House/model/house.dart';
import 'package:tabibiplanet/Show_House/constants/constants.dart';

import '../../../../NetworkHandler.dart';
import '../../../../styles/colors.dart';

class CustomAppBar extends StatefulWidget {
  final House house;
  CustomAppBar(this.house);
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
                  border: Border.all(color: black.withOpacity(0.4)),
                  borderRadius: BorderRadius.circular(15)),
              child: IconButton(
                  color: Colors.black,
                  icon: Icon(Icons.info_outline),
                  onPressed: () {
                    showModalBottomSheet(
                      context: context,
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.vertical(
                          top: Radius.circular(25.0),
                        ),
                      ),
                      builder: (context) {
                        return SizedBox(
                            height: 100,
                            child: ListView(
                                shrinkWrap: true,
                                scrollDirection: Axis.vertical,
                                physics: ClampingScrollPhysics(),
                                children: [
                                  Row(
                                    children: [
                                      SizedBox(
                                        height: 80,
                                        width: 100,
                                        child: ClipOval(
                                          child: CachedNetworkImage(
                                            imageUrl: NetworkHandler()
                                                .getImageurl(
                                                    (widget.house.doctor)),
                                            placeholder: (context, url) =>
                                                new Image(
                                              image: AssetImage(
                                                  'assets/original.gif'),
                                              fit: BoxFit.cover,
                                            ),
                                            errorWidget:
                                                (context, url, error) =>
                                                    new Icon(null),
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        width: 10,
                                      ),
                                      Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              widget.house.doctor,
                                              style: TextStyle(
                                                color: Color(MyColors.header01),
                                                fontWeight: FontWeight.w700,
                                              ),
                                            ),
                                            SizedBox(
                                              height: 5,
                                            ),
                                            Text(
                                              widget.house.date,
                                              style: TextStyle(
                                                color: Color(MyColors.grey02),
                                                fontSize: 12,
                                                fontWeight: FontWeight.w600,
                                              ),
                                            ),
                                            Text(
                                              widget.house.address,
                                              style: TextStyle(
                                                color: Colors.blue.shade400,
                                                fontSize: 12,
                                                fontWeight: FontWeight.w600,
                                              ),
                                            ),
                                          ]),
                                    ],
                                  )
                                ]));
                      },
                    );
                  }),
            )
          ],
        ),
      ),
    );
  }
}
