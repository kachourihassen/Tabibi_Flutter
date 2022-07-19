// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'profileModel.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ProfileModel _$ProfileModelFromJson(Map<String, dynamic> json) => ProfileModel(
      first_name: json['first_name'] as String? ?? "",
      last_name: json['last_name'] as String? ?? "",
      email: json['email'] as String? ?? "",
      password: json['password'] as String? ?? "",
      address: json['address'] as String? ?? "",
      address_x: json['address_x'] as String? ?? "",
      address_y: json['address_y'] as String? ?? "",
      pays: json['pays'] as String? ?? "",
      phone: json['phone'] as String? ?? "",
      speciality: json['speciality'] as String? ?? "",
      year: json['year'] as String? ?? "",
      img: json['img'] as String? ?? "",
      role: json['role'] as String? ?? "",
      about: json['about'] as String? ?? "",
    );

Map<String, dynamic> _$ProfileModelToJson(ProfileModel instance) =>
    <String, dynamic>{
      'first_name': instance.first_name,
      'last_name': instance.last_name,
      'email': instance.email,
      'password': instance.password,
      'address': instance.address,
      'address_x': instance.address_x,
      'address_y': instance.address_y,
      'pays': instance.pays,
      'phone': instance.phone,
      'speciality': instance.speciality,
      'year': instance.year,
      'img': instance.img,
      'role': instance.role,
      'about': instance.about,
    };
