import 'package:json_annotation/json_annotation.dart';

part 'SearchModels.g.dart';

@JsonSerializable()
class SearchModels {
  String first_name;
  String speciality;
  String email;

  SearchModels({
    this.first_name = "",
    this.speciality = "",
    this.email = "",
  });
  factory SearchModels.fromJson(Map<String, dynamic> json) =>
      _$SearchModelsFromJson(json);
  Map<String, dynamic> toJson() => _$SearchModelsToJson(this);
}
