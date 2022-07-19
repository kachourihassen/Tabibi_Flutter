// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'SearchModels.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SearchModels _$SearchModelsFromJson(Map<String, dynamic> json) => SearchModels(
      first_name: json['first_name'] as String? ?? "",
      speciality: json['speciality'] as String? ?? "",
      email: json['email'] as String? ?? "",
    );

Map<String, dynamic> _$SearchModelsToJson(SearchModels instance) =>
    <String, dynamic>{
      'first_name': instance.first_name,
      'speciality': instance.speciality,
      'email': instance.email,
    };
