import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todoapp/layout/sport_layout/cubit/cubit.dart';
import 'package:todoapp/layout/sport_layout/cubit/states.dart';
import 'package:todoapp/modules/sport_app/home_screen/home_screen.dart';

class SportLayout extends StatelessWidget {
  SportLayout({Key? key}) : super(key: key);

  var scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SportCubit,SportStates>(
      listener: (context,state) {},
      builder: (context,state) {
        return Scaffold(
          key: scaffoldKey,
          appBar: AppBar(
            backgroundColor: Colors.green[700],
            systemOverlayStyle: SystemUiOverlayStyle(
                statusBarBrightness: Brightness.light,
                statusBarColor: Colors.green[700]
            ),
            leading: Row(
              children: [
                IconButton(onPressed: (){
                  scaffoldKey.currentState!.openDrawer();
                }, icon: Icon(Icons.menu,size: 35,)),
                IconButton(onPressed: (){}, icon: Icon(Icons.dark_mode,color: Colors.black87,size: 35,)),
              ],
            ),
            toolbarHeight: 90,
            leadingWidth: 100,
            centerTitle: true,
            title: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.sports_soccer,size: 45,),
                SizedBox(width: 10,),
                Text('Moccer',style: TextStyle(fontSize: 30,fontWeight: FontWeight.bold),),
              ],
            ),
            actions: [
              IconButton(onPressed: (){}, icon: Icon(Icons.filter_list,size: 35,)),
              IconButton(onPressed: (){}, icon: Icon(Icons.search,size: 35,)),
              SizedBox(width: 10,),
            ],
          ),
          drawerScrimColor: Colors.green[700]!.withOpacity(0.3),
          drawer: Drawer(
            backgroundColor: Colors.white,
            child: Icon(Icons.sports_soccer,size: 100,),
          ),
          body: SportHomeScreen(),
        );
      },
    );
  }
}
