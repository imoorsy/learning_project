import 'package:buildcondition/buildcondition.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todoapp/layout/news_layout/cubit/cubit.dart';
import 'package:todoapp/layout/news_layout/cubit/status.dart';
import 'package:todoapp/shared/componants/componants.dart';

class BusinessScreen extends StatelessWidget {
  const BusinessScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<newsCubit, newsStates>(
        listener: (context,state){
          if (state is networkNotConnectStates) {
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("No Internet Connection !",style: TextStyle(color: Colors.white,fontSize: 18),),backgroundColor: Colors.black45,));
          }
        },
        builder:(context,state)  {
          newsCubit cubit = newsCubit.get(context);
          var busniss = newsCubit.get(context).busniss;
          return BuildCondition(
            condition: state is networkNotConnectStates,
            builder: (context) => RefreshIndicator(
              color: Colors.white,
              strokeWidth: 4,
              backgroundColor: Colors.green,
              displacement: 100,
              onRefresh: cubit.getBusniss,
              child: ListView(
                children: [
                  SizedBox(height: 200,),
                  Center(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(Icons.wifi_off,size: 150,color: Colors.green,),
                        Text("No Intenet",style: Theme.of(context).textTheme.headline1,),
                      ],
                    ),
                  )
                ],
              ),
            ),
            fallback: (context) => BuildCondition(
              condition: busniss.isNotEmpty,
              builder: (context) => RefreshIndicator(
                color: Colors.white,
                strokeWidth: 4,
                backgroundColor: Colors.green,
                displacement: 100,
                onRefresh: cubit.getBusniss,
                child: ListView.separated(
                    physics: const ClampingScrollPhysics(),
                    itemBuilder: (context, index) => buildNewsAppItem( busniss[index] , context),
                    separatorBuilder:(context, index) => Container(width: double.infinity,height: 1,color: Colors.grey,),
                    itemCount: busniss.length),
              ),
              fallback:(context) => const Center(child: CircularProgressIndicator()),
            ) ,
          );


        }
    );
  }
}
