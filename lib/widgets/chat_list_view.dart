import 'package:chat_app_using_firebase/bloc/cubit.dart';
import 'package:chat_app_using_firebase/bloc/states.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ChatList extends StatelessWidget {
  ChatList({Key? key, this.msgStream, this.userMail,    }) : super(key: key);
  final Stream? msgStream;
  final userMail;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ChatAppCubit,ChatAppStates>(
      listener: (context,state){},
      builder: (context,state)
      {
        var cubit = ChatAppCubit.get(context);
        print(cubit.userEmail);
        return StreamBuilder(
          stream: msgStream,
          builder: (context, snapShot) {
            if (snapShot.hasData) {
              // اهم سطر
              QuerySnapshot values = snapShot.data as QuerySnapshot;
              return Expanded(
                child: ListView.builder(
                  reverse: false,
                  physics: const BouncingScrollPhysics(),
                  itemCount: values.docs.length,
                  itemBuilder: (context, index) {
                    return Align(
                      alignment:  values.docs[index]['sender']==cubit.userEmail?
                      Alignment.centerRight : Alignment.centerLeft,
                      child: Padding(
                        padding: const EdgeInsets.all(3.0),
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 10,
                          ),
                          decoration: BoxDecoration(
                            color: values.docs[index]['sender']==cubit.userEmail?
                            Colors.green : Colors.redAccent,
                            borderRadius: const BorderRadius.only(
                              topRight: Radius.circular(10),
                              topLeft: Radius.circular(10),
                              bottomRight: Radius.circular(10),
                            ),
                          ),
                          child: Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  "${values.docs[index]['text']}",
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 20,
                                  ),
                                ),
                              ),
                              Text("${values.docs[index]['sender']==cubit.userEmail?
                              "":values.docs[index]['sender'] }",
                              style: TextStyle(
                                color: Colors.grey[800],
                              ),),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                ),
              );
            } else {
              const Text("Data is Empty");
            }
            return const Text("");
          },
        );
      },

    );
  }
}
