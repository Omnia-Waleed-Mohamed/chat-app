
import 'package:chat_app/constants.dart';

class Message {
  final String messages;

  Message(this.messages);


  factory Message.fromJson(jsonData){
    return Message(jsonData[kMessage]);
  }
}