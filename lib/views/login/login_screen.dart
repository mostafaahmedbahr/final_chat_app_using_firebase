import 'dart:ui';

 import 'package:chat_app_using_firebase/core/toast/toast.dart';
import 'package:chat_app_using_firebase/core/toast/toast_states.dart';
import 'package:chat_app_using_firebase/core/utils/nav_bar.dart';
import 'package:chat_app_using_firebase/views/chat/chat_screen.dart';
import 'package:chat_app_using_firebase/views/login/login_bloc/login_cubit.dart';
import 'package:chat_app_using_firebase/views/register/register_screen.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'login_bloc/login_states.dart';

class ChatAppLoginScreen extends StatelessWidget {
  var formKey = GlobalKey<FormState>();

  ChatAppLoginScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    var emailCon = TextEditingController();
    var passCon = TextEditingController();

    return BlocProvider(
      create: (BuildContext context) => ChatAppLoginCubit(),
      child: BlocConsumer<ChatAppLoginCubit,ChatAppLoginStates>(
        listener: (context, state) {
          if(state is ChatAppLoginSuccessState)
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
          if(state is ChatAppLoginErrorState)
          {
            ToastConfig.showToast(
                msg: "${state.error}",
              toastStates: ToastStates.Error,
            );
          }
        },
        builder: (context, state) {
          var cubit = ChatAppLoginCubit.get(context);
          return SafeArea(
            child: Scaffold(
              backgroundColor: Colors.white,
              body: Center(
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Form(
                      key: formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text("Our Chat App",
                            style: TextStyle(
                              fontSize: 40,
                              color: Colors.lightBlue,
                              fontWeight: FontWeight.bold,
                            ),),
                          const Text("Start Talking with your friends",
                            style: TextStyle(
                              fontSize: 20,
                              color: Colors.grey,
                            ),),
                          const SizedBox(
                            height: 30.0,
                          ),
                          TextFormField(
                            autocorrect: true,
                            enableSuggestions: true,
                            style: const TextStyle(
                              color: Colors.black,
                            ),
                            controller: emailCon,
                            validator: (value)
                            {
                              if(value!.isEmpty || !value.contains("@"))
                              {
                                return "email is already used";
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
                            condition: state is! ChatAppLoginLoadingState,
                            builder: (context)=> SizedBox(
                              width: double.infinity,
                              height: 50,
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  primary: Colors.lightBlue,
                                ),
                                onPressed: (){
                                  if(formKey.currentState!.validate())
                                  {
                                    cubit.login(
                                        emailCon.text,
                                        passCon.text,
                                    );
                                  }
                                },
                                child: const Text("LoGin",
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
                                Text("Don\'t have an account ?",
                                style: TextStyle(
                                  color: Colors.grey[600],
                                ),),
                              TextButton(
                                onPressed: (){
                                  Navigator.push(context,
                                    MaterialPageRoute(
                                      builder: (context)=>ChatAppRegisterScreen(),),);
                                },
                                child:const Text("Register",
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
            ),
          );
        },
      ),
    );
  }
}