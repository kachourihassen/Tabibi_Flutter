import 'package:cached_network_image/cached_network_image.dart';
import 'package:emoji_picker_flutter/emoji_picker_flutter.dart';
import 'package:flutter/material.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;
import 'package:socket_io_client/socket_io_client.dart';
import 'package:tabibiplanet/pages/ReplayMessage.dart';
import 'package:tabibiplanet/theme/colors.dart';
import 'package:url_launcher/url_launcher.dart';
import '../NetworkHandler.dart';
import '../data/ModelChat/MessageModels.dart';
import '../data/ModelChat/MessageModels.dart';
import '../data/ModelProfil/profileModel.dart';
import 'OwnMessage.dart';

class ChatBox extends StatefulWidget {
  final data;
  String email;

  ChatBox(
    this.data,
    this.email,
  );
  @override
  State<ChatBox> createState() => _ChatBoxState();
}

class _ChatBoxState extends State<ChatBox> {
  late IO.Socket socket;
  bool sendButton = false;
  List<MessageModels> messages = [];
  ScrollController _scrolleController = ScrollController();
  NetworkHandler networkHandler = NetworkHandler();

  void initState() {
    super.initState();
    connect();
  }

  void connect() {
    socket = IO.io(
        'http://192.168.0.2:6000',
        OptionBuilder().setTransports(['websocket']) // for Flutter or Dart VM
            .build());
    socket.connect();
    socket.emit("signin", widget.email);
    socket.onConnect((data) {
      print("Connect");
      socket.on("message", (msg) {
        //print("message" + msg);
        setMessage("destination", msg["message"]);
        _scrolleController.animateTo(
            _scrolleController.position.maxScrollExtent,
            duration: Duration(milliseconds: 300),
            curve: Curves.easeOut);
      });
    });
    print(socket.connected);
    //socket.emit('test', 'Hello Hassen how are you');
  }

  void sendMessage(String message, String sourceEmail, String targetEmail) {
    setMessage("source", message);
    socket.emit("message", {
      "message": message,
      "sourceEmail": sourceEmail,
      "targetEmail": targetEmail,
    });
  }

  void setMessage(String type, String message) {
    MessageModels messageModel = MessageModels(
        type: type,
        message: message,
        time: DateTime.now().toString().substring(10, 16));
    print(messages);
    setState(() {
      setState(() {
        messages.add(messageModel);
      });
    });
  }

  final TextEditingController _controller = TextEditingController();
  bool emojiShowing = false;

  _onEmojiSelected(Emoji emoji) {
    _controller
      ..text += emoji.emoji
      ..selection = TextSelection.fromPosition(
          TextPosition(offset: _controller.text.length));
  }

  _onBackspacePressed() {
    _controller
      ..text = _controller.text.characters.skipLast(1).toString()
      ..selection = TextSelection.fromPosition(
          TextPosition(offset: _controller.text.length));
  }

