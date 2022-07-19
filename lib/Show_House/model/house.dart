import 'package:json_annotation/json_annotation.dart';

part 'houseModel.g.dart';

@JsonSerializable()
class House {
  String patient;
  String doctor;
  String date;
  String imageUrl;
  String address;
  String address_x;
  String address_y;
  String description;
  int price;
  int bedRooms;
  int bathRooms;
  double sqFeet;
  int garages;
  int time;
  List<dynamic> moreImagesUrl;
  bool isFav;

  House({
    this.patient = "",
    this.doctor = "",
    this.date = "",
    this.imageUrl = "",
    this.address = "",
    this.address_x = "",
    this.address_y = "",
    this.description = "",
    this.price = 0,
    this.bathRooms = 0,
    this.bedRooms = 0,
    this.sqFeet = 0,
    this.garages = 0,
    this.time = 0,
    this.moreImagesUrl = const [],
    this.isFav = false,
  });
  factory House.fromJson(Map<String, dynamic> json) => _$HouseFromJson(json);
  Map<String, dynamic> toJson() => _$HouseToJson(this);
}
