import 'package:json_annotation/json_annotation.dart';

part 'profileModel.g.dart';

@JsonSerializable()
class ProfileModel {
  String first_name;
  String last_name;
  String email;
  String password;
  String address;
  String address_x;
  String address_y;
  String pays;
  String phone;
  String speciality;
  String year;
  String img;
  String role;
  String about;

  ProfileModel({
    this.first_name = "",
    this.last_name = "",
    this.email = "",
    this.password = "",
    this.address = "",
    this.address_x = "",
    this.address_y = "",
    this.pays = "",
    this.phone = "",
    this.speciality = "",
    this.year = "",
    this.img = "",
    this.role = "",
    this.about = "",
  });

  factory ProfileModel.fromJson(Map<String, dynamic> json) =>
      _$ProfileModelFromJson(json);
  Map<String, dynamic> toJson() => _$ProfileModelToJson(this);
}

/* awel 7aja nzed f 
dependencies:
  flutter:
    sdk: flutter
 json_annotation:
 


dev_dependencies:
  build_runner:
  json_serializable:

  w ba3zd f terminal

flutter pub run build_runner build 'tsna3li el profileModel.g.dart automatique'*/