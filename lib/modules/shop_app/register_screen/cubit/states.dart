import 'package:todoapp/models/login_model.dart';

abstract class RegisterStates {}

class RegisterInitialStates extends RegisterStates {}

class RegisterLoadingStates extends RegisterStates {}
class RegisterSuccessStates extends RegisterStates {
  ShopLoginModel loginModel;

  RegisterSuccessStates(this.loginModel);
}
class RegisterErrorStates extends RegisterStates {
  String error;
  RegisterErrorStates(this.error);
}


class RegisterChangePasswordShowStates extends RegisterStates {}
