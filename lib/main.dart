import 'package:chat_app_using_firebase/bloc/cubit.dart';
import 'package:chat_app_using_firebase/views/chat/chat_screen.dart';
import 'package:chat_app_using_firebase/views/login/login_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';


void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  final documentDirectory = await getApplicationDocumentsDirectory();
  Hive.init(documentDirectory.path);
  await Hive.openBox("myBox");
  // in ui
  var box = Hive.box('myBox');
  box.put('name', 'David');
  var name = box.get('name');
  print('Name: $name');
  await Firebase.initializeApp();
  // start of notifications
   FirebaseMessaging messaging = FirebaseMessaging.instance;
  NotificationSettings settings = await messaging.requestPermission(
    alert: true,
    announcement: false,
    badge: true,
    carPlay: false,
    criticalAlert: false,
    provisional: false,
    sound: true,
  );
  print('User granted permission: ${settings.authorizationStatus}');
  FirebaseMessaging.onMessage.listen((RemoteMessage message) {
    print('Got a message whilst in the foreground!');
    print('Message data: ${message.data}');

    if (message.notification != null) {
      print('Message also contained a notification: ${message.notification}');
    }
  });
  //////////////////////////////////////////////////
  // end of notifications
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return   BlocProvider(
      create: (context)=>ChatAppCubit()..receiveMessage(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        // عشان اشوف لو عمل تسجيل قبل كدا والداتا محفوظة ولا لم يتم التسجيل من قبل
        home:  StreamBuilder(
          stream: FirebaseAuth.instance.authStateChanges(),
          builder: (context,snapShot)
          {
            if(snapShot.hasData)
            {
              return ChatScreen();
            }
            else
            {
              return ChatAppLoginScreen();
            }
          },
        ),
      ),
    );
  }
}
