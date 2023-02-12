import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todoapp/layout/news_layout/cubit/cubit.dart';
import 'package:todoapp/layout/news_layout/cubit/status.dart';
import 'package:todoapp/modules/news_app/search_screen/search_screen.dart';
import 'package:todoapp/shared/componants/componants.dart';

class NewsLayout extends StatelessWidget {
  const NewsLayout({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<newsCubit, newsStates>(
      listener: (context,state){},
      builder:(context,state)  {
        newsCubit cubit = newsCubit.get(context);
        return Scaffold(
        appBar: AppBar(
          title: Text('News App'),
          actions: [
            IconButton(
                onPressed: (){
                  navigatorGoto(context, searchScreen());
                },
                icon: Icon(Icons.search)
            ),
            IconButton(
              onPressed: (){
                cubit.changeMode();
              },
              icon: cubit.isDark ? Icon(Icons.light_mode) : Icon(Icons.dark_mode),
            ),
          ],
        ),
        body: cubit.screens[cubit.currentIndex],
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: cubit.currentIndex,
          items: cubit.bottomItems,
          onTap: (index) {
            cubit.changeBottomNav(index);
          },
        ),
      );
      }
    );
  }
}
