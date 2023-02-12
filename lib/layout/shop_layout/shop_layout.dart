import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todoapp/layout/shop_layout/cubit/cubit.dart';
import 'package:todoapp/layout/shop_layout/cubit/states.dart';
import 'package:todoapp/modules/shop_app/login_screen/login_screen.dart';
import 'package:todoapp/modules/shop_app/search_screen/search_screen.dart';
import 'package:todoapp/shared/componants/componants.dart';
import 'package:todoapp/shared/network/local/cache_helper.dart';

class ShopLayout extends StatelessWidget {
  const ShopLayout({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopStates>(
      listener: (context, state) {},
      builder: (context, state) {
        ShopCubit cubit = ShopCubit.get(context);
        return Scaffold(
          appBar: AppBar(
            title: Row(
              children: [
                Icon(
                  Icons.shopping_basket,
                  size: 40,
                  color: Colors.black,
                ),
                SizedBox(
                  width: 10,
                ),
                Text(
                  "El",
                  style: TextStyle(fontSize: 40, color: Colors.amber),
                ),
                Text(
                  "gomaa",
                  style: TextStyle(fontSize: 40, color: Colors.black),
                ),
              ],
            ),
            actions: [
              IconButton(
                  onPressed: () {
                    navigatorGoto(context, SearchScreen());
                  },
                  icon: Icon(
                    Icons.search,
                    size: 40,
                  )),
              SizedBox(
                width: 10,
              ),
            ],
          ),
          body: cubit.shopScreens[cubit.currentIndex],
          bottomNavigationBar: BottomNavigationBar(
            currentIndex: cubit.currentIndex,
            items: [
              BottomNavigationBarItem(
                  icon: Icon(Icons.home_filled), label: 'Home'),
              BottomNavigationBarItem(
                  icon: Icon(Icons.category), label: 'Categories'),
              BottomNavigationBarItem(
                  icon: Icon(Icons.favorite), label: 'Favorite'),
              BottomNavigationBarItem(
                  icon: Icon(Icons.person), label: 'Profile'),
            ],
            onTap: (index) {
              cubit.changeBottomNav(index);
            },
          ),
        );
      },
    );

  }
}
