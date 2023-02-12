import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:todoapp/wzkor/shared/cubit/cubit.dart';
import 'package:todoapp/wzkor/shared/cubit/states.dart';

class WzkorLayout extends StatelessWidget {
  const WzkorLayout({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<WzkorCubit,WzkorStates>(
      listener:(context,state) {} ,
      builder: (context,state) {
        WzkorCubit cubit = WzkorCubit.get(context);
        return Scaffold(
        appBar: AppBar(
          titleSpacing: 20,
          title: Text(
            "وَاذْكُرْ",
            style: Theme.of(context).textTheme.titleSmall,
          ),
          actions: [
            IconButton(
              onPressed: () {},
              icon: Icon(
                Icons.settings,
              ),
            ),
            IconButton(
                onPressed: () {
                  cubit.changeTheme();
                },
                icon: Icon(
                  cubit.isLight ? Icons.mode_night_rounded : Icons.light_mode,
                  color: cubit.isLight ? Colors.black : Colors.yellow,
                )),
            const SizedBox(width: 10,),
          ],
          elevation: 0,
        ),
        body: cubit.screen[cubit.currentIndex],
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: cubit.currentIndex,
          items: cubit.bottomBarItems,
          elevation: 0,
          showSelectedLabels: false,
          unselectedLabelStyle: const TextStyle(
            fontSize: 16
          ),
          onTap: (index){
            cubit.changeIndex(index);
          },
        ),

      );
      },
    );
  }
}