  @override
  Widget build(BuildContext context) {
    var img = NetworkHandler().getImage(widget.data['email']);
    String url = widget.data['email'];

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leadingWidth: 70,
        titleSpacing: 0,
        leading: InkWell(
          onTap: () {
            Navigator.pop(context);
          },
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.arrow_back,
                size: 24,
              ),
              CachedNetworkImage(
                imageUrl: NetworkHandler().getImageurl(url),
                imageBuilder: (context, imageProvider) => Container(
                  height: 35,
                  width: 35,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                    image: DecorationImage(
                      image: img,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                placeholder: (context, url) => Container(
                  height: 35,
                  width: 35,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                    image: DecorationImage(
                      image: AssetImage("assets/doc.jpg"),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                errorWidget: (context, url, error) => Container(
                  height: 35,
                  width: 35,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                    image: DecorationImage(
                      image: AssetImage("assets/images1.png"),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
              /* CircleAvatar(
                radius: 20,
                backgroundColor: Colors.blueGrey,
              ),*/
            ],
          ),
        ),
        title: InkWell(
          onTap: (() {}),
          child: Container(
            margin: EdgeInsets.all(6),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.data["first_name"],
                  style: TextStyle(fontSize: 18.5, fontWeight: FontWeight.bold),
                ),
                Text(widget.data["last_name"])
              ],
            ),
          ),
        ),
        actions: [
          /*IconButton(
            icon: Icon(Icons.video_call_outlined),
            onPressed: () {},
          ),*/
          IconButton(
            icon: Icon(Icons.call),
            onPressed: () async {
              final _call = 'tel:${widget.data['phone']}';
              if (await canLaunch(_call)) {
                await launch(_call);
              }
            },
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
              child: Container(
            height: MediaQuery.of(context).size.height - 140,
            child: ListView.builder(
              shrinkWrap: true,
              controller: _scrolleController,
              itemCount: messages.length + 1,
              itemBuilder: (context, index) {
                if (index == messages.length) {
                  return Container(
                    height: 70,
                  );
                }
                if (messages[index].type == "source") {
                  return OwnMessage(
                    message: messages[index].message,
                    time: messages[index].time,
                  );
                } else {
                  return ReplayMessage(
                    message: messages[index].message,
                    time: messages[index].time,
                  );
                }
              },
              //shrinkWrap: true,
            ),
          )),
          Container(
              height: 66.0,
              color: Colors.blue,
              child: Row(
                children: [
                  Material(
                    color: Colors.transparent,
                    child: IconButton(
                      onPressed: () {
                        setState(() {
                          emojiShowing = !emojiShowing;
                        });
                      },
                      icon: const Icon(
                        Icons.emoji_emotions,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      child: TextFormField(
                          onChanged: (value) {
                            if (value.length > 0) {
                              setState(() {
                                sendButton = true;
                              });
                            } else {
                              sendButton = false;
                            }
                          },
                          controller: _controller,
                          style: const TextStyle(
                              fontSize: 20.0, color: Colors.black87),
                          decoration: InputDecoration(
                            hintText: 'Type a message',
                            filled: true,
                            fillColor: Colors.white,
                            contentPadding: const EdgeInsets.only(
                                left: 16.0, bottom: 8.0, top: 8.0, right: 16.0),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(50.0),
                            ),
                            suffixIcon: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                IconButton(
                                  icon: Icon(Icons.attach_file),
                                  onPressed: () {
                                    showModalBottomSheet(
                                        backgroundColor: Colors.transparent,
                                        context: context,
                                        builder: (builder) => buttomsheet());
                                  },
                                ),
                                IconButton(
                                  icon: Icon(Icons.camera),
                                  onPressed: () {},
                                ),
                              ],
                            ),
                          )),
                    ),
                  ),
                  Material(
                    color: Colors.transparent,
                    child: IconButton(
                        onPressed: () {
                          if (sendButton) {
                            _scrolleController.animateTo(
                                _scrolleController.position.maxScrollExtent,
                                duration: Duration(milliseconds: 300),
                                curve: Curves.easeOut);
                            sendMessage(_controller.text, widget.email,
                                widget.data["email"]);
                            _controller.clear();
                          }
                        },
                        icon: const Icon(
                          Icons.send,
                          color: Colors.white,
                        )),
                  )
                ],
              )),
          Offstage(
            offstage: !emojiShowing,
            child: SizedBox(
              height: 250,
              child: EmojiPicker(
                  onEmojiSelected: (Category category, Emoji emoji) {
                    _onEmojiSelected(emoji);
                  },
                  onBackspacePressed: _onBackspacePressed,
                  config: Config(
                      columns: 7,
                      verticalSpacing: 0,
                      horizontalSpacing: 0,
                      initCategory: Category.RECENT,
                      bgColor: const Color(0xFFF2F2F2),
                      indicatorColor: Colors.blue,
                      iconColor: Colors.grey,
                      iconColorSelected: Colors.blue,
                      progressIndicatorColor: Colors.blue,
                      backspaceColor: Colors.blue,
                      skinToneDialogBgColor: Colors.white,
                      skinToneIndicatorColor: Colors.grey,
                      enableSkinTones: true,
                      showRecentsTab: true,
                      recentsLimit: 28,
                      tabIndicatorAnimDuration: kTabScrollDuration,
                      categoryIcons: const CategoryIcons(),
                      buttonMode: ButtonMode.MATERIAL)),
            ),
          ),
        ],
      ),
    );
  }

  Widget buttomsheet() {
    return Container(
      height: 278,
      width: MediaQuery.of(context).size.width,
      child: Card(
        margin: EdgeInsets.symmetric(
          horizontal: 10,
          vertical: 20,
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  icon(Icons.insert_drive_file, Colors.indigo, "Document"),
                  SizedBox(
                    width: 40,
                  ),
                  icon(Icons.camera_alt, Colors.red, "Camera"),
                  SizedBox(
                    width: 40,
                  ),
                  icon(Icons.insert_photo, Colors.purple, "Gallery"),
                ],
              ),
              SizedBox(
                height: 30,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  icon(Icons.headset, Colors.yellow.shade800, "Audio"),
                  SizedBox(
                    width: 40,
                  ),
                  icon(Icons.location_on, Colors.teal.shade500, "Location"),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget icon(IconData iconData, Color color, String title) {
    return InkWell(
      onTap: (() {}),
      child: Column(
        children: [
          CircleAvatar(
            radius: 30,
            backgroundColor: color,
            child: Icon(
              iconData,
              size: 29,
              color: Colors.white,
            ),
          ),
          SizedBox(
            height: 5,
          ),
          Text(
            title,
            style: TextStyle(
              fontSize: 12,
            ),
          ),
        ],
      ),
    );
  }
}
