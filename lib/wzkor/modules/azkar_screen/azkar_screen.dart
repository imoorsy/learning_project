import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:todoapp/wzkor/modules/zekr_page/zekr_page_screen.dart';
import 'package:todoapp/wzkor/shared/componants/componants.dart';
import 'package:todoapp/wzkor/shared/cubit/cubit.dart';
import 'package:todoapp/wzkor/shared/cubit/states.dart';

class azkarScreen extends StatelessWidget {
  const azkarScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: BlocConsumer<WzkorCubit,WzkorStates>(
        listener: (context, state) {},
        builder: (context, state) {
          WzkorCubit cubit = WzkorCubit.get(context);
          return Scaffold(
          appBar: buildWzkorAppBarBack(context,cubit),
          body: ListView.separated(
            physics: BouncingScrollPhysics(),
            padding: const EdgeInsets.all(20),
              itemBuilder: (context, index) => buildWzkorMainItem(cubit,cubit.azkarItems[index],context),
              separatorBuilder: (context, index) => const SizedBox(height: 20,),
              itemCount: cubit.azkarItems.length),
        );
        },
      ),
    );
  }

  Widget buildWzkorMainItem(WzkorCubit cubit,Map<String,dynamic> azkaritem,context) => InkWell(
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
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
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
            // IconButton(
            //   onPressed: () {},
            //   icon: Icon(
            //     Icons.favorite_border,
            //     size: 40,
            //     color: HexColor("FFFFFF"),
            //   ),
            // ),

          ],
        ),
      ),
    ),
    onTap: () async {
      await cubit.getData(azkaritem['file_path']);
      await Navigator.push(context, MaterialPageRoute(builder: (context) => zekrPageScreen()));
    },
  );
}
