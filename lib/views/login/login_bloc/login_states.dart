abstract class ChatAppLoginStates{}

class ChatAppLoginInitialState extends ChatAppLoginStates{}

class ChatAppLoginLoadingState extends ChatAppLoginStates{}

class ChatAppLoginSuccessState extends ChatAppLoginStates{
  final success;
  ChatAppLoginSuccessState({required this.success});
}

class ChatAppLoginErrorState extends ChatAppLoginStates{
  final error;
  ChatAppLoginErrorState({required this.error});
}

class ChangePasswordIconState extends ChatAppLoginStates{}