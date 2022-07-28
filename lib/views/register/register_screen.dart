 import 'package:chat_app_using_firebase/views/chat/chat_screen.dart';
import 'package:chat_app_using_firebase/views/register/register_bloc/register_bloc.dart';
import 'package:chat_app_using_firebase/views/register/register_bloc/register_states.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
  import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
 import 'dart:io';

import '../../core/toast/toast.dart';
import '../../core/toast/toast_states.dart';
import '../../core/utils/nav_bar.dart';
import '../login/login_screen.dart';

 class ChatAppRegisterScreen extends StatelessWidget {
    ChatAppRegisterScreen({Key? key}) : super(key: key);
    var emailCon = TextEditingController();
    var passCon = TextEditingController();
    var nameCon = TextEditingController();
    var phoneCon = TextEditingController();
   @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context)=>ChatAppRegisterCubit(),
        child: BlocConsumer<ChatAppRegisterCubit,ChatAppRegisterStates>(
          listener: (context,state){
            if(state is ChatAppRegisterSuccessState)
            {
              AppNav.customNavigator(
                  context: context,
                  screen:   ChatScreen(),
                  finish: true,
              );
              ToastConfig.showToast(
                msg: "${state.success}",
                toastStates: ToastStates.Success,
              );
            }
            if(state is ChatAppRegisterErrorState)
            {
              ToastConfig.showToast(
                  msg: "${state.error}",
                toastStates: ToastStates.Error,
              );
            }
          },
            builder: (context,state)
            {
              var cubit = ChatAppRegisterCubit.get(context);
              return SafeArea(
                child: Scaffold(
                  backgroundColor: Colors.white,
                  body: SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Form(
                        key: cubit.formKey,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                           children: [
                             const SizedBox(
                               height: 30.0,
                             ),
                              Stack(
                                children: [
                                      CircleAvatar(
                                  radius: 60,
                                  backgroundColor: Colors.grey,
                                      backgroundImage:
                                      cubit.imageFile == null ?
                                      null :
                                      FileImage(cubit.imageFile!) as ImageProvider,
                             ),
                                  Positioned(
                                    top: 60,
                                    child: Container(
                                       decoration: BoxDecoration(
                                        color: Colors.lightBlue,
                                        borderRadius: BorderRadius.circular(50),
                                      ),
                                      child: IconButton(
                                        onPressed: () {
                                          cubit.bottomSheet(context);
                                        },
                                        icon: const Icon(Icons.camera_alt,
                                        size: 30,
                                        color: Colors.white,),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                             const SizedBox(
                               height: 15.0,
                             ),
                            const Text("Welcome To Our Chat App",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                              color: Colors.grey,
                            ),),
                             const SizedBox(
                               height: 20.0,
                             ),
                            TextFormField(
                              style: const TextStyle(
                                color: Colors.black,
                              ),
                              controller: nameCon,
                              validator: (value)
                              {
                                if(value!.isEmpty)
                                {
                                  return "Name is Already used";
                                }
                              },
                              decoration: const InputDecoration(
                                border:OutlineInputBorder(),
                                enabledBorder:  OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color: Colors.lightBlue,
                                    )
                                ),
                                focusedBorder:   OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color: Colors.black,
                                    )
                                ),
                                hintText: "Name",
                                hintStyle: TextStyle(
                                  color: Colors.lightBlue,
                                ),
                                prefixIcon: Icon(Icons.person,
                                  color: Colors.lightBlue,
                                ),
                              ),
                            ),
                             const SizedBox(
                               height: 15.0,
                             ),
                             TextFormField(
                               style: const TextStyle(
                                 color: Colors.black,
                               ),
                               controller: emailCon,
                               validator: (value)
                               {
                                 if(value!.isEmpty || !value.contains("@"))
                                 {
                                   return "Email is Already used";
                                 }
                               },
                               decoration: const InputDecoration(
                                 border:OutlineInputBorder(),
                                 enabledBorder:  OutlineInputBorder(
                                     borderSide: BorderSide(
                                       color: Colors.lightBlue,
                                     )
                                 ),
                                 focusedBorder:   OutlineInputBorder(
                                     borderSide: BorderSide(
                                       color: Colors.black,
                                     )
                                 ),
                                 hintText: "E-Mail",
                                 hintStyle: TextStyle(
                                   color: Colors.lightBlue,
                                 ),
                                 prefixIcon: Icon(Icons.email,
                                   color: Colors.lightBlue,
                                 ),
                               ),
                             ),
                             const SizedBox(
                               height: 15.0,
                             ),
                             TextFormField(
                               style: const TextStyle(
                                 color: Colors.black,
                               ),
                               controller: phoneCon,
                               validator: (value)
                               {
                                 if(value!.isEmpty)
                                 {
                                   return "Phone is Already used";
                                 }
                               },
                               decoration: const InputDecoration(
                                 border:OutlineInputBorder(),
                                 enabledBorder:  OutlineInputBorder(
                                     borderSide: BorderSide(
                                       color: Colors.lightBlue,
                                     )
                                 ),
                                 focusedBorder:   OutlineInputBorder(
                                     borderSide: BorderSide(
                                       color: Colors.black,
                                     )
                                 ),
                                 hintText: "Phone",
                                 hintStyle: TextStyle(
                                   color: Colors.lightBlue,
                                 ),
                                 prefixIcon: Icon(Icons.phone,
                                   color: Colors.lightBlue,
                                 ),
                               ),
                             ),
                            const SizedBox(
                              height: 15.0,
                            ),
                            TextFormField(
                              style: const TextStyle(
                                color: Colors.black,
                              ),
                              onFieldSubmitted: (value) {},
                              obscureText: cubit.isVisible,
                              controller: passCon,
                              validator: (value){
                                if(value!.isEmpty || value.length<6)
                                {
                                  return "Password is not correct";
                                }
                              },
                              decoration: InputDecoration(
                                border:const OutlineInputBorder(),
                                enabledBorder:const OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color: Colors.lightBlue,
                                    )
                                ),
                                focusedBorder: const OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color: Colors.black,
                                    )
                                ),
                                hintText: "Password",
                                hintStyle: const TextStyle(
                                  color: Colors.lightBlue,
                                ),
                                prefixIcon:const Icon(Icons.lock,
                                  color: Colors.lightBlue,
                                ),
                                suffixIcon: IconButton(
                                  color: Colors.lightBlue,
                                  icon:
                                  cubit.isVisible ?const Icon(Icons.visibility_off):
                                  const Icon(Icons.visibility),
                                  onPressed: (){
                                    cubit.changePasswordIcon();
                                  },
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 30.0,
                            ),
                            ConditionalBuilder(
                              condition: state is! ChatAppRegisterLoadingState,
                              builder: (context)=> SizedBox(
                                width: double.infinity,
                                height: 50,
                                child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    primary: Colors.lightBlue,
                                  ),
                                  onPressed: (){
                                    if(cubit.formKey.currentState!.validate()){
                                      cubit.register(
                                          emailCon.text,
                                          passCon.text,
                                          phoneCon.text,
                                          nameCon.text,
                                        cubit.imageFile!,
                                      );
                                    }

                                  },
                                  child: const Text("Register",
                                    style: TextStyle(
                                      fontFamily: "Blaka",
                                      fontSize: 30,
                                    ),),
                                ),
                              ),
                              fallback: (context)=>const Center(
                                child: CircularProgressIndicator(),
                              ),
                            ),
                            const SizedBox(
                              height: 15.0,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                  Text("Already have an account ? ",
                                  style: TextStyle(
                                    color: Colors.grey[600],
                                  ),),
                                TextButton(
                                  onPressed: (){
                                    Navigator.push(context,
                                      MaterialPageRoute(
                                        builder: (context)=>ChatAppLoginScreen(),),);
                                  },
                                  child:const Text("Login",
                                    style: TextStyle(
                                      color: Colors.lightBlue,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 30,
                                      fontFamily: "Blaka",
                                    ),),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              );
            },
             ),
    );
  }


}
