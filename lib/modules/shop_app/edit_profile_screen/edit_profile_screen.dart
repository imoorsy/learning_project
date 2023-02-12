import 'package:buildcondition/buildcondition.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todoapp/layout/shop_layout/cubit/cubit.dart';
import 'package:todoapp/layout/shop_layout/cubit/states.dart';
import 'package:todoapp/modules/shop_app/edit_password_screen/edit_password_screen.dart';
import 'package:todoapp/shared/componants/componants.dart';

class EditProfileScreen extends StatelessWidget {
  const EditProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopStates>(
      listener: (context, state) {},
      builder: (context, state) {
        ShopCubit cubit = ShopCubit.get(context);
        return Scaffold(
          appBar: AppBar(
            leading: IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: Icon(
                  Icons.arrow_back_ios,
                  size: 30,
                )),
            leadingWidth: 80,
            backgroundColor: Colors.transparent,
            elevation: 0,
            centerTitle: true,
            actions: [
              IconButton(
                  onPressed: () async {
                    if(cubit.editFormKey.currentState!.validate()) {
                      await cubit.updateUserData(context);
                    }
                  },
                  icon: Icon(
                    Icons.save,
                    color: Colors.amber,
                    size: 40,
                  )),
              SizedBox(
                width: 10,
              )
            ],
          ),
          body: BuildCondition(
            condition: state is! ShopLoadingUpdateUserState,
            builder: (context) => SingleChildScrollView(
              physics: BouncingScrollPhysics(),
              child: Container(
                width: double.infinity,
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: Form(
                  key: cubit.editFormKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(
                        height: 20,
                      ),
                      Text('Edit Your Profile.',
                          style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 30)),
                      SizedBox(
                        height: 20,
                      ),
                      ClipRRect(
                        borderRadius: BorderRadius.circular(150),
                        child: Stack(
                          alignment: Alignment.bottomCenter,
                          children: [
                            CachedNetworkImage(
                              imageUrl: 'https://picsum.photos/150',
                              errorWidget: (context, text, dynamic) => Image.asset(
                                "assets/image/PngItem_5585968.png",
                                width: 150,
                                height: 150,
                              ),
                              progressIndicatorBuilder: (context, msg, progress) =>
                                  Center(
                                      child: CircularProgressIndicator(
                                        color: Colors.grey,
                                      )),
                              fit: BoxFit.cover,
                              width: 150,
                              height: 150,
                            ),
                            Container(
                              width: 150,
                              height: 40,
                              color: Colors.black45,
                              child: Icon(
                                Icons.camera_alt,
                                color: Colors.white,
                                size: 30,
                              ),
                            )
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      defaultTextFormField(context,
                          controller: cubit.nameController,
                          keyboardtype: TextInputType.text, validator: (value) {
                            if (value.isEmpty) {
                              return 'Name Can\'t be empty';
                            } else {
                              return null;
                            }
                          },
                          prefix: Icons.person,
                          labelText: 'name'),
                      SizedBox(
                        height: 30,
                      ),
                      defaultTextFormField(context,
                          controller: cubit.emailController,
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
                          prefix: Icons.email,
                          labelText: 'email'),
                      SizedBox(
                        height: 30,
                      ),
                      defaultTextFormField(
                        context,
                        controller: cubit.phoneController,
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
                        labelText: 'phone',
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      TextButton(
                          onPressed: () {
                            navigatorGoto(context, EditPasswordScreen());
                          },
                          child: Text(
                            'edit password',
                            style: TextStyle(color: Colors.blue, fontSize: 20),
                          )),
                    ],
                  ),
                ),
              ),
            ),
            fallback: (context) => Center(child: CircularProgressIndicator(color: Colors.amber,)),
          ),
        );
      },
    );
  }
}
