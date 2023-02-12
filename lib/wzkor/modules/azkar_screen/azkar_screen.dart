import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hexcolor/hexcolor.dart';
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
            padding: const EdgeInsets.all(20),
              itemBuilder: (context, index) => buildWzkorMainItem(cubit,cubit.azkarItems[index],context),
              separatorBuilder: (context, index) => const SizedBox(height: 20,),
              itemCount: cubit.azkarItems.length),
        );
        },
      ),
    );
  }
}
