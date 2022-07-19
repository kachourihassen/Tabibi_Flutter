import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:panara_dialogs/panara_dialogs.dart';
import 'package:tabibiplanet/styles/colors.dart';
import 'package:tabibiplanet/styles/styles.dart';
import '../NetworkHandler.dart';
import '../Rent_House/screens/home/home_screen.dart';
import '../data/ModelProfil/profileModel.dart';
import 'package:new_im_animations/im_animations.dart';
import 'package:new_im_animations/main.dart';

class ScheduleTab extends StatefulWidget {
  const ScheduleTab({Key? key}) : super(key: key);

  @override
  State<ScheduleTab> createState() => _ScheduleTabState();
}

enum FilterStatus { Upcoming, Complete, Cancel }

class _ScheduleTabState extends State<ScheduleTab> {
  String stat = "Upcoming";
  FilterStatus status = FilterStatus.Upcoming;
  Alignment _alignment = Alignment.centerLeft;
  NetworkHandler networkHandler = NetworkHandler();
  ProfileModel profileModel = ProfileModel();

  var data = [];
  var searchModelsData = [];

  void initState() {
    super.initState();
    fetchProfilData();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    setState(() {
      shearchdata();
    });
  }

  void fetchProfilData() async {
    var response = await networkHandler.get("/user/profile/getData");
    setState(() {
      profileModel = ProfileModel.fromJson(response["data"]);
    });
    shearchdata();
  }

