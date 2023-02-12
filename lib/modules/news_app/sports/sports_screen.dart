import 'package:buildcondition/buildcondition.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todoapp/layout/news_layout/cubit/cubit.dart';
import 'package:todoapp/layout/news_layout/cubit/status.dart';
import 'package:todoapp/shared/componants/componants.dart';

class SportsScreen extends StatelessWidget {
  const SportsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<newsCubit, newsStates>(
        listener: (context,state){},
        builder:(context,state) {
          newsCubit cubit = newsCubit.get(context);
          var sports = cubit.sports;
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
              condition: sports.isNotEmpty,
              builder: (context) => RefreshIndicator(
                color: Colors.white,
                strokeWidth: 4,
                backgroundColor: Colors.green,
                displacement: 100,
                onRefresh: cubit.getSports,
                child: ListView.separated(
                    physics: const ClampingScrollPhysics(),
                    itemBuilder: (context, index) => buildNewsAppItem( sports[index],context),
                    separatorBuilder:(context, index) => Container(width: double.infinity,height: 1,color: Colors.grey,),
                    itemCount: sports.length),
              ),
              fallback:(context) => const Center(child: CircularProgressIndicator()),
            ) ,
          );


        }
    );
  }
}
