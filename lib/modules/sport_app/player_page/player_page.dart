import 'package:buildcondition/buildcondition.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todoapp/layout/sport_layout/cubit/cubit.dart';
import 'package:todoapp/layout/sport_layout/cubit/states.dart';
import 'package:todoapp/models/player_model.dart';

class PlayerScreen extends StatelessWidget {
  const PlayerScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SportCubit, SportStates>(
      listener: (context, state) {},
      builder: (context, state) {
        SportCubit cubit = SportCubit.get(context);
        return SafeArea(
          child: Scaffold(
            body: BuildCondition(
              condition: cubit.playerModel != null,
              builder: (context) {
                Response player = cubit.playerModel!.response!.first;
                return Column(
                children: [
                  Container(
                    height:300,
                    padding: const EdgeInsets.all(10),
                    color: Colors.green[900],
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            IconButton(onPressed: (){
                              Navigator.pop(context);
                            },
                                icon: const Icon(Icons.arrow_back_ios,color: Colors.white,size: 30,)),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: const [
                                Icon(
                                  Icons.sports_soccer,
                                  size: 45,
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                Text(
                                  'Moccer',
                                  style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold,color: Colors.white),
                                ),
                              ],
                            ),
                            IconButton(onPressed: (){}, icon: const Icon(Icons.favorite_border,color: Colors.grey,size: 30,))
                          ],
                        ),
                        Stack(
                          alignment: const Alignment(0, 1.5),
                          children: [
                            CircleAvatar(
                              radius: 60,
                              backgroundImage: NetworkImage(player.player!.photo!),
                            ),
                            Container(
                              padding: const EdgeInsets.all(8),
                              decoration: const BoxDecoration(
                                color: Colors.white,
                              ),
                                child: Text('${player.player!.age.toString()} year',style: const TextStyle(fontWeight: FontWeight.bold,fontSize: 18),)
                            ),
                          ],
                        ),
                        const SizedBox(height: 40,),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Column(
                              children: [
                                const Icon(Icons.flag,color: Colors.white,size: 30,),
                                Text(player.player!.nationality!,style: const TextStyle(fontSize: 20,fontWeight: FontWeight.bold,color: Colors.grey),),
                              ],
                            ),
                            Column(
                              children: [
                                const Icon(Icons.stadium,color: Colors.white,size: 30,),
                                Text(player.statistics!.first.team!.name!,style: const TextStyle(fontSize: 20,fontWeight: FontWeight.bold,color: Colors.grey),),
                              ],
                            ),
                            Column(
                              children: [
                                const Icon(Icons.height,color: Colors.white,size: 30,),
                                Text(player.player!.height!,style: const TextStyle(fontSize: 20,fontWeight: FontWeight.bold,color: Colors.grey),),
                              ],
                            ),
                            Column(
                              children: [
                                const Icon(Icons.person,color: Colors.white,size: 30,),
                                Text(player.player!.weight!,style: const TextStyle(fontSize: 20,fontWeight: FontWeight.bold,color: Colors.grey),),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),

                ],
              );
              },
              fallback: (context) => const Center(child: CircularProgressIndicator()),
            ),
          ),
        );
      },
    );
  }
}