  shearchdata() async {
    var response = await networkHandler
        .get1("/appointment/listappPat/${profileModel.email}");
    setState(() {
      data = (response["data"]);
      searchModelsData = (response["data"]);
    });
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    List<dynamic> filteredSchedules = data.where((var schedule) {
      return schedule['type'] == stat;
    }).toList();

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(left: 30, top: 30, right: 30),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            AppBar(
              backgroundColor: Colors.transparent,
              elevation: 0,
              title: Text(
                "Schedule",
                textAlign: TextAlign.center,
                style:
                    TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
              ),
            ),
            /*Text(
              'Schedule',
              textAlign: TextAlign.center,
              style: kTitleStyle,
            ),*/
            SizedBox(
              height: 20,
            ),
            Stack(
              children: [
                Container(
                  width: double.infinity,
                  height: 40,
                  decoration: BoxDecoration(
                    color: Color(MyColors.bg),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      for (FilterStatus filterStatus in FilterStatus.values)
                        Expanded(
                          child: GestureDetector(
                            onTap: () {
                              setState(() {
                                if (filterStatus == FilterStatus.Upcoming) {
                                  status = FilterStatus.Upcoming;
                                  stat = "Upcoming";
                                  _alignment = Alignment.centerLeft;
                                } else if (filterStatus ==
                                    FilterStatus.Complete) {
                                  status = FilterStatus.Complete;
                                  stat = "Complete";
                                  _alignment = Alignment.center;
                                } else if (filterStatus ==
                                    FilterStatus.Cancel) {
                                  status = FilterStatus.Cancel;
                                  stat = "Cancel";
                                  _alignment = Alignment.centerRight;
                                }
                              });
                            },
                            child: Center(
                              child: Text(
                                filterStatus.name,
                                style: kFilterStyle,
                              ),
                            ),
                          ),
                        ),
                    ],
                  ),
                ),
                AnimatedAlign(
                  duration: Duration(milliseconds: 200),
                  alignment: _alignment,
                  child: Container(
                    width: 100,
                    height: 40,
                    decoration: BoxDecoration(
                      color: Color(MyColors.primary),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Center(
                      child: Text(
                        status.name,
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                )
              ],
            ),
            SizedBox(
              height: 20,
            ),
            Expanded(
              child: ListView.builder(
                itemCount: filteredSchedules.length,
                itemBuilder: (context, index) {
                  var _schedule = filteredSchedules[index];
                  bool isLastElement = filteredSchedules.length + 1 == index;
                  return Card(
                    margin: !isLastElement
                        ? EdgeInsets.only(bottom: 20)
                        : EdgeInsets.zero,
                    child: Padding(
                      padding: EdgeInsets.all(15),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Row(
                            children: [
                              SizedBox(
                                height: 80,
                                width: 100,
                                child: ClipOval(
                                  child: CachedNetworkImage(
                                    imageUrl: NetworkHandler()
                                        .getImageurl((_schedule['doctor'])),
                                    placeholder: (context, url) => new Image(
                                      image: AssetImage('assets/original.gif'),
                                      fit: BoxFit.cover,
                                    ),
                                    errorWidget: (context, url, error) =>
                                        new Icon(null),
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    _schedule['doctor'],
                                    style: TextStyle(
                                      color: Color(MyColors.header01),
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  Text(
                                    _schedule['speciality'],
                                    style: TextStyle(
                                      color: Color(MyColors.grey02),
                                      fontSize: 12,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  Text(
                                    _schedule['pays'],
                                    style: TextStyle(
                                      color: Colors.blue.shade400,
                                      fontSize: 12,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(left: 90),
                                    child: ColorSonar(
                                        contentAreaRadius: 1.0,
                                        waveFall: 10.0,
                                        waveMotion: WaveMotion.synced,
                                        child: _schedule["rent"] == "not"
                                            ? new RawMaterialButton(
                                                onPressed: () {
                                                  Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                      builder: (context) =>
                                                          HomeScreen(
                                                              schedule:
                                                                  _schedule),
                                                    ),
                                                  );
                                                },
                                                child: new Text("Rental"),
                                                shape: new CircleBorder(),
                                                elevation: 2.0,
                                                fillColor: Colors.white,
                                                padding:
                                                    const EdgeInsets.all(15.0),
                                              )
                                            : new RawMaterialButton(
                                                onPressed: () {
                                                  PanaraInfoDialog.show(
                                                    context,
                                                    imagePath:
                                                        "assets/congratulation.png",
                                                    title: "Hello",
                                                    message:
                                                        "You have already been rented a house for this appointment",
                                                    buttonText: "Okay",
                                                    onTapDismiss: () {
                                                      Navigator.pop(context);
                                                    },
                                                    panaraDialogType:
                                                        PanaraDialogType.normal,
                                                    barrierDismissible:
                                                        false, // optional parameter (default is true)
                                                  );
                                                },
                                                child: new Text(
                                                  "Done",
                                                  style: TextStyle(
                                                    color:
                                                        Colors.green.shade400,
                                                    fontSize: 15,
                                                    fontWeight: FontWeight.w600,
                                                  ),
                                                ),
                                                shape: new CircleBorder(),
                                                elevation: 2.0,
                                                fillColor: Colors.white,
                                                padding:
                                                    const EdgeInsets.all(15.0),
                                              )),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          DateTimeCard(
                            date: _schedule['date'],
                            time: _schedule['time'],
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                child: stat == "Cancel"
                                    ? Container()
                                    : OutlinedButton(
                                        child: Text('Cancel'),
                                        onPressed: () {
                                          setState(() async {
                                            Map<String, String> data = {
                                              'type': "Cancel",
                                            };

                                            var response =
                                                await networkHandler.patch(
                                                    "/appointment/update/${_schedule['_id']}",
                                                    data);
                                            if (response.statusCode == 200 ||
                                                response.statusCode == 201)
                                              didChangeDependencies();
                                            print(
                                                "Your appointment are canceled");
                                          });
                                        }, //Complete
                                      ),
                              ),
                              SizedBox(
                                width: 20,
                              ),
                              Expanded(
                                child: stat == "Cancel"
                                    ? ElevatedButton(
                                        child: Text('Delete'),
                                        onPressed: () {
                                          setState(() async {
                                            Map<String, String> data = {
                                              'type': "Complete",
                                            };

                                            var response =
                                                await networkHandler.delete(
                                                    "/appointment/delete/app/${_schedule['_id']}");
                                            if (response.statusCode == 200 ||
                                                response.statusCode == 201)
                                              didChangeDependencies();
                                            print(
                                                "Your appointment are Deleted");
                                          });
                                        })
                                    : stat == "Complete"
                                        ? ElevatedButton(
                                            child: Text('Reschedule'),
                                            onPressed: () {
                                              setState(() async {
                                                Map<String, String> data = {
                                                  'type': "Upcoming",
                                                };

                                                var response =
                                                    await networkHandler.patch(
                                                        "/appointment/update/${_schedule['_id']}",
                                                        data);
                                                if (response.statusCode ==
                                                        200 ||
                                                    response.statusCode == 201)
                                                  didChangeDependencies();
                                                print(
                                                    "Your appointment are Upcoming");
                                              });
                                            })
                                        : ElevatedButton(
                                            child: Text('Reschedule'),
                                            onPressed: () {
                                              setState(() async {
                                                Map<String, String> data = {
                                                  'type': "Complete",
                                                };

                                                var response =
                                                    await networkHandler.patch(
                                                        "/appointment/update/${_schedule['_id']}",
                                                        data);
                                                if (response.statusCode ==
                                                        200 ||
                                                    response.statusCode == 201)
                                                  didChangeDependencies();
                                                print(
                                                    "Your appointment are Complete");
                                              });
                                            }),
                              )
                            ],
                          )
                        ],
                      ),
                    ),
                  );
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}

class DateTimeCard extends StatelessWidget {
  const DateTimeCard({Key? key, required this.date, required this.time})
      : super(key: key);
  final date;
  final time;
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Color(MyColors.bg03),
        borderRadius: BorderRadius.circular(10),
      ),
      width: double.infinity,
      padding: EdgeInsets.all(20),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Icon(
                Icons.calendar_today,
                color: Color(MyColors.primary),
                size: 15,
              ),
              SizedBox(
                width: 5,
              ),
              Text(
                date,
                style: TextStyle(
                  fontSize: 12,
                  color: Color(MyColors.primary),
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          Row(
            children: [
              Icon(
                Icons.access_alarm,
                color: Color(MyColors.primary),
                size: 17,
              ),
              SizedBox(
                width: 5,
              ),
              Text(
                '${time} ~ ',
                style: TextStyle(
                  color: Color(MyColors.primary),
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
