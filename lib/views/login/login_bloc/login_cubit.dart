 import 'package:chat_app_using_firebase/views/login/login_bloc/login_states.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ChatAppLoginCubit extends Cubit<ChatAppLoginStates>
{
  ChatAppLoginCubit() : super(ChatAppLoginInitialState());

  static ChatAppLoginCubit get(context) => BlocProvider.of(context);

  bool isVisible = true;

  changePasswordIcon()
  {
    isVisible = !isVisible;
    emit(ChangePasswordIconState());
  }

  login(String email,String password)async
  {
    emit(ChatAppLoginLoadingState());
    FirebaseAuth.instance.signInWithEmailAndPassword(
      // trim عشان لو ف فراغات يتلاشاها
        email: email.trim(),
        password: password.trim(),
    ).then((value)
    {
      print(FirebaseAuth.instance.currentUser?.email);
      print("----------------------------");
      print(FirebaseAuth.instance.currentUser?.phoneNumber);
      emit(ChatAppLoginSuccessState(success: "welcome to our app"));
    }).catchError((error)
    {
      print("error in login cubit ${error.toString()}");
      emit(ChatAppLoginErrorState(error: error));
    });
  }

}