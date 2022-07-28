import 'package:bloc/bloc.dart';
import 'package:chat_app_using_firebase/bloc/states.dart';
import 'package:chat_app_using_firebase/views/login/login_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

import '../model/message.dart';

class ChatAppCubit extends Cubit<ChatAppStates>
{
  ChatAppCubit( ) : super(ChatAppInitialState());

  static ChatAppCubit get(context) => BlocProvider.of(context);

   User? user;
  Stream? messageStream;
  MessageModel? messageModel;
  var ref = FirebaseFirestore.instance.collection("messages");
  String userEmail = FirebaseAuth.instance.currentUser!.email!;


  sendMessage(MessageModel messageModel)
  {
    emit(SendMessageLoadingState());
    ref.add(messageModel.toMap()).then((value)
    {
       print("------------------------");
      print(ref.id);
      print("------------------------");
      print(messageModel.text);
      print("------------------------");
      print(messageModel.sender);
      print("------------------------");
      print(messageModel.time);
      print("------------------------");

      emit(SendMessageSuccessState());
    }).catchError((error)
    {
      print("error in send message cubit ${error.toString()}");
      emit(SendMessageErrorState());
    });

  }

  receiveMessage()
  {
    emit(ReceiveMessageLoadingState());
   messageStream =ref.orderBy("time",descending: false).snapshots();
   emit(ReceiveMessageSuccessState());

  }

  deleteMessage()
  {

  }

  logOut(context)async
  {
    emit(LogoutLoadingState());
    await FirebaseAuth.instance.signOut().then((value)
    {
      Navigator.push(context, MaterialPageRoute(builder:(context)
      {
        return ChatAppLoginScreen();
      }));
      emit(LogoutSuccessState());
    }).catchError((error)
    {
      print("error in log out ${error.toString()}");
      emit(LogoutErrorState());
    });
  }






}