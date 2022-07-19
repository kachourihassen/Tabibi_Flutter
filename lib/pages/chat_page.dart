import 'package:badges/badges.dart';
import 'package:socket_io_client/socket_io_client.dart';
import 'package:tabibiplanet/theme/colors.dart';
import 'package:tabibiplanet/widgets/avatar_image.dart';
import 'package:tabibiplanet/widgets/chat_item.dart';
import 'package:tabibiplanet/widgets/textbox.dart';
import 'package:flutter/material.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;
import '../NetworkHandler.dart';
import '../data/ModelProfil/profileModel.dart';
import 'ChatBox.dart';

class ChatPage extends StatefulWidget {
  const ChatPage({Key? key}) : super(key: key);

  @override
  _ChatPageState createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  NetworkHandler networkHandler = NetworkHandler();
  var data = [];
  var searchModelsData = [];

  void initState() {
    super.initState();
    fetchroleData();
  }

  void fetchroleData() async {
    var response = await networkHandler.get("/user/role/chat/getData/doctor");

    setState(() {
      data = (response["data"]);
      searchModelsData = (response["data"]);
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
              Container(
                height: 40,
                decoration: BoxDecoration(
                    color: Colors.grey.shade300,
                    borderRadius: BorderRadius.circular(50)),
                child: TextField(
                  style: TextStyle(color: Colors.black),
                  decoration: InputDecoration(
                      prefixIcon: Icon(Icons.search, color: Colors.grey),
                      border: InputBorder.none,
                      hintText: "Search",
                      hintStyle: TextStyle(color: Colors.grey, fontSize: 17)),
                  onChanged: searchDoc,
                ),
              ),
              SizedBox(
                height: 40,
              ),
              getChatList(),
            ])));
  }

  void searchDoc(String query) {
    final suggestions = searchModelsData.where((data) {
      final searchTitle = data["first_name"].toLowerCase();
      final searchSpeciality = data["speciality"].toLowerCase();

      final input = query.toLowerCase();
      return searchTitle.contains(input) || searchSpeciality.contains(input);
    }).toList();
    setState(() => data = suggestions);
  }

  getChatList() {
    return Column(
        children: List.generate(data.length, (index) => ChatItem(data[index])));
  }
}
