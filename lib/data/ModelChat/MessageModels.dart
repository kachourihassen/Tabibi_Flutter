import 'package:json_annotation/json_annotation.dart';

@JsonSerializable()
class MessageModels {
  String type;
  String message;
  String time;

  MessageModels({
    this.type = "",
    this.message = "",
    this.time = "",
  });
}
