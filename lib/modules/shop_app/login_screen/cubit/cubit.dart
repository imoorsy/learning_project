import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todoapp/models/login_model.dart';
import 'package:todoapp/modules/shop_app/login_screen/cubit/states.dart';
import 'package:todoapp/shared/componants/constants.dart';
import 'package:todoapp/shared/componants/end_points.dart';
import 'package:todoapp/shared/network/remote/dio_helper.dart';

class LoginCubit extends Cubit<LoginStates> {
  LoginCubit() : super(LoginInitialStates());

  static LoginCubit get(context) => BlocProvider.of(context);

  IconData suflixIcon = Icons.visibility_outlined;

  bool isPassword = true;

  ShopLoginModel? loginMod;

  void userLogin(
    context, {
    required String email,
    required String password,
  }) {
    emit(LoginLoadingStates());
    DioHelper.postData(url: LOGIN, data: {
      'email': email,
      'password': password,
    }).then((value) {
      loginMod = ShopLoginModel.fromJson(value.data);
      token = loginMod!.data!.token!;
      emit(LoginSuccessStates(loginMod!));
    }).catchError((error) {
      emit(LoginErrorStates(error.toString()));
    });
  }

  void changePasswordShow(){
    isPassword = !isPassword;
    suflixIcon = isPassword ? Icons.visibility_outlined : Icons.visibility_off_outlined;
    emit(LoginChangePasswordShowStates());
  }
}
