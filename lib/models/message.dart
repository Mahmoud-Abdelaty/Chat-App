import 'package:scholar_chat/constant.dart';

class Message {
  final String message;
  final String id;
  final String hour;
  final String name;

  Message(
      this.message,
      this.id,
      this.hour,
      this.name
      );


  factory Message.fromJson(json)
  {
    return Message(json[kMessage] , json['id'], json['hour'], json['name']);
  }


}