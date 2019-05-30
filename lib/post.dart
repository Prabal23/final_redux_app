
import 'package:json_annotation/json_annotation.dart';

@JsonSerializable()
class Message{

  int id;
  String title;
  String body;
  bool isSelected = false;

  Message(this.id,this.title, this.body);

  factory Message.fromJson(Map <String, dynamic> json) => 
      //_$MessageFromJson(json);
      Message(json['id'] as int, json['title'] as String, json['body'] as String);

Message _$MessageFromJson(Map<String, dynamic> json) {
  return Message(json['id'] as int, json['title'] as String, json['body'] as String);
}

Map<String, dynamic> _$MessageToJson(Message instance) =>
    <String, dynamic>{'id': instance.id, 'title': instance.title, 'body': instance.body};
}

