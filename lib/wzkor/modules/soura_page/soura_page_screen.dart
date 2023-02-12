import 'package:buildcondition/buildcondition.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:todoapp/models/soura_model.dart';
import 'package:todoapp/wzkor/shared/componants/componants.dart';
import 'package:todoapp/wzkor/shared/cubit/cubit.dart';
import 'package:todoapp/wzkor/shared/cubit/states.dart';

class souraPageScreen extends StatelessWidget {
  Soura souraitem;

  souraPageScreen({
    super.key,
    required this.souraitem,
  });

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<WzkorCubit, WzkorStates>(
      listener: (context, state) {},
      builder: (context, state) {
        WzkorCubit cubit = WzkorCubit.get(context);
        return Directionality(
          textDirection: TextDirection.rtl,
          child: Scaffold(
            backgroundColor: Colors.white,
            appBar: AppBar(
              backgroundColor: Colors.white,
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
                      cubit.isLight
                          ? Icons.mode_night_rounded
                          : Icons.light_mode,
                      color: cubit.isLight ? Colors.black : Colors.yellow,
                    )),
                IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: Icon(
                      Icons.arrow_forward_ios,
                    ))
              ],
              elevation: 0,
              bottom: Tab(
                child: Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Theme.of(context).cardColor,
                    borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(30),
                        bottomRight: Radius.circular(30)),
                  ),
                  child: Text(
                    " سورة${souraitem.name}",
                    style: Theme.of(context).textTheme.titleLarge,
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            ),
            body: SingleChildScrollView(
              child: Column(
                children: [
                  BuildCondition(
                    condition: souraitem.id == 1 || souraitem.id == 9,
                    fallback: (context) => Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10.0),
                      child: Text(
                        "بِسۡمِ ٱللَّهِ ٱلرَّحۡمَٰنِ ٱلرَّحِيم",
                        style: Theme.of(context).textTheme.titleLarge,
                        textAlign: TextAlign.center,
                      ),
                    ),
                    builder: (context) => const Center(),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10.0),
                    child: Text(
                      souraitem.ar.toString(),
                      style: Theme.of(context).textTheme.titleMedium,
                      textAlign: TextAlign.center,
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
