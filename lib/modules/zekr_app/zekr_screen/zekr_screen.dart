import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todoapp/models/zekr_model.dart';
import 'package:todoapp/modules/zekr_app//zekr_screen/cubit/cubit.dart';
import 'package:todoapp/modules/zekr_app/zekr_screen/cubit/states.dart';
import 'package:todoapp/shared/componants/componants.dart';
import 'dart:convert';


class zekrScreen extends StatelessWidget {
  List<Zekr> zekrs = [];


  @override
  Widget build(BuildContext context) {
    return BlocConsumer<zekrCubit,zekrStates>(
      listener: (context, state){},
      builder: (context, state) {
        zekrCubit cubit = zekrCubit.get(context);
        zekrs = cubit.zekrs;
        return Scaffold(
          appBar: AppBar(
            title: Text('Azkar'),
            centerTitle: true,
            // leading: IconButton(onPressed: (){zekrCubit.get(context).getJsonData(list);}, icon: Icon(Icons.refresh)),
          ),
          body: Padding(
            padding: const EdgeInsets.all(20.0),
            child: ListView.separated(
                itemBuilder: (context, index) => buildZekrItem(
                    zekrs[index].zekr,
                    zekrs[index].description,
                    zekrs[index].count,
                    index,
                    context
                ),
                separatorBuilder: (context, index) => SizedBox(width: double.infinity,height: 20,),
                itemCount: zekrs.length),
          ),

        );
      },
    );
  }
}
