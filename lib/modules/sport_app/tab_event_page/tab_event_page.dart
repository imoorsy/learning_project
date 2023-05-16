import 'package:badges/badges.dart';
import 'package:buildcondition/buildcondition.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todoapp/layout/sport_layout/cubit/cubit.dart';
import 'package:todoapp/layout/sport_layout/cubit/states.dart';
import 'package:todoapp/models/single_match_model.dart';

class TabEventScreen extends StatelessWidget {
  const TabEventScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SportCubit, SportStates>(
        builder: (context, state) {
          SportCubit cubit = SportCubit.get(context);
          return BuildCondition(
            condition: cubit.currentMatch!.response![0].events!.isNotEmpty,
            builder: (context) => RefreshIndicator(
              onRefresh: cubit.getSelctedMatch,
              child: SingleChildScrollView(
                child: Container(
                  padding: EdgeInsets.only(bottom: 20),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        width: MediaQuery.of(context).size.width * 0.4,
                        child: Column(
                          children: [
                            for(int i = cubit.currentMatch!.response![0].events!.length - 1; i >= 0 ; i--)
                              BuildCondition(
                                condition: cubit.currentMatch!.response![0].events![i].team!.name == cubit.currentMatch!.response!.first.teams!.home!.name,
                                builder: (context) => buildMatchEvent(cubit.currentMatch!.response![0].events![i]),
                                fallback: (context) => SizedBox(height: 90,child: Text('')),
                              ),
                          ],
                        ),
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width * 0.2,
                        child: Column(
                          children: [
                            for(int i = cubit.currentMatch!.response![0].events!.length - 1; i >= 0 ; i--)
                              Column(
                                children: [
                                  Container(
                                    height: 50,
                                    width: 5,
                                    color: Colors.grey,
                                  ),
                                  Container(
                                    width: double.infinity,
                                    height: 40,
                                    padding: EdgeInsets.all(10),
                                    decoration: BoxDecoration(
                                      color: Colors.grey,
                                      shape: BoxShape.circle,
                                    ),
                                    child: Center(
                                        child: BuildCondition(
                                          condition: cubit.currentMatch!.response![0].events![i].time!.extra == null,
                                          builder: (context) => Text(
                                            cubit.currentMatch!.response![0].events![i].time!.elapsed.toString(),
                                            maxLines: 2,
                                            textAlign: TextAlign.center,
                                            overflow: TextOverflow.ellipsis,
                                            style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 18,
                                              color: Colors.black,
                                            ),
                                          ),
                                          fallback: (context) => Badge(
                                            badgeStyle: BadgeStyle(
                                              badgeColor: Colors.yellow,
                                            ),
                                            position: BadgePosition.topEnd(end: -20,top: -20),
                                            badgeContent: Text(
                                              '+${cubit.currentMatch!.response![0].events![i].time!.extra!}',
                                              maxLines: 1,
                                              textAlign: TextAlign.center,
                                              overflow: TextOverflow.ellipsis,
                                              style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 14,
                                                color: Colors.black,
                                              ),
                                            ),
                                            child: Text(
                                              cubit.currentMatch!.response![0].events![i].time!.elapsed.toString(),
                                              maxLines: 2,
                                              textAlign: TextAlign.center,
                                              overflow: TextOverflow.ellipsis,
                                              style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 18,
                                                color: Colors.black,
                                              ),
                                            ),
                                          ),
                                        )
                                    ),
                                  ),
                                ],
                              ),
                          ],
                        ),
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width * 0.4,
                        child: Column(
                          children: [
                            for(int i = cubit.currentMatch!.response![0].events!.length - 1; i >= 0 ; i--)
                              BuildCondition(
                                condition: cubit.currentMatch!.response![0].events![i].team!.name == cubit.currentMatch!.response!.first.teams!.away!.name,
                                builder: (context) => buildMatchEvent(cubit.currentMatch!.response![0].events![i]),
                                fallback: (context) => SizedBox(height: 90,child: Text('')),
                              ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            fallback: (context) => Center(child: Text('No Events',style: TextStyle(fontSize: 25,fontWeight: FontWeight.bold,),)),
          );
        },
        listener: (context, state) {});
  }

  Widget buildMatchEvent(Events event) => BuildCondition(
    condition: event.type!.contains('Goal'),
    builder: (context) => BuildCondition(
      condition: event.detail!.contains('Missed'),
      builder: (context) => SizedBox(
        height: 90,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            SizedBox(width: 10,),
            Stack(
              alignment: Alignment(2, 2),
              children: [
                CircleAvatar(
                  radius: 20,
                  backgroundImage: NetworkImage("https://media-1.api-sports.io/football/players/${event.player!.id}.png",),
                ),
                Icon(Icons.not_interested,color: Colors.red,),
              ],
            ),
            SizedBox(width: 10,),
            Expanded(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(event.player!.name!,
                    maxLines: 2,
                    textAlign: TextAlign.center,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                      color: Colors.black,
                    ),
                  ),
                  Text(event.detail!,
                    maxLines: 2,
                    textAlign: TextAlign.center,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                      color: Colors.black54,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      fallback: (context) => SizedBox(
      height: 90,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          SizedBox(width: 10,),
          Stack(
            alignment: Alignment(2, 2),
            children: [
              CircleAvatar(
                radius: 20,
                backgroundImage: NetworkImage("https://media-1.api-sports.io/football/players/${event.player!.id}.png",),
              ),
              Icon(Icons.sports_soccer,color: Colors.green,),
            ],
          ),
          SizedBox(width: 10,),
          Expanded(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(event.player!.name!,
                  maxLines: 2,
                  textAlign: TextAlign.center,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                    color: Colors.black,
                  ),
                ),
                BuildCondition(
                  condition: event.assist!.name == null,
                  builder: (context) => Text(event.type!,
                    maxLines: 2,
                    textAlign: TextAlign.center,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                      color: Colors.black54,
                    ),
                  ),
                  fallback: (context) => Text(event.assist!.name!,
                    maxLines: 2,
                    textAlign: TextAlign.center,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                      color: Colors.black54,
                    ),
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    ),
    ),
    fallback: (context) => BuildCondition(
      condition: event.type!.contains('Card'),
      builder: (context) => SizedBox(
        height: 90,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            SizedBox(width: 10,),
            Icon(
              Icons.panorama_vertical_select,
              color: event.detail!.contains('Yellow') ? Colors.amber : Colors.red,
              size: 30,),
            SizedBox(width: 10,),
            Expanded(
              child: Text(event.player!.name!,
                maxLines: 2,
                textAlign: TextAlign.center,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                  color: Colors.black,
                ),
              ),
            ),
          ],
        ),
      ),
      fallback: (context) => BuildCondition(
        condition: event.type!.contains('Var'),
        builder: (context) => BuildCondition(
          condition: event.detail!.contains('Goal'),
          builder: (context) => SizedBox(
            height: 90,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                SizedBox(width: 10,),
                Icon(Icons.sports_soccer,color: Colors.red,size: 30,),
                SizedBox(width: 10,),
                Expanded(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text(
                        '${event.player!.name!} (${event.type!})',
                        maxLines: 2,
                        textAlign: TextAlign.center,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                          color: Colors.black,
                        ),
                      ),
                      Text(
                        event.detail!,
                        maxLines: 1,
                        textAlign: TextAlign.center,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                          color: Colors.black54,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          fallback: (context) => SizedBox(
            height: 90,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                SizedBox(width: 10,),
                Icon(Icons.ondemand_video,color: Colors.red,size: 30,),
                SizedBox(width: 10,),
                Expanded(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text(
                        '${event.player!.name!} (${event.type!})',
                        maxLines: 2,
                        textAlign: TextAlign.center,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                          color: Colors.black,
                        ),
                      ),
                      Text(
                        event.detail!,
                        maxLines: 1,
                        textAlign: TextAlign.center,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                          color: Colors.black54,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        fallback: (context) => BuildCondition(
          condition: event.type!.contains('subst'),
          builder: (context) => Container(
            height: 90,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisSize: MainAxisSize.min,
              children: [
                SizedBox(width: 10,),
                Icon(Icons.compare_arrows,color: Colors.green,size: 30,),
                SizedBox(width: 10,),
                Expanded(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        event.player!.name!,
                        maxLines: 2,
                        textAlign: TextAlign.center,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                          color: Colors.red,
                        ),
                      ),
                      Text(
                        event.assist!.name!,
                        maxLines: 2,
                        textAlign: TextAlign.center,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                          color: Colors.green,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          fallback: (context) => BuildCondition(
            condition: event.type!.contains('Var'),
            builder: (context) => SizedBox(
              height: 90,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  SizedBox(width: 10,),
                  Icon(Icons.ondemand_video,color: Colors.red,size: 30,),
                  SizedBox(width: 10,),
                  Expanded(
                    child: Text(
                      '${event.player!.name!} (${event.type!})',
                      maxLines: 1,
                      textAlign: TextAlign.center,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                        color: Colors.black,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            fallback: (context) => SizedBox(
              height: 90,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  SizedBox(width: 10,),
                  Icon(Icons.ondemand_video,color: Colors.red,size: 30,),
                  SizedBox(width: 10,),
                  Expanded(
                    child: Text(
                      '${event.player!.name!} (${event.type!})',
                      maxLines: 1,
                      textAlign: TextAlign.center,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                        color: Colors.black,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    ),
  );
}