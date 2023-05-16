import 'package:buildcondition/buildcondition.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todoapp/layout/sport_layout/cubit/cubit.dart';
import 'package:todoapp/layout/sport_layout/cubit/states.dart';
import 'package:todoapp/models/head_to_head_model.dart';
import 'package:todoapp/modules/sport_app/match_page/match_page.dart';
import 'package:todoapp/shared/componants/componants.dart';
import 'package:todoapp/shared/componants/constants.dart';


class TabHToHScreen extends StatelessWidget {
  const TabHToHScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SportCubit, SportStates>(
        builder: (context, state) {
          SportCubit cubit = SportCubit.get(context);
          return BuildCondition(
            condition: cubit.headToHead != null,
            builder: (context) => ListView.separated(
                itemBuilder: (context, index) => buildMatchH2H(context,cubit.headToHead!.response![index]),
                separatorBuilder: (context, index)=> SizedBox(height: 10,),
                itemCount: cubit.headToHead!.response!.length),
            fallback: (context) => Center(child: Text('No Bast Matches')),
          );
        },
        listener: (context, state) {});
  }

  Widget buildMatchH2H(context,Response match) => Column(
    children: [
      Text('${DateTime.parse(match.fixture!.date!).year.toString()}-${DateTime.parse(match.fixture!.date!).month.toString()}-${DateTime.parse(match.fixture!.date!).day.toString()}',
      style: TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.bold,
      ),
      ),
      InkWell(
        splashColor: Colors.green[700],
        onTap: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) => const MatchScreen()));
          SportCubit.get(context).getMatch(match.fixture!.id!);
          print(match.fixture!.id!);
        },
        child: Container(
          height: 90,
          width: MediaQuery.of(context).size.width * 0.9,
          padding: const EdgeInsets.symmetric(vertical: 10),
          decoration: BoxDecoration(
            color: Colors.grey[300]!.withOpacity(0.5),
          ),
          child: Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
            Container(
              width: MediaQuery.of(context).size.width * 0.3,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  CachedNetworkImage(
                    imageUrl: match.teams!.home!.logo!,
                    width: 35,
                    height: 35,
                    fit: BoxFit.contain,
                  ),
                  SizedBox(height: 5,),
                  Text(
                    match.teams!.home!.name!,
                    maxLines: 1,
                    textAlign: TextAlign.center,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                        fontSize: 15, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
            Container(
              width: MediaQuery.of(context).size.width * 0.3,
              child: BuildCondition(
                condition: match.fixture!.status!.short == '1H' ||
                    match.fixture!.status!.short == '2H' ||
                    match.fixture!.status!.short == 'ET',
                builder: (context) => Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      match.goals!.home == null
                          ? '0'
                          : match.goals!.home.toString(),
                      style: TextStyle(
                          fontSize: 25,
                          fontWeight: FontWeight.bold,
                          color: Colors.black),
                    ),
                    const SizedBox(
                      width: 15,
                    ),
                    Stack(
                      alignment: Alignment.center,
                      children: [
                        const CircularProgressIndicator(
                          value: 1,
                          strokeWidth: 3,
                        ),
                        Text(
                          '${match.fixture!.status!.elapsed}\'',
                          style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Colors.blue),
                        ),
                      ],
                    ),
                    const SizedBox(
                      width: 15,
                    ),
                    Text(
                        match.goals!.away == null
                            ? '0'
                            : match.goals!.away.toString(),
                        style: TextStyle(
                            fontSize: 25,
                            fontWeight: FontWeight.bold,
                            color: Colors.black)),
                  ],
                ),
                fallback: (context) => BuildCondition(
                  condition: match.fixture!.status!.short == 'FT',
                  builder: (context) => Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Container(
                        color: Colors.black,
                        child: const Text(
                          'FT',
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              color: Colors.white, fontWeight: FontWeight.bold),
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Text(
                        '${match.goals!.home} : ${match.goals!.away}',
                        style: const TextStyle(
                            fontSize: 30,
                            fontWeight: FontWeight.bold,
                            color: Colors.black),
                      ),
                    ],
                  ),
                  fallback: (context) => BuildCondition(
                    condition: match.fixture!.status!.short == 'NS',
                    builder: (context) => Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          editMatchTime(
                              DateTime.parse(match.fixture!.date!).hour,
                              DateTime.parse(match.fixture!.date!).minute),
                          style: TextStyle(
                              fontSize: 21,
                              fontWeight: FontWeight.bold,
                              color: Colors.black87),
                        ),
                      ],
                    ),
                    fallback: (context) => BuildCondition(
                      condition: match.fixture!.status!.short == 'HT',
                      builder: (context) => Column(
                        children: [
                          Container(
                            color: Colors.green[700],
                            child: const Text(
                              'HT',
                              overflow: TextOverflow.ellipsis,
                              maxLines: 1,
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  color: Colors.white, fontWeight: FontWeight.bold),
                            ),
                          ),
                          Row(
                            children: [
                              Text(
                                match.goals!.home == null
                                    ? '0'
                                    : match.goals!.home.toString(),
                                style: const TextStyle(
                                    fontSize: 25,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.redAccent),
                              ),
                              const SizedBox(
                                width: 20,
                              ),
                              Stack(
                                alignment: Alignment.center,
                                children: [
                                  const CircularProgressIndicator(
                                    value: 1,
                                    strokeWidth: 3,
                                  ),
                                  Text(
                                    '${match.fixture!.status!.elapsed}\'',
                                    style: const TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.blue),
                                  ),
                                ],
                              ),
                              const SizedBox(
                                width: 20,
                              ),
                              Text(
                                match.goals!.away == null
                                    ? '0'
                                    : match.goals!.away.toString(),
                                style: const TextStyle(
                                    fontSize: 25,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.green),
                              ),
                            ],
                          ),
                        ],
                      ),
                      fallback: (context) => BuildCondition(
                        condition: match.fixture!.status!.short == 'BT',
                        builder: (context) => Column(
                          children: [
                            const Text(
                              'ET Break',
                              style: TextStyle(
                                  fontSize: 25,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.redAccent),
                            ),
                            Row(
                              children: [
                                Text(
                                  match.goals!.home == null
                                      ? '0'
                                      : match.goals!.home.toString(),
                                  style: TextStyle(
                                      fontSize: 25,
                                      fontWeight: FontWeight.bold,
                                      color: match.teams!.home!.winner!
                                          ? Colors.green
                                          : Colors.redAccent),
                                ),
                                const SizedBox(
                                  width: 20,
                                ),
                                Stack(
                                  alignment: Alignment.center,
                                  children: [
                                    const CircularProgressIndicator(
                                      value: 1,
                                      strokeWidth: 3,
                                    ),
                                    Text(
                                      '${match.fixture!.status!.elapsed}\'',
                                      style: const TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.blue),
                                    ),
                                  ],
                                ),
                                const SizedBox(
                                  width: 20,
                                ),
                                Text(
                                  match.goals!.away == null
                                      ? '0'
                                      : match.goals!.away.toString(),
                                  style: TextStyle(
                                      fontSize: 25,
                                      fontWeight: FontWeight.bold,
                                      color: match.teams!.away!.winner!
                                          ? Colors.green
                                          : Colors.red),
                                ),
                              ],
                            ),
                          ],
                        ),
                        fallback: (context) => BuildCondition(
                          condition: match.fixture!.status!.short == 'PST',
                          builder: (context) => Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Container(
                                  padding: EdgeInsets.symmetric(vertical: 5,horizontal: 15),
                                  decoration: BoxDecoration(
                                      color: Colors.red,
                                      borderRadius: BorderRadius.circular(20)
                                  ),
                                  child: Text(
                                    'مؤجل',
                                    style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          fallback: (context) => const Center(),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            Container(
              width: MediaQuery.of(context).size.width * 0.3,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  CachedNetworkImage(
                    imageUrl: match.teams!.away!.logo!,
                    width: 35,
                    height: 35,
                    fit: BoxFit.contain,
                  ),
                  SizedBox(height: 5,),
                  Text(
                    match.teams!.away!.name!,
                    maxLines: 1,
                    textAlign: TextAlign.center,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                        fontSize: 15, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
          ]),
        ),
      ),
    ],
  );

}
