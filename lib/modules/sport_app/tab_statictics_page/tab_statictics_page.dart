import 'package:buildcondition/buildcondition.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:todoapp/layout/sport_layout/cubit/cubit.dart';
import 'package:todoapp/layout/sport_layout/cubit/states.dart';
import 'package:todoapp/models/single_match_model.dart';

class TabStatisticsScreen extends StatelessWidget {
  const TabStatisticsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SportCubit, SportStates>(
        builder: (context, state) {
          SportCubit cubit = SportCubit.get(context);
          return BuildCondition(
            condition: cubit.currentMatch!.response![0].statistics!.isNotEmpty,
            builder: (context) => RefreshIndicator(
              onRefresh: cubit.getSelctedMatch,
              child: RefreshIndicator(
                onRefresh: cubit.getSelctedMatch,
                child: SingleChildScrollView(
                  child: Container(
                    padding: EdgeInsets.only(bottom: 20),
                    child: Column(
                      children: [
                        for (int i = 0; i < cubit.currentMatch!.response![0].statistics!.first.statistics!.length; i++)
                          buildStatisticItem(
                            cubit.currentMatch!.response![0].statistics!.first
                                .statistics![i],
                            cubit.currentMatch!.response![0].statistics!.last
                                .statistics![i],
                            cubit.currentMatch!.response![0].lineups!.first.team!.colors!.player!.primary!,
                            cubit.currentMatch!.response![0].lineups!.last.team!.colors!.player!.primary!,
                          ),
                      ],
                    )
                  ),
                ),
              ),
            ),
            fallback: (context) => Center(
                child: Text(
              'No Statistic',
              style: TextStyle(
                fontSize: 25,
                fontWeight: FontWeight.bold,
              ),
            )),
          );
        },
        listener: (context, state) {});
  }

  Widget buildStatisticItem(Statistics hStatistic, Statistics aStatistic,
          String hColor, String aColor) =>
      Container(
        padding: EdgeInsets.all(20),
        color: Colors.grey[300],
        child: BuildCondition(
          condition: hStatistic.value.runtimeType != int || aStatistic.value.runtimeType != int || hStatistic.value == null || aStatistic.value == null ,
          builder: (context) => Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Text(
                    hStatistic.value == null ? '0' : hStatistic.value.toString(),
                    style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    hStatistic.type!,
                    style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    aStatistic.value == null ? '0' : aStatistic.value.toString(),
                    style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              SizedBox(
                height: 10,
              ),
              LinearProgressIndicator(
                value: 1,
                color: HexColor(hColor),
                backgroundColor: HexColor(aColor),
              ),
            ],
          ),
          fallback: (context) => Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Text(
                  hStatistic.value.toString(),
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                ),
                Text(
                  hStatistic.type!,
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                ),
                Text(
                  aStatistic.value.toString(),
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                ),
              ],
            ),
            SizedBox(
              height: 10,
            ),
            LinearProgressIndicator(
              value: hStatistic.value + aStatistic.value != 0 ? hStatistic.value/(hStatistic.value + aStatistic.value) : 1,
              color: HexColor(hColor),
              backgroundColor: HexColor(aColor),
            ),
          ],
        ),
        ),
      );
}
