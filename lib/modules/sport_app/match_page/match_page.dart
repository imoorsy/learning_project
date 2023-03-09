import 'package:buildcondition/buildcondition.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todoapp/layout/sport_layout/cubit/cubit.dart';
import 'package:todoapp/layout/sport_layout/cubit/states.dart';
import 'package:todoapp/shared/componants/componants.dart';

class MatchScreen extends StatelessWidget {
  const MatchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SportCubit, SportStates>(
      listener: (context, state) {},
      builder: (context, state) {
        SportCubit cubit = SportCubit.get(context);
        return Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
            systemOverlayStyle: SystemUiOverlayStyle(
                statusBarBrightness: Brightness.light,
                statusBarColor: Colors.green[700]),
            toolbarHeight: 270,
            leading: Text(''),
            flexibleSpace: Container(
              decoration: BoxDecoration(
                color: Colors.green[700],
                borderRadius: BorderRadius.only(bottomRight: Radius.circular(30),bottomLeft: Radius.circular(30))
              ),
              child: BuildCondition(
                condition: cubit.currentMatch != null,
                builder: (context) => Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        IconButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            icon: Icon(
                              Icons.arrow_back_ios,
                              size: 35,
                            )),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.sports_soccer,
                              size: 45,
                              color: Colors.white,
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Text(
                              'Moccer',
                              style: TextStyle(
                                  fontSize: 30, fontWeight: FontWeight.bold,),
                            ),
                          ],
                        ),
                        IconButton(
                            onPressed: () {},
                            icon: Icon(
                              Icons.dark_mode,
                              color: Colors.black87,
                              size: 35,
                            )),
                      ],
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Container(
                          width: MediaQuery.of(context).size.width * 0.3,
                          child: Column(
                            children: [
                              Image.network(
                                cubit.currentMatch!.response!.first.teams!.home!
                                    .logo!,
                                width: 70,
                                height: 70,
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              Text(
                                cubit.currentMatch!.response!.first.teams!.home!
                                    .name!,
                                maxLines: 2,
                                textAlign: TextAlign.center,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 22,
                                    color: Colors.white),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          width: MediaQuery.of(context).size.width * 0.3,
                          child: Column(
                            children: [
                              Container(
                                padding: EdgeInsets.symmetric(horizontal: 15,vertical: 5),
                                decoration: BoxDecoration(
                                  color: Colors.black
                                ),
                                child: Text(
                                  'finished',
                                  style: TextStyle(
                                      fontSize: 18,
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                              SizedBox(height: 20,),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(Icons.timelapse,color: Colors.amber,),
                                  SizedBox(width: 10,),
                                  Text(editMatchTime(DateTime.parse(cubit.currentMatch!.response!.first.fixture!.date!).hour, DateTime.parse(cubit.currentMatch!.response!.first.fixture!.date!).minute),
                                  style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold,color: Colors.white),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 40,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    cubit.currentMatch!.response!.first.goals!.home
                                        .toString(),
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 30,
                                        color: Colors.white),
                                  ),
                                  SizedBox(
                                    width: 40,
                                  ),
                                  Text(
                                    cubit.currentMatch!.response!.first.goals!.away
                                        .toString(),
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 30,
                                        color: Colors.white),
                                  )
                                ],
                              ),
                            ],
                          ),
                        ),
                        Container(
                          width: MediaQuery.of(context).size.width * 0.3,
                          child: Column(
                            children: [
                              Image.network(
                                cubit.currentMatch!.response!.first.teams!.away!
                                    .logo!,
                                width: 70,
                                height: 70,
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              Text(
                                cubit.currentMatch!.response!.first.teams!.away!
                                    .name!,
                                maxLines: 2,
                                textAlign: TextAlign.center,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 22,
                                    color: Colors.white),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                fallback: (context) => Center(),
              ),
            ),
          ),
          body: BuildCondition(
            condition: cubit.currentMatch != null,
            builder: (context) => Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Text(cubit.currentMatch!.response!.length.toString()),
                  Text(cubit.currentMatch!.response!.first.teams!.home!.name!),
                  Text(cubit.currentMatch!.response!.first.teams!.away!.name!),
                ],
              ),
            ),
            fallback: (context) => Center(child: CircularProgressIndicator()),
          ),
        );
      },
    );
  }
}
