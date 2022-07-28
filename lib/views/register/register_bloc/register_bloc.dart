 import 'dart:math';

import 'package:chat_app_using_firebase/views/register/register_bloc/register_states.dart';
import 'package:firebase_storage/firebase_storage.dart';
 import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
 import 'package:firebase_auth/firebase_auth.dart';
 import 'dart:io';
 import 'package:path/path.dart';

import 'package:image_picker/image_picker.dart';

 class ChatAppRegisterCubit extends Cubit<ChatAppRegisterStates>
{
  ChatAppRegisterCubit() : super(ChatAppRegisterInitialState());

  static ChatAppRegisterCubit get(context) => BlocProvider.of(context);

  bool isVisible = true;
  var formKey = GlobalKey<FormState>();


  changePasswordIcon()
  {
    isVisible = !isVisible;
    emit(ChangePasswordIconState());
  }


  register(String email,String password,String phone,String name,File imgProfile)async
  {
    emit(ChatAppRegisterLoadingState());

         FirebaseAuth.instance.createUserWithEmailAndPassword(
         email: email.trim(),
         password: password.trim(),
     ).then((value)
     {

       emit(ChatAppRegisterSuccessState(success: "Welcome to our app"));
     }).catchError((error)
     {

       print("errror in register cubit ${error.toString()}");
       emit(ChatAppRegisterErrorState(error: error));
     });
  }


  File? imageFile;
  final ImagePicker picker = ImagePicker();
  Reference? ref;

  void takePhoto(ImageSource source)async
  {
    final pickedFile2 = await picker.pickImage(
        source: source,imageQuality: 50,maxWidth: 150,maxHeight: 150,
    );
    imageFile = File(pickedFile2!.path);
    await ref?.putFile(imageFile!);

    emit(ChangePhoto());
  }

  bottomSheet(ctx)
  {
     return showModalBottomSheet(
       context: ctx,
       builder: (ctx)
       {
         return Container(
           padding: const EdgeInsets.all(20),
           height: 180,
           child: Column(
             crossAxisAlignment: CrossAxisAlignment.start,
             children: [
               const Text(
                 "Choose Profile Photo",
                 style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
               ),
               InkWell(
                 onTap: ()
                 {
                   takePhoto(ImageSource.gallery);
                   var rand = Random().nextInt(1000000);
                   var imageName = "$rand" +  "jpg";
                    ref = FirebaseStorage.instance.ref("images").child(imageName);
                   Navigator.of(ctx).pop();
                 },
                 child: Container(
                     width: double.infinity,
                     padding: const EdgeInsets.all(10),
                     child: Row(
                       children: const [
                         Icon(
                           Icons.photo_outlined,
                           size: 30,
                         ),
                         SizedBox(width: 20),
                         Text(
                           "From Gallery",
                           style: TextStyle(fontSize: 20),
                         )
                       ],
                     )),
               ),
               InkWell(
                 onTap: ()
                 {
                    var rand = Random().nextInt(1000000);
                   var imageName = "$rand" +  "jpg";
                   takePhoto(ImageSource.camera);
                   ref = FirebaseStorage.instance.ref("images").child(imageName);
                    Navigator.of(ctx).pop();
                 },
                 child: Container(
                     width: double.infinity,
                     padding: const EdgeInsets.all(10),
                     child: Row(
                       children: const [
                         Icon(
                           Icons.camera_alt,
                           size: 30,
                         ),
                         SizedBox(width: 20),
                         Text(
                           "From Camera",
                           style: TextStyle(fontSize: 20),
                         )
                       ],
                     )),
               ),

             ],
           ),
         );
       },
     );
  }









}