import 'package:buildcondition/buildcondition.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todoapp/layout/sport_layout/cubit/cubit.dart';
import 'package:todoapp/layout/sport_layout/cubit/states.dart';

class TabPositionScreen extends StatelessWidget {
  const TabPositionScreen({Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SportCubit, SportStates>(
        builder: (context, state) {
          SportCubit cubit = SportCubit.get(context);
          return BuildCondition(
            condition: cubit.leaguePosition != null,
            builder:(context) => SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              physics: BouncingScrollPhysics(),
              child: RefreshIndicator(
                onRefresh: cubit.getSelctedMatch,
                child: SingleChildScrollView(
                  physics: BouncingScrollPhysics(),
                  child: DataTable(
                    columns: <DataColumn>[
                      DataColumn(
                        label: Text('rank',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 16,color: Colors.black54),),
                      ),
                      DataColumn(
                        label: Text('logo',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 18,color: Colors.black54),),
                      ),
                      DataColumn(
                        label: Text('name',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 18,color: Colors.black54),),
                      ),
                      DataColumn(
                        label: Text('points',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 16,color: Colors.black54),),
                      ),
                      DataColumn(
                        label: Text('P'),
                      ),
                      DataColumn(
                        label: Text('W',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 16,color: Colors.green),),
                      ),
                      DataColumn(
                        label: Text('D',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 16,color: Colors.grey),),
                      ),
                      DataColumn(
                        label: Text('L',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 16,color: Colors.red),),
                      ),
                      DataColumn(
                        label: Text('In',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 16,color: Colors.black54),),
                      ),
                      DataColumn(
                        label: Text('out',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 16,color: Colors.black54),),
                      ),
                      DataColumn(
                        label: Text('in-out',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 16,color: Colors.black54),),
                      ),
                      DataColumn(
                        label: Text('last 5',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 16,color: Colors.black54),),
                      ),


                    ],
                    rows: cubit.leaguePosition!.response!.first.league!.standings!.map(
                          (item) => DataRow(cells: [
                        DataCell(Text(item.rank.toString())),
                        DataCell(CachedNetworkImage(imageUrl: item.team!.logo!,width: 30,height: 30,)),
                        DataCell(Text(item.team!.name!,style: TextStyle(fontWeight: FontWeight.bold,fontSize: 18,color: Colors.black),)),
                        DataCell(Text(item.points.toString(),style: TextStyle(fontWeight: FontWeight.bold,fontSize: 16,color: Colors.green[900]),)),
                        DataCell(Text(item.all!.played.toString())),
                        DataCell(Text(item.all!.win.toString(),style: TextStyle(fontWeight: FontWeight.bold,fontSize: 16,color: Colors.green),)),
                        DataCell(Text(item.all!.draw.toString(),style: TextStyle(fontWeight: FontWeight.bold,fontSize: 16,color: Colors.grey),)),
                        DataCell(Text(item.all!.lose.toString(),style: TextStyle(fontWeight: FontWeight.bold,fontSize: 16,color: Colors.red),)),
                        DataCell(Text(item.all!.goals!.forIt.toString(),style: TextStyle(fontWeight: FontWeight.bold,fontSize: 16,color: Colors.blue),)),
                        DataCell(Text(item.all!.goals!.againstIt.toString(),style: TextStyle(fontWeight: FontWeight.bold,fontSize: 16,color: Colors.red),)),
                        DataCell(Text('${item.all!.goals!.forIt! - item.all!.goals!.againstIt!}')),
                        DataCell(editTeamForm(item.form!)),
                      ]),
                    ).toList(),
                  ),
                ),
              ),
            ),
            fallback: (context) => Center(child: CircularProgressIndicator(color: Colors.green,)),
          );
        },
        listener: (context, state) {});
  }

  Widget editTeamForm(String form) => Row(
    children: [
      for(int i = 0; i< form.length; i++)
        BuildCondition(
          condition: form[i] == 'W',
          builder: (context) => Container(padding: EdgeInsets.all(5),decoration: BoxDecoration(color:Colors.green,),child: Text('W',style: TextStyle(fontSize: 10,color: Colors.white,fontWeight: FontWeight.bold),)),
          fallback: (context) => BuildCondition(
            condition: form[i] == 'D',
            builder: (context) => Container(padding: EdgeInsets.all(5),decoration: BoxDecoration(color:Colors.grey,),child: Text('D',style: TextStyle(fontSize: 10,color: Colors.black,fontWeight: FontWeight.bold),)),
            fallback: (context) => Container(padding: EdgeInsets.all(5),decoration: BoxDecoration(color:Colors.red,),child: Text('L',style: TextStyle(fontSize: 10,color: Colors.white,fontWeight: FontWeight.bold),)),
          ),
        ),
    ],
  );
}