import 'package:buildcondition/buildcondition.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todoapp/layout/shop_layout/shop_layout.dart';
import 'package:todoapp/modules/shop_app/login_screen/login_screen.dart';
import 'package:todoapp/modules/shop_app/register_screen/cubit/cubit.dart';
import 'package:todoapp/modules/shop_app/register_screen/cubit/states.dart';
import 'package:todoapp/shared/componants/componants.dart';
import 'package:todoapp/shared/network/local/cache_helper.dart';

class ShopRegisterScreen extends StatelessWidget {
  var nameController = TextEditingController();
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var repeatPasswordController = TextEditingController();
  var phoneController = TextEditingController();

  var formkey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => RegisterCubit(),
      child: BlocConsumer<RegisterCubit, RegisterStates>(
        listener: (context, state) {
          if (state is RegisterSuccessStates) {
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
          } else if (state is RegisterErrorStates) {
            showSnackBar(context, state.error, SnackState.ERROR);
          }
        },
        builder: (context, state) {
          RegisterCubit cubit = RegisterCubit.get(context);
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
                          'Register',
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
                            controller: nameController,
                            keyboardtype: TextInputType.text,
                            validator: (value) {
                              if (value.isEmpty) {
                                return 'Please enter your Name';
                              }else {
                                return null;
                              }
                            },
                            prefix: Icons.person,
                            labelText: 'your name ...'),
                        SizedBox(
                          height: 15,
                        ),
                        defaultTextFormField(context,
                            controller: emailController,
                            keyboardtype: TextInputType.emailAddress,
                            validator: (value) {
                              if (value.isEmpty) {
                                return 'Please enter your email';
                              } else if (!RegExp(
                                  r'^[\w-]+@([\w-]+\.)+[\w]{2,4}')
                                  .hasMatch(value!)) {
                                return 'Email Should be like salla@example.com \n Email can\'t contain * / - + % # \$ !';
                              }
                              return null;
                            },
                            prefix: Icons.email_outlined,
                            labelText: 'email address ...'),
                        SizedBox(
                          height: 15,
                        ),
                        defaultTextFormField(
                          context,
                          controller: phoneController,
                          keyboardtype: TextInputType.phone,
                          validator: (value) {
                            if(value.isEmpty) {
                              return 'phone can\'t be empty';
                            }else if (value.toString().length < 11 || value.toString().length > 11) {
                              return 'phone should be 11 number';
                            }else {
                              return null;
                            }
                          },
                          prefix: Icons.phone,
                          labelText: 'phone ...',
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        defaultTextFormField(context,
                            controller: passwordController,
                            keyboardtype: TextInputType.visiblePassword,
                            labelText: 'password...',
                            onchange: (String value) {},
                            validator: (value) {
                              if (value.isEmpty) {
                                return 'password Can\'t be empty';
                              } else if (value.toString().length < 6) {
                                return 'Password can\'t be less than 6';
                              }else {
                                return null;
                              }
                            },
                            prefix: Icons.lock_outline,
                            isPassword: cubit.isPassword,
                            suflix: cubit.suflixIcon,
                            suflixpressed: () {
                              cubit.changePasswordShow(1);
                            }),
                        SizedBox(
                          height: 15,
                        ),
                        defaultTextFormField(context,
                            controller: repeatPasswordController,
                            keyboardtype: TextInputType.visiblePassword,
                            labelText: 'repeat password...',
                            onchange: (String value) {},
                            validator: (value) {
                              if(value.isEmpty) {
                                return 'Please enter your new password';
                              } else if (value.toString().length < 6) {
                                return 'Password can\'t be less than 6';
                              }else if(value != passwordController.text){
                                return 'Password did\'t match';
                              }
                              return null;
                            },
                            prefix: Icons.lock_outline,
                            isPassword: cubit.repeatPasswordHide,
                            suflix: cubit.repeatSuflixIcon,
                            suflixpressed: () {
                              cubit.changePasswordShow(2);
                            }),
                        SizedBox(
                          height: 20,
                        ),
                        BuildCondition(
                          condition: state is! RegisterLoadingStates,
                          builder: (context) => defultButton(
                              pressfunction: () {
                                if (formkey.currentState!.validate()) {
                                  cubit.userRegister(context,
                                      email: emailController.text,
                                      phone: phoneController.text,
                                      name: nameController.text,
                                      password: passwordController.text
                                  );
                                }
                              },
                              text: 'Register'),
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
