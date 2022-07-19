import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

class CarouselImages extends StatefulWidget {
  final List<String> imagesListUrl;

  CarouselImages(this.imagesListUrl);

  @override
  _CarouselImagesState createState() => _CarouselImagesState();
}

class _CarouselImagesState extends State<CarouselImages> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Container(
        height: size.height * 0.35,
        child: CarouselSlider.builder(
          options: CarouselOptions(
            height: 400.0,
            enableInfiniteScroll: true,
            reverse: false,
            autoPlay: true,
            autoPlayInterval: Duration(seconds: 3),
            autoPlayAnimationDuration: Duration(milliseconds: 800),
            autoPlayCurve: Curves.fastOutSlowIn,
            enlargeCenterPage: true,
            scrollDirection: Axis.horizontal,
          ),
          itemCount: widget.imagesListUrl.length,
          itemBuilder: (BuildContext context, int index, int realIndex) {
            return Image.asset(
              '${widget.imagesListUrl[index]}',
              fit: BoxFit.cover,
            );
          },
        ));
  }
}
