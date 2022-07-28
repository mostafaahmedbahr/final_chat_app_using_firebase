import 'package:chat_app_using_firebase/bloc/cubit.dart';
import 'package:chat_app_using_firebase/bloc/states.dart';
import 'package:chat_app_using_firebase/core/utils/nav_bar.dart';
import 'package:chat_app_using_firebase/model/message.dart';
import 'package:chat_app_using_firebase/views/seetings.dart';
import 'package:chat_app_using_firebase/widgets/chat_list_view.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
class ChatScreen extends StatelessWidget {
    ChatScreen({Key? key}) : super(key: key);

  var messageCon = TextEditingController();
  var time = DateTime.now();
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ChatAppCubit,ChatAppStates>(
      listener: (context,state){},
      builder: (context,state)
      {
        var cubit = ChatAppCubit.get(context);
        return Scaffold(
          appBar: AppBar(
            title: const Text("Chat Home"),
            centerTitle: true,
            actions: [
              DropdownButton(
                underline: Container(),
                icon: const Icon(Icons.more_vert,
                  color: Colors.white,),
                items: [
                  DropdownMenuItem(
                    child: Row(
                      children: const [
                        Icon(Icons.exit_to_app,color: Colors.lightBlue,),
                        SizedBox(width: 8,),
                        Text("LogOut"),
                      ],
                    ),
                    value: "logOut",
                  ),
                  DropdownMenuItem(
                    child: Row(
                      children: const [
                        Icon(Icons.settings,color: Colors.lightBlue,),
                        SizedBox(width: 8,),
                        Text("Settings"),
                      ],
                    ),
                    value: "settings",
                  ),

                ],
                onChanged: (item)
                {
                  if(item=="settings")
                  {
                    AppNav.customNavigator(
                        context: context,
                        screen: const SettingsScreen(),
                        finish: false,
                    );
                  }
                  else if(item=="logOut")
                  {
                    cubit.logOut(context);
                  }
                  },

              ),
            ],
          ),
          body: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
               mainAxisAlignment: MainAxisAlignment.end,
              children: [
                cubit.messageStream==null ? const Text("There is not messages yet"):
                ChatList(
                  msgStream: cubit.messageStream,
                  // userMail: cubit.user.email,
                  userMail: cubit.userEmail,
                ),
                Row(
                  children: [
                    Expanded(
                      child: TextFormField(
                        style: const TextStyle(
                          color: Colors.black,
                        ),
                        controller: messageCon,
                        validator: (value)
                        {
                          if(value!.isEmpty)
                          {
                            return "message is empty";
                          }
                        },
                        decoration:   InputDecoration(
                          border:OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                          enabledBorder:    OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20),
                              borderSide: const BorderSide(
                                color: Colors.lightBlue,
                              )
                          ),
                          focusedBorder:     OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20),
                              borderSide: const BorderSide(
                                color: Colors.black,
                              )
                          ),
                          hintText: "Send Message",
                          hintStyle: const TextStyle(
                            color: Colors.lightBlue,
                          ),
                          prefixIcon:  IconButton(
                            onPressed: (){},
                            icon: const Icon(Icons.face),
                          )
                        ),
                      ),
                    ),
                    IconButton(
                      onPressed: (){
                      cubit.sendMessage(MessageModel(
                        sender:  cubit.userEmail,
                        text: messageCon.text,
                        time:  Timestamp.now(),
                      ));
                      messageCon.clear();
                      // عشان يغلق الكيبورد بعد ما ابعت الرسالة
                      FocusScope.of(context).unfocus();
                    },
                        icon: const Icon(Icons.send,
                        color: Colors.lightBlue,
                        size: 40,),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },

    );
  }
}
