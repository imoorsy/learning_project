import 'package:buildcondition/buildcondition.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:todoapp/layout/sport_layout/cubit/cubit.dart';
import 'package:todoapp/layout/sport_layout/cubit/states.dart';
import 'package:todoapp/models/single_match_model.dart';
import 'package:todoapp/modules/sport_app/player_page/player_page.dart';
import 'package:todoapp/shared/componants/componants.dart';

class TabLienupsScreen extends StatelessWidget {
  const TabLienupsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SportCubit, SportStates>(
        builder: (context, state) {
          SportCubit cubit = SportCubit.get(context);
          return BuildCondition(
            condition: cubit.currentMatch != null,
            builder: (context) => BuildCondition(
              condition: cubit.currentMatch!.response![0].lineups!.isNotEmpty,
              builder: (context) {
                return DefaultTabController(
                  length: 2,
                  child: Container(
                    padding: EdgeInsets.all(20),
                    child: Column(
                      children: [
                        Container(
                          height: 30,
                          width: 250,
                          decoration: BoxDecoration(
                            color: Colors.grey[400],
                            borderRadius: BorderRadius.circular(50)
                          ),
                          child: TabBar(
                            indicator: BoxDecoration(
                              color: Colors.green[900],
                              borderRadius: BorderRadius.circular(50)
                            ),
                              labelColor: Colors.white,
                              unselectedLabelColor: Colors.black,
                              tabs: [
                                Tab(text: cubit.currentMatch!.response!.first.teams!.home!.name!,),
                                Tab(text: cubit.currentMatch!.response!.first.teams!.away!.name!,),
                              ]
                          ),
                        ),
                        SizedBox(height: 10,),
                        Expanded(
                          child: TabBarView(
                              children: [
                            SingleChildScrollView(
                              physics: BouncingScrollPhysics(),
                              child: Column(
                                children: [
                                  Container(
                                    height: 512,
                                    padding: EdgeInsets.symmetric(vertical: 20),
                                    decoration: BoxDecoration(
                                        image: DecorationImage(image: AssetImage('assets/image/Football_playground.png'),fit: BoxFit.contain)
                                    ),
                                    child: Column(
                                      mainAxisSize: MainAxisSize.max,
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      children: [
                                        buildLienupItem(context,cubit,cubit.currentMatch!.response![0].lineups!.first.startXI!.first.player!, cubit.currentMatch!.response![0].lineups!.first.team!.colors!),
                                        for (int i = 0; i < cubit.homeForm.length; i++)
                                          Container(
                                            height: 90,
                                            child: GridView.count(
                                              physics: NeverScrollableScrollPhysics(),
                                              shrinkWrap: true,
                                              crossAxisCount: cubit.homeForm[i], // Number of columns in the grid
                                              children: List.generate(cubit.homeForm[i], (index) {
                                                if (i == 0)
                                                  return buildLienupItem(context,cubit,cubit.currentMatch!.response!.first.lineups!.first.startXI![index + 1].player!, cubit.currentMatch!.response!.first.lineups!.first.team!.colors!);
                                                else if (i == 1)
                                                  return buildLienupItem(context,cubit,cubit.currentMatch!.response!.first.lineups!.first.startXI![index + cubit.homeForm[0] + 1].player!, cubit.currentMatch!.response!.first.lineups!.first.team!.colors!);
                                                else if (i == 2)
                                                  return buildLienupItem(context,cubit,cubit.currentMatch!.response!.first.lineups!.first.startXI![index + cubit.homeForm[1] + cubit.homeForm[0] + 1].player!, cubit.currentMatch!.response!.first.lineups!.first.team!.colors!);
                                                else if (i == 3)
                                                  return buildLienupItem(context,cubit,cubit.currentMatch!.response!.first.lineups!.first.startXI![index + cubit.homeForm[2] + cubit.homeForm[1] + cubit.homeForm[0] + 1].player!, cubit.currentMatch!.response!.first.lineups!.first.team!.colors!);
                                                else if (i == 4)
                                                  return buildLienupItem(context,cubit,cubit.currentMatch!.response!.first.lineups!.first.startXI![index + cubit.homeForm[3] + cubit.homeForm[2] +cubit.homeForm[1] +cubit.homeForm[0] + 1].player!, cubit.currentMatch!.response!.first.lineups!.first.team!.colors!);
                                                else
                                                  return buildLienupItem(context,cubit,cubit.currentMatch!.response!.first.lineups!.first.startXI![index + cubit.homeForm[4] + cubit.homeForm[3] +cubit.homeForm[2] + cubit.homeForm[1] +cubit.homeForm[0] + 1].player!, cubit.currentMatch!.response!.first.lineups!.first.team!.colors!);
                                              }),
                                            ),
                                          ),
                                      ],
                                    ),
                                  ),
                                  SizedBox(height: 15,),
                                  Row(
                                    children: [
                                      Text('Substitutes',style: TextStyle(fontSize: 25,fontWeight: FontWeight.bold),),
                                      SizedBox(width: 10,),
                                      CircleAvatar(radius: 15,backgroundImage: AssetImage('assets/image/substitute.jpg',),backgroundColor: Colors.transparent,),
                                    ],
                                  ),
                                  SizedBox(height: 15,),
                                  for(int i = 0; i < cubit.currentMatch!.response!.first.lineups!.first.substitutes!.length;i++)
                                    buildSubLineupItem(context, cubit,cubit.currentMatch!.response!.first.lineups!.first.substitutes![i].player!,cubit.currentMatch!.response!.first.lineups!.first.team!.colors!),
                                ],
                              ),
                            ),
                            SingleChildScrollView(
                              physics: BouncingScrollPhysics(),
                              child: Column(
                                children: [
                                  Container(
                                    height: 512,
                                    padding: EdgeInsets.symmetric(vertical: 20),
                                    decoration: BoxDecoration(
                                        image: DecorationImage(image: AssetImage('assets/image/Football_playground.png'),fit: BoxFit.contain)
                                    ),
                                    child: Column(
                                      mainAxisSize: MainAxisSize.max,
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      children: [
                                        for (int i = cubit.awayForm.length -1; i >= 0; i--)
                                          Container(
                                            height: 90,
                                            child: GridView.count(
                                              physics: NeverScrollableScrollPhysics(),
                                              shrinkWrap: true,
                                              crossAxisCount: cubit.awayForm[i], // Number of columns in the grid
                                              children: List.generate(cubit.awayForm[i], (index) {
                                                if (i == 0)
                                                  return buildLienupItem(context,cubit,cubit.currentMatch!.response!.first.lineups!.last.startXI![index + 1].player!, cubit.currentMatch!.response!.first.lineups!.last.team!.colors!);
                                                else if (i == 1)
                                                  return buildLienupItem(context,cubit,cubit.currentMatch!.response!.first.lineups!.last.startXI![index + cubit.awayForm[0] + 1].player!, cubit.currentMatch!.response!.first.lineups!.last.team!.colors!);
                                                else if (i == 2)
                                                  return buildLienupItem(context,cubit,cubit.currentMatch!.response!.first.lineups!.last.startXI![index + cubit.awayForm[1] + cubit.awayForm[0] + 1].player!, cubit.currentMatch!.response!.first.lineups!.last.team!.colors!);
                                                else if (i == 3)
                                                  return buildLienupItem(context,cubit,cubit.currentMatch!.response!.first.lineups!.last.startXI![index + cubit.awayForm[2] + cubit.awayForm[1] + cubit.awayForm[0] + 1].player!, cubit.currentMatch!.response!.first.lineups!.last.team!.colors!);
                                                else if (i == 4)
                                                  return buildLienupItem(context,cubit,cubit.currentMatch!.response!.first.lineups!.last.startXI![index + cubit.awayForm[3] + cubit.awayForm[2] +cubit.awayForm[1] +cubit.awayForm[0] + 1].player!, cubit.currentMatch!.response!.first.lineups!.last.team!.colors!);
                                                else
                                                  return buildLienupItem(context,cubit,cubit.currentMatch!.response!.first.lineups!.last.startXI![index + cubit.awayForm[4] + cubit.awayForm[3] +cubit.awayForm[2] + cubit.awayForm[1] +cubit.awayForm[0] + 1].player!, cubit.currentMatch!.response!.first.lineups!.last.team!.colors!);
                                              }),
                                            ),
                                          ),
                                        buildLienupItem(context,cubit,cubit.currentMatch!.response![0].lineups!.last.startXI!.first.player!, cubit.currentMatch!.response![0].lineups!.first.team!.colors!),
                                      ],
                                    ),
                                  ),
                                  SizedBox(height: 15,),
                                  Row(
                                    children: [
                                      Text('Substitutes',style: TextStyle(fontSize: 25,fontWeight: FontWeight.bold),),
                                      SizedBox(width: 10,),
                                      CircleAvatar(radius: 15,backgroundImage: AssetImage('assets/image/substitute.jpg',),backgroundColor: Colors.transparent,),
                                    ],
                                  ),
                                  SizedBox(height: 15,),
                                  for(int i = 0; i < cubit.currentMatch!.response!.first.lineups!.last.substitutes!.length;i++)
                                    buildSubLineupItem(context, cubit,cubit.currentMatch!.response!.first.lineups!.last.substitutes![i].player!,cubit.currentMatch!.response!.first.lineups!.last.team!.colors!),
                                ],
                              ),
                            ),
                          ]),
                        )
                      ],
                    ),
                  ),
                );
              },
              fallback: (context) => Center(
                  child: Text(
                'No Lienups',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
              )),
            ),
            fallback: (context) => Center(
                child: CircularProgressIndicator(
              color: Colors.green[700],
            )),
          );
        },
        listener: (context, state) {
          
        }
        );
  }



  Widget buildLienupItem(context,SportCubit cubit,LineupPlayer player,TeamColors colors) => InkWell(
    child: Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Stack(
          alignment: Alignment.lerp(Alignment.bottomCenter, Alignment.topCenter, -0.5)!,
          children: [
            Container(
              width: 40,
              height: 40,
              child: CircleAvatar(
                radius: 20,
                backgroundImage: NetworkImage("https://media-1.api-sports.io/football/players/${player.id}.png",),
              ),
              decoration: BoxDecoration(
                color: HexColor(colors.player!.border!),
                borderRadius: BorderRadius.circular(20),
              ),
            ),
            Container(
              width: 20,
              decoration: BoxDecoration(
                color: Colors.red,
              ),
              child: Text(player.number!.toString(),style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold),textAlign: TextAlign.center,),
            )
          ],
        ),
        SizedBox(height: 15,),
        Text(
          player.name!,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: TextStyle(
              fontSize: player.name!.length > 10 ? 12 : 14,
              fontWeight: FontWeight.bold
          ),
        ),
      ],
    ),
    onTap: (){
      print(player.id.toString());
      cubit.getPlayer(player.id!, cubit.currentMatch!.response!.first.league!.season!);
      navigatorGoto(context, PlayerScreen());
    },
  );

  Widget buildSubLineupItem(context,SportCubit cubit,LineupSubPlayer player,TeamColors colors) => InkWell(
    child: Container(
      margin: EdgeInsets.all(5),
      padding: EdgeInsets.all(20),
      color: Colors.grey[300]!.withOpacity(0.5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Container(
                width: 40,
                height: 40,
                child: CircleAvatar(
                  radius: 20,
                  backgroundImage: NetworkImage("https://media-1.api-sports.io/football/players/${player.id}.png",),
                ),
                decoration: BoxDecoration(
                  color: HexColor(colors.player!.border!),
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
              SizedBox(width: 10,),
              Text(player.name!,style: TextStyle(fontSize: 20,overflow: TextOverflow.ellipsis,fontWeight: FontWeight.bold,color: Colors.black),),
            ],
          ),
          Container(
            padding: EdgeInsets.all(5),
              color: HexColor(colors.player!.primary!),
              child: Text(
                player.number.toString(),style: TextStyle(fontSize: 22,color: HexColor(colors.player!.number!), fontWeight: FontWeight.bold),)
          ),
        ],
      ),
    ),
    onTap: (){
      print(player.id.toString());
      cubit.getPlayer(player.id!, cubit.currentMatch!.response!.first.league!.season!);
      navigatorGoto(context, PlayerScreen());
    },
  );

}
