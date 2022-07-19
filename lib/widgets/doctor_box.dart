import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../NetworkHandler.dart';

class DoctorBox extends StatelessWidget {
  DoctorBox({Key? key, required this.index, this.doctor, required this.onTap})
      : super(key: key);
  final int index;
  final doctor;
  final GestureTapCallback onTap;

  @override
  Widget build(BuildContext context) {
    var img = NetworkHandler().getImage(doctor['email']);
    String url = doctor['email'];
    return GestureDetector(
      onTap: onTap,
      child: Container(
          margin: EdgeInsets.all(5),
          padding: EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.1),
                spreadRadius: 1,
                blurRadius: 1,
                offset: Offset(1, 1), // changes position of shadow
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: CachedNetworkImage(
                  placeholder: (context, url) => Container(
                    height: index.isEven ? 100 : 50,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                    ),
                    child: CircularProgressIndicator(),
                  ),
                  imageUrl: NetworkHandler().getImageurl(url), //
                  imageBuilder: (context, imageProvider) => Container(
                    height: index.isEven ? 100 : 50,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(20)),
                      image: DecorationImage(
                        image: imageProvider,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),

                  errorWidget: (context, url, error) => Container(
                    height: index.isEven ? 100 : 50,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                      image: DecorationImage(
                        image: AssetImage("assets/images1.png"),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 10),
              Text(
                doctor['first_name'],
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 3),
              Text(
                doctor["speciality"],
                style: TextStyle(color: Colors.grey, fontSize: 13),
              ),
              SizedBox(height: 3),
              Row(
                children: [
                  Icon(
                    Icons.star,
                    color: Colors.yellow,
                    size: 14,
                  ),
                  SizedBox(
                    width: 2,
                  ),
                  Text(
                    "${589} Review",
                    style: TextStyle(fontSize: 12),
                  )
                ],
              ),
              SizedBox(height: 3),
            ],
          )),
    );
  }
}
