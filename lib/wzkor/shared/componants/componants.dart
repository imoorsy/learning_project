import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:todoapp/models/soura_model.dart';
import 'package:todoapp/wzkor/modules/soura_page/soura_page_screen.dart';
import 'package:todoapp/wzkor/modules/zekr_page/zekr_page_screen.dart';
import 'package:todoapp/wzkor/shared/cubit/cubit.dart';

Widget buildWzkorMainItem(WzkorCubit cubit,Map<String,dynamic> azkaritem,context) => GestureDetector(
  child: Container(
        width: 380,
        height: 150,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(azkaritem["image"]),
            fit: BoxFit.cover,
          ),
          color: HexColor("EEEEEE"),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.all(30),
          decoration: BoxDecoration(
            color: Colors.black26,
            borderRadius: BorderRadius.circular(20),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  azkaritem["title"],
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 35,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  azkaritem["subtitle"],
                  style: TextStyle(
                    color: HexColor("D8E9A8"),
                    fontSize: 20,
                  ),
                ),
              ],
            ),
              IconButton(
              onPressed: () {},
              icon: Icon(
                Icons.favorite_border,
                size: 40,
                color: HexColor("FFFFFF"),
              ),
            ),

            ],
          ),
        ),
      ),
  onTap: () {
    Navigator.push(context, MaterialPageRoute(builder: (context) => zekrPageScreen())).then((value) {
      cubit.getData(azkaritem['file_path']);
    });
  },
);

Widget buildWzkorHomeItem(Map<String,dynamic> homeitem,context,WzkorCubit cubit) => GestureDetector(
  child: Container(
        width: 350,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(homeitem["image"]),
            fit: BoxFit.cover,
          ),
          color: HexColor("EEEEEE"),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.all(30),
          decoration: BoxDecoration(
            color: Colors.black26,
            borderRadius: BorderRadius.circular(20),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                homeitem["title"],
                textAlign: TextAlign.center,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 40,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                homeitem["subtitle"],
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: HexColor("D8E9A8"),
                  fontSize: 20,
                ),
              ),
            ],
          ),
        ),
      ),
  onTap: (){
    Navigator.push(context, MaterialPageRoute(builder: (context) => homeitem["goto"]));
    if (homeitem["id"] == 1) {
      cubit.getQuran();
    }else if (homeitem["id"] == 3) {
      cubit.getAsmaaAllah();
    }
  },
);


// Widget buildWzkorZekrItem(Zekr zekritem, context) => Container();

PreferredSizeWidget? buildWzkorAppBarBack(context,WzkorCubit cubit) => AppBar(
  titleSpacing: 20,
  leadingWidth: 0,
  leading: const Text(""),
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
        )
    ),
    IconButton(
        onPressed: (){
          Navigator.pop(context);
        },
        icon: Icon(
          Icons.arrow_forward_ios,
        )
    )
  ],
  elevation: 0,
);