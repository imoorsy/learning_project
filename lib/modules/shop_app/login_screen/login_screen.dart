import 'package:buildcondition/buildcondition.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todoapp/layout/shop_layout/shop_layout.dart';
import 'package:todoapp/modules/shop_app/login_screen/cubit/cubit.dart';
import 'package:todoapp/modules/shop_app/login_screen/cubit/states.dart';
import 'package:todoapp/modules/shop_app/register_screen/shop_register_screen.dart';
import 'package:todoapp/shared/componants/componants.dart';
import 'package:todoapp/shared/network/local/cache_helper.dart';

class ShopLoginScreen extends StatelessWidget {
  var emailController = TextEditingController();
  var passwordController = TextEditingController();

  var formkey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => LoginCubit(),
      child: BlocConsumer<LoginCubit, LoginStates>(
        listener: (context, state) {
          if (state is LoginSuccessStates) {
            if (state.loginModel.status! == true &&
                state.loginModel.data != null) {
              showSnackBar(
                  context, state.loginModel.message, SnackState.SUCCESS);
              cacheHelper
                  .putDynamic(key: "token", value: state.loginModel.data!.token)
                  .then((value) {
                if (value!) {
                  navigateAndFinish(context, ShopLayout());
                }
              });
            } else if (state.loginModel.status! == false &&
                state.loginModel.data == null) {
              showSnackBar(context, state.loginModel.message, SnackState.ERROR);
            }
          } else if (state is LoginErrorStates) {
            showSnackBar(context, "تأكد من إتصال الانترنت", SnackState.ERROR);
          }
        },
        builder: (context, state) {
          LoginCubit cubit = LoginCubit.get(context);
          return Scaffold(
            appBar: AppBar(
              elevation: 0,
              backgroundColor: Colors.transparent,
            ),
            body: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Center(
                child: SingleChildScrollView(
                  child: Form(
                    key: formkey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          'LOGIN',
                          style: TextStyle(
                            color: Colors.amber,
                            fontSize: 60,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        defaultTextFormField(context,
                            controller: emailController,
                            keyboardtype: TextInputType.emailAddress,
                            validator: (value) {
                          if (value.isEmpty) {
                            return 'Please enter your email';
                          } else if (!RegExp(
                                  r'^[\w-\.]+@([\w-\.]+\.)+[\w]{2,4}')
                              .hasMatch(value!)) {
                            return 'Email Should be like salla@example.com \n Email can\'t contain * / - + % # \$ !';
                          }
                          return null;
                        },
                            prefix: Icons.email_outlined,
                            labelText: 'Email Address ...'),
                        SizedBox(
                          height: 15,
                        ),
                        defaultTextFormField(context,
                            controller: passwordController,
                            keyboardtype: TextInputType.visiblePassword,
                            labelText: 'Password...',
                            onchange: (String value) {},
                            validator: (value) {
                              if (value == null || value!.isEmpty) {
                                return 'password can\'t be empty.';
                              }
                              return null;
                            },
                            prefix: Icons.lock_outline,
                            isPassword: cubit.isPassword,
                            suflix: cubit.suflixIcon,
                            suflixpressed: () {
                              cubit.changePasswordShow();
                            }),
                        SizedBox(
                          height: 20,
                        ),
                        BuildCondition(
                          condition: state is! LoginLoadingStates,
                          builder: (context) => defultButton(
                              pressfunction: () {
                                if (formkey.currentState!.validate()) {
                                  cubit.userLogin(context,
                                      email: emailController.text,
                                      password: passwordController.text);
                                }
                              },
                              text: 'login'),
                          fallback: (context) =>
                              const Center(child: CircularProgressIndicator()),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text('Don\'t have an account'),
                            TextButton(
                                onPressed: () {
                                  navigatorGoto(context, ShopRegisterScreen());
                                },
                                child: Text('Register Now !')),
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
