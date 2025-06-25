
import 'package:chat_app/constants.dart';

class Message {
  final String messages;
   final String senderId;

  Message(this.messages,this.senderId);


  factory Message.fromJson(jsonData){
    return Message(jsonData[kMessage],
      jsonData['senderId']);
  }
}