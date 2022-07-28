abstract class ChatAppRegisterStates{}

class ChatAppRegisterInitialState extends ChatAppRegisterStates{}

class ChatAppRegisterLoadingState extends ChatAppRegisterStates{}

class ChatAppRegisterSuccessState extends ChatAppRegisterStates{
  final success;
  ChatAppRegisterSuccessState({required this.success});
}

class ChatAppRegisterErrorState extends ChatAppRegisterStates{
  final error;
  ChatAppRegisterErrorState({required this.error});

}

class ChangePasswordIconState extends ChatAppRegisterStates{}

class ChangePhoto extends ChatAppRegisterStates{}