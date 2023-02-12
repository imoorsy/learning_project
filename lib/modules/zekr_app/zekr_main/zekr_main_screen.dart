import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:todoapp/modules/zekr_app/zekr_screen/cubit/cubit.dart';
import 'package:todoapp/modules/zekr_app/zekr_screen/cubit/states.dart';
import 'package:todoapp/modules/zekr_app/zekr_screen/zekr_screen.dart';
import 'package:todoapp/shared/componants/componants.dart';

class zekrMainScreen extends StatelessWidget {
  const zekrMainScreen({Key? key}) : super(key: key);

  @override
  Widget build( context) {
    return BlocConsumer<zekrCubit, zekrStates>(
      listener: (BuildContext context , state) => {},
      builder: (BuildContext context,state) {
        zekrCubit cubit = zekrCubit.get(context);
        return Scaffold(
        appBar: AppBar(
          title: Text('Azkar'),
          actions: [
            IconButton(onPressed: (){}, icon: Icon(Icons.sunny)),
            IconButton(onPressed: (){}, icon: Icon(Icons.search)),
            Icon(Icons.text_rotation_angleup),
            SizedBox(width: 20,),
          ],
        ),
        body: GridView.count(
          mainAxisSpacing:10,
          crossAxisSpacing: 10,
          crossAxisCount: 2,
          padding: EdgeInsets.all(16),
          children: [
            buildMainZekrItem('أذكار الصباح',Icons.light_mode,context,zekrScreen(),cubit.morningZekr),
            buildMainZekrItem('أذكار المساء',Icons.light_mode,context,zekrScreen(),cubit.nightZekr),
            buildMainZekrItem('أذكار النوم',Icons.light_mode,context,zekrScreen(),cubit.sleepZekr),
            buildMainZekrItem('أذكار الاستيقاظ',Icons.light_mode,context,zekrScreen(),cubit.wakupZekr),
            buildMainZekrItem('أذكار الوضوء',Icons.light_mode,context,zekrScreen(),cubit.wodoaZekr),
            buildMainZekrItem('أذكار الصلاة',Icons.light_mode,context,zekrScreen(),cubit.prayerZekr),
            buildMainZekrItem('أذكار المنزل',Icons.light_mode,context,zekrScreen(),cubit.homeZekr),
            buildMainZekrItem('أذكار عامة',Icons.light_mode,context,zekrScreen(),cubit.generalZekr),
          ],
        ),
      );
      },
    );
  }
}
