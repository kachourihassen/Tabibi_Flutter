// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'house.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

House _$HouseFromJson(Map<String, dynamic> json) => House(
      id: json['_id'] as String? ?? "",
      patient: json['patient'] as String? ?? "",
      doctor: json['doctor'] as String? ?? "",
      date: json['date'] as String? ?? "",
      imageUrl: json['imageUrl'] as String? ?? "",
      address: json['address'] as String? ?? "",
      address_x: json['address_x'] as String? ?? "",
      address_y: json['address_y'] as String? ?? "",
      description: json['description'] as String? ?? "",
      price: json['price'],
      bedRooms: json['bedRooms'],
      bathRooms: json['bathRooms'],
      sqFeet: json['sqFeet'],
      garages: json['garages'],
      time: json['time'],
      moreImagesUrl: json['moreImagesUrl'],
      isFav: json['isFav'],
    );

Map<String, dynamic> _$HouseToJson(House instance) => <String, dynamic>{
      "_id": instance.id,
      "patient": instance.patient,
      "doctor": instance.doctor,
      "date": instance.date,
      "imageUrl": instance.imageUrl,
      "address": instance.address,
      "address_x": instance.address_x,
      "address_y": instance.address_y,
      "description": instance.description,
      "price": instance.price,
      "bedRooms": instance.bedRooms,
      "bathRooms": instance.bathRooms,
      "sqFeet": instance.sqFeet,
      "garages": instance.garages,
      "time": instance.time,
      "moreImagesUrl": instance.moreImagesUrl,
      "isFav": instance.isFav,
    };
