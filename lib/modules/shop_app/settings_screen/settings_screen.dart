import 'package:buildcondition/buildcondition.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todoapp/layout/shop_layout/cubit/cubit.dart';
import 'package:todoapp/layout/shop_layout/cubit/states.dart';
import 'package:todoapp/modules/shop_app/edit_profile_screen/edit_profile_screen.dart';
import 'package:todoapp/modules/shop_app/help_screen/help_screen.dart';
import 'package:todoapp/modules/shop_app/login_screen/login_screen.dart';
import 'package:todoapp/shared/componants/componants.dart';
import 'package:todoapp/shared/componants/constants.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopStates>(
      listener: (context, state) {},
      builder: (context, state) {
        ShopCubit cubit = ShopCubit.get(context);
        return BuildCondition(
          condition: cubit.userDataModel != null,
          builder: (context) => Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              children: [
                InkWell(
                  onTap: (){
                    cubit.nameController.text = cubit.userDataModel!.data!.name!;
                    cubit.emailController.text = cubit.userDataModel!.data!.email!;
                    cubit.phoneController.text = cubit.userDataModel!.data!.phone!;
                    navigatorGoto(context, EditProfileScreen());
                  },
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 20.0),
                    child: Row(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(50),
                          child: CachedNetworkImage(
                            imageUrl: 'https://picsum.photos/72',
                            errorWidget: (context, text, dynamic) => Image.asset(
                              "assets/image/PngItem_5585968.png",
                              width: 70,
                              height: 70,
                            ),
                            progressIndicatorBuilder: (context, msg, progress) => Center(
                                child: CircularProgressIndicator(
                                  color: Colors.grey,
                                )),
                            width: 70,
                            height: 70,
                          ),
                        ),
                        SizedBox(width: 15,),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(cubit.userDataModel!.data!.name!,style: TextStyle(fontSize: 22,fontWeight: FontWeight.bold),),
                            Text(cubit.userDataModel!.data!.email!,style: TextStyle(fontSize: 18,color: Colors.grey),),
                          ],
                        ),
                        Spacer(),
                        Icon(Icons.arrow_forward,size: 35,)
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 50,),
                InkWell(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 20.0),
                    child: Row(
                      children: [
                        Icon(Icons.favorite_border,color: Colors.grey,size: 35,),
                        SizedBox(width: 15,),
                        Text("Favorites",style: TextStyle(fontSize: 25,fontWeight: FontWeight.bold),),
                        Spacer(),
                        Icon(Icons.arrow_forward_ios,size: 30,),
                      ],
                    ),
                  ),
                  onTap: (){
                    cubit.changeBottomNav(2);
                  },
                ),
                Container(
                  color: Colors.grey[300],
                  width: double.infinity,
                  height: 1,
                ),
                InkWell(
                  onTap: (){
                    print(cubit.userDataModel!.data!.token);
                  },
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 20.0),
                    child: Row(
                      children: [
                        Icon(Icons.remove_red_eye,color: Colors.grey,size: 35,),
                        SizedBox(width: 15,),
                        Text("Appearance",style: TextStyle(fontSize: 25,fontWeight: FontWeight.bold),),
                        Spacer(),
                        Icon(Icons.arrow_forward_ios,size: 30,),
                      ],
                    ),
                  ),
                ),
                Container(
                  color: Colors.grey[300],
                  width: double.infinity,
                  height: 1,
                ),
                InkWell(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 20.0),
                    child: Row(
                      children: [
                        Icon(Icons.help,color: Colors.grey,size: 35,),
                        SizedBox(width: 15,),
                        Text("Help & Support",style: TextStyle(fontSize: 25,fontWeight: FontWeight.bold),),
                        Spacer(),
                        Icon(Icons.arrow_forward_ios,size: 30,),
                      ],
                    ),
                  ),
                  onTap: (){
                    navigatorGoto(context, HelpScreen());
                    cubit.getFQA();
                  },
                ),
                Container(
                  color: Colors.grey[300],
                  width: double.infinity,
                  height: 1,
                ),
                InkWell(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 20.0),
                    child: Row(
                      children: [
                        SizedBox(width: 15,),
                        Text("Log out",style: TextStyle(fontSize: 30,fontWeight: FontWeight.bold),),
                        Spacer(),
                        Icon(Icons.logout,size: 30,color: Colors.blue,),
                      ],
                    ),
                  ),
                  onTap: (){
                    signOut(context);
                  },
                ),
                Container(
                  color: Colors.grey[300],
                  width: double.infinity,
                  height: 1,
                ),
              ],
            ),
          ),
          fallback: (context) => Center(child: CircularProgressIndicator(color: Colors.amber,)),
        );

      },
    );
  }
}
