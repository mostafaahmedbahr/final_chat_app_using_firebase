import 'package:cloud_firestore/cloud_firestore.dart';

class MessageModel
{
  String? sender;
  String? text;
  Timestamp? time;

  MessageModel({ this.text,this.time,this.sender});


  Map<String , dynamic> toMap()
  {
    return
      {
        "time":time,
        "sender":sender,
        "text":text,

      };
  }

}