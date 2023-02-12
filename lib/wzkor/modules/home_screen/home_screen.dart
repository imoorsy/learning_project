import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:todoapp/wzkor/modules/asmaa_allah_screen/asmaa_allah_screen.dart';
import 'package:todoapp/wzkor/modules/azkar_screen/azkar_screen.dart';
import 'package:todoapp/wzkor/modules/quran_screen/quran_screen.dart';
import 'package:todoapp/wzkor/shared/componants/componants.dart';
import 'package:todoapp/wzkor/shared/cubit/cubit.dart';
import 'package:todoapp/wzkor/shared/cubit/states.dart';

class HomeScreen extends StatelessWidget {
  List<Map<String,dynamic>> homeItem = [
    {
      "id" : 1,
      "title":"القرآن الكريم",
      "subtitle":"القرآن كامل خير الكتب",
      "image": "assets/image/boy_read_quran.jpg",
      "goto": const quranScreen()
    },
    {
      "id" : 2,
      "title":"الاذكار",
      "subtitle":"اذكار المسلم في يومه وحياته",
      "image": "assets/image/man_hold_sepha.jpg",
      "goto":const azkarScreen()
    },
    {
      "id" : 3,
      "title":"أسماء الله الحسني",
      "subtitle":"ان لله تسع وتسعون اسماً من احصاها دخل الجنه",
      "image": "assets/image/outside_mosque2.jpg",
      "goto":const asmaaAllahScreen()
    }
  ];

  HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<WzkorCubit,WzkorStates>(
      listener: (context,state) {},
      builder:(context,state) {
        WzkorCubit cubit = WzkorCubit.get(context);
        return SingleChildScrollView(
          child: Column(
            children: [
              buildWzkorWelcomeHead(context),
              const SizedBox(height: 20,),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: ListView.separated(
                  physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemBuilder: (context,index) => buildWzkorHomeItem(homeItem[index],context,cubit),
                    separatorBuilder: (context,index) => const SizedBox(width: double.infinity,height: 20,),
                    itemCount: homeItem.length),
              )
            ],
          ),
        );
      },
    );
  }

  Widget buildWzkorWelcomeHead(context) => Container(
    width: double.infinity,
    padding: const EdgeInsets.all(20),
    decoration: BoxDecoration(
      color: Theme.of(context).cardColor,
      borderRadius: const BorderRadius.only(
          bottomLeft: Radius.circular(50), bottomRight: Radius.circular(50)),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "السلام عليكم ورحمة الله وبركاته",
          style: Theme.of(context).textTheme.titleLarge,
        ),
        const SizedBox(
          height: 20,
        ),
        Text(
          "آمَنَ الرَّسُولُ بِمَا أُنْزِلَ إِلَيْهِ مِنْ رَبِّهِ وَالْمُؤْمِنُونَ ۚ",
          style: Theme.of(context).textTheme.labelLarge,
        ),
        const SizedBox(
          height: 20,
        ),
      ],
    ),
  );
}
