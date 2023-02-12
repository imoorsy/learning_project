import 'package:todoapp/models/login_model.dart';

abstract class LoginStates {}

class LoginInitialStates extends LoginStates {}

class LoginLoadingStates extends LoginStates {}
class LoginSuccessStates extends LoginStates {
  ShopLoginModel loginModel;

  LoginSuccessStates(this.loginModel);
}
class LoginErrorStates extends LoginStates {
  final String error;
  LoginErrorStates(this.error);
}


class LoginChangePasswordShowStates extends LoginStates {}
