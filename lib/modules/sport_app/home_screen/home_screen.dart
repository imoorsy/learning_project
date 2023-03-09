import 'package:buildcondition/buildcondition.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todoapp/layout/sport_layout/cubit/cubit.dart';
import 'package:todoapp/layout/sport_layout/cubit/states.dart';
import 'package:todoapp/models/home_match_model.dart';
import 'package:todoapp/modules/sport_app/match_page/match_page.dart';
import 'package:todoapp/shared/componants/componants.dart';

class SportHomeScreen extends StatelessWidget {
  const SportHomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SportCubit,SportStates>(
        listener: (context,state){},
        builder: (context,state) {
          SportCubit cubit = SportCubit.get(context);
          return BuildCondition(
          condition: cubit.homeMatchModel == null && state is GetLoadingHomeDataSportState,
          builder:(context) => Center(child: CircularProgressIndicator()),
          fallback: (context) => BuildCondition(
            condition: cubit.homeMatchModel == null  && state is GetErrorHomeDataSportState,
            builder:(context) => Center(child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.mood_bad,size: 200,color: Colors.green[700],),
                Text('Somthing Went Wrong',
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                ),),
                SizedBox(height: 20,),
                InkWell(
                  splashColor: Colors.green[700],
                  onTap: (){
                    cubit.getMatchCenter();
                  },
                  child: Container(
                    color: Colors.grey.withOpacity(0.5),
                      padding: EdgeInsets.symmetric(horizontal: 20,vertical: 10),
                      child: Text('try again',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 22,color: Colors.black),)
                  ),
                ),
              ],
            )),
            fallback: (context) => SingleChildScrollView(
              child: Column(
                children: [
                  Column(
                    children: [
                      Container(width: double.infinity,color: Colors.grey[400],height: 40,child: Center(child: Text('UCL',style: TextStyle(color: Colors.black,fontSize: 25),)),),
                      ListView.separated(
                          physics: const NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemBuilder: (context, index) => buildMatchHomeItem(context,cubit.UCLMatches[index]),
                          separatorBuilder: (context, index) => const SizedBox(
                            height: 5,
                          ),
                          itemCount: cubit.UCLMatches.length)
                    ],
                  ),
                  Column(
                    children: [
                      Container(width: double.infinity,color: Colors.green[800],height: 35,child: Center(child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(Icons.sports_soccer),
                          Text('Egyption league',style: TextStyle(color: Colors.white,fontSize: 20),),
                        ],
                      )),),
                      ListView.separated(
                          physics: const NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemBuilder: (context, index) => buildMatchHomeItem(context,cubit.EgyptionLeague[index]),
                          separatorBuilder: (context, index) => const SizedBox(
                            height: 5,
                          ),
                          itemCount: cubit.EgyptionLeague.length)
                    ],
                  ),
                ],
              ),
            ),
          ),
    );
        });
  }

  Widget buildMatchHomeItem(context, HomeResponse model) => InkWell(
    splashColor: Colors.green[700],
    onTap: () {
      Navigator.push(context, MaterialPageRoute(builder: (context) => const MatchScreen()));
      SportCubit.get(context).getMatch(model.fixture!.id!);
      print(model.fixture!.id!);
    },
    child: Container(
      height: 110,
      width: MediaQuery.of(context).size.width * 0.9,
      padding: const EdgeInsets.symmetric(vertical: 10),
      decoration: BoxDecoration(
        color: Colors.grey[300]!.withOpacity(0.5),
      ),
      child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Container(
              width: MediaQuery.of(context).size.width * 0.3,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Image.network(
                    model.teams!.home!.logo!,
                    width: 50,
                    height: 50,
                    fit: BoxFit.contain,
                  ),
                  Text(
                    model.teams!.home!.name!,
                    maxLines: 2,
                    textAlign: TextAlign.center,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
            Container(
              width: MediaQuery.of(context).size.width * 0.3,
              child: BuildCondition(
                condition: model.fixture!.status!.short == '1H' || model.fixture!.status!.short == '2H' || model.fixture!.status!.short == 'ET',
                builder: (context) => Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      model.goals!.home == null ? '0' : model.goals!.home.toString(),
                      style: TextStyle(
                          fontSize: 25,
                          fontWeight: FontWeight.bold,
                          color: model.teams!.home!.winner == null ? Colors.black : model.teams!.home!.winner! ? Colors.green : Colors.redAccent),
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
                          '${model.fixture!.status!.elapsed}\'',
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
                        model.goals!.away == null ? '0' : model.goals!.away.toString(),
                        style: TextStyle(
                            fontSize: 25,
                            fontWeight: FontWeight.bold,
                            color: model.teams!.away!.winner == null ? Colors.black : model.teams!.away!.winner! ? Colors.green : Colors.redAccent)
                    ),
                  ],
                ),
                fallback:(context) => BuildCondition(
                  condition: model.fixture!.status!.short == 'FT',
                  builder: (context) => Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Container(
                          padding: const EdgeInsets.symmetric(horizontal: 15,vertical: 5),
                          decoration: const BoxDecoration(
                            color: Colors.black
                          ),
                          child: const Text('finish',
                            overflow: TextOverflow.ellipsis,
                            maxLines: 1,
                            textAlign:TextAlign.center,
                            style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),
                          ),
                      ),
                      const SizedBox(height: 20,),
                      Text(
                        '${model.goals!.home} : ${model.goals!.away}',
                        style: const TextStyle(
                            fontSize: 30,
                            fontWeight: FontWeight.bold,
                            color: Colors.black87),
                      ),
                    ],
                  ),
                  fallback: (context) => BuildCondition(
                    condition: model.fixture!.status!.short == 'NS',
                    builder: (context) => Column(
                      children: [
                        Text(
                          editMatchTime(DateTime.parse(model.fixture!.date!).hour, DateTime.parse(model.fixture!.date!).minute),
                          style: TextStyle(
                              fontSize: 21,
                              fontWeight: FontWeight.bold,
                              color: Colors.black87),
                        ),
                      ],
                    ),
                    fallback: (context) => BuildCondition(
                      condition: model.fixture!.status!.short == 'HT',
                      builder: (context) => Column(
                        children: [
                          const Text(
                            'haftime',
                            style: TextStyle(
                                fontSize: 25,
                                fontWeight: FontWeight.bold,
                                color: Colors.redAccent),
                          ),
                          Row(
                            children: [
                              Text(
                                model.goals!.home == null ? '0' : model.goals!.home.toString(),
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
                                    '${model.fixture!.status!.elapsed}\'',
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
                                model.goals!.away == null ? '0' : model.goals!.away.toString(),
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
                        condition: model.fixture!.status!.short == 'BT',
                        builder: (context) => Column(
                          children: [
                            const Text(
                              'Break ET',
                              style: TextStyle(
                                  fontSize: 25,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.redAccent),
                            ),
                            Row(
                              children: [
                                Text(
                                  model.goals!.home == null ? '0' : model.goals!.home.toString(),
                                  style: TextStyle(
                                      fontSize: 25,
                                      fontWeight: FontWeight.bold,
                                      color: model.teams!.home!.winner! ? Colors.green : Colors.redAccent),
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
                                      '${model.fixture!.status!.elapsed}\'',
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
                                  model.goals!.away == null ? '0' : model.goals!.away.toString(),
                                  style: TextStyle(
                                      fontSize: 25,
                                      fontWeight: FontWeight.bold,
                                      color: model.teams!.away!.winner! ? Colors.green : Colors.red),
                                ),
                              ],
                            ),
                          ],
                        ),
                        fallback: (context) => BuildCondition(
                          condition: model.fixture!.status!.short == 'PST',
                          builder: (context) => Column(
                            children: [
                              const Text(
                                'Postponed',
                                style: TextStyle(
                                    fontSize: 21,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.red),
                              ),
                            ],
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
                  Image.network(
                    model.teams!.away!.logo!,
                    width: 50,
                    height: 50,
                    fit: BoxFit.contain,
                  ),
                  Text(
                    model.teams!.away!.name!,
                    maxLines: 2,
                    textAlign: TextAlign.center,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
          ]
      ),
    ),
  );

}
