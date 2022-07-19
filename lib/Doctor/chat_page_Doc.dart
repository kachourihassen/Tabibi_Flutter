import 'package:badges/badges.dart';
import 'package:tabibiplanet/theme/colors.dart';
import 'package:tabibiplanet/widgets/avatar_image.dart';
import 'package:tabibiplanet/widgets/chat_item.dart';
import 'package:tabibiplanet/widgets/textbox.dart';
import 'package:flutter/material.dart';

import '../NetworkHandler.dart';
import '../data/ModelProfil/profileModel.dart';
import '../pages/ChatBox.dart';

class ChatPageDoc extends StatefulWidget {
  const ChatPageDoc({Key? key}) : super(key: key);

  @override
  _ChatPageDocState createState() => _ChatPageDocState();
}

class _ChatPageDocState extends State<ChatPageDoc> {
  @override
  NetworkHandler networkHandler = NetworkHandler();
  var data = [];
  void initState() {
    super.initState();
    fetchroleData();
  }

  void fetchroleData() async {
    var response = await networkHandler.get("/user/role/chat/getData/patient");

    setState(() {
      data = (response["data"]);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: appBgColor,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text(
          "Chat Room",
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
        /*actions: [
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Icon(
              Icons.more_vert_outlined,
              color: Colors.black,
            ),
          )
        ],*/
      ),
      body: getBody(),
    );
  }

  getBody() {
    return SingleChildScrollView(
        child: Padding(
            padding: const EdgeInsets.only(left: 10, right: 10),
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              CustomTextBox(),
              SizedBox(
                height: 20,
              ),
              /*SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                //reverse: true,
                child: Row(
                    children: List.generate(
                        chatsData.length,
                        (index) => Padding(
                              padding: const EdgeInsets.only(right: 10),
                              child: Badge(
                                  badgeColor: Colors.green,
                                  borderSide: BorderSide(color: Colors.white),
                                  position:
                                      BadgePosition.topEnd(top: -3, end: 0),
                                  badgeContent: Text(''),
                                  child: AvatarImage(
                                      chatsData[index]["image"].toString())),
                            ))),
              ),*/
              SizedBox(
                height: 20,
              ),
              getChatList(),
            ])));
  }

  getChatList() {
    return Column(
      children: List.generate(
        data.length,
        (index) => ChatItem(data[index]),
      ),
    );
  }
}
