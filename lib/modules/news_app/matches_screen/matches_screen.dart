import 'package:buildcondition/buildcondition.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:todoapp/layout/news_layout/cubit/cubit.dart';
import 'package:todoapp/layout/news_layout/cubit/status.dart';
import 'package:todoapp/shared/componants/componants.dart';

class MatchesScreen extends StatelessWidget {
  const MatchesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return BlocConsumer<newsCubit, newsStates>(
        listener: (context,state){},
        builder:(context,state)  {
          var cubit = newsCubit.get(context);
          var matches = cubit.matches;
          return  Padding(
              padding: const EdgeInsets.all(15.0),
              child: BuildCondition(
                condition: state is newsChangeMatchesStates,
                fallback: (ctx) => BuildCondition(
                  condition: matches.isNotEmpty,
                  builder:(ctx) => SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          width: double.infinity,
                          child: IconButton(
                            color: cubit.isDark ? Colors.white : Colors.black,
                            icon: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.calendar_month,
                                  size: 50,
                                  color: Colors.green,
                                ),
                                SizedBox(
                                  width: 15.0,
                                ),
                                Text(
                                  '${cubit.selectDate}',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontSize: 30,
                                    color: cubit.isDark ? Colors.white : Colors.black,
                                  ),
                                )
                              ],
                            ),
                            onPressed: () {
                              {
                                showDatePicker(
                                  context: context,
                                  initialDate: DateTime.now(),
                                  firstDate: DateTime.parse('2017-11-15'),
                                  lastDate: DateTime.parse('2100-11-15'),
                                ).then((value) {
                                  cubit.selectDate = DateFormat.yMd().format(value!).toString();
                                  cubit.changeMatches(value.toString());
                                }).catchError((error) {
                                  print("set date Erorr ${error.toString()}");
                                });
                              }
                            },
                          ),
                        ),
                        SizedBox(
                          height: 50,
                        ),
                        ListView.separated(
                            physics: NeverScrollableScrollPhysics(),
                            shrinkWrap: true ,
                            itemBuilder: (context, index) => buildMatchAppItem(matches[index], context),
                            separatorBuilder: (context, index) => Container(width: double.infinity,height: 1,color: Colors.white,),
                            itemCount: matches.length),
                      ],
                    ),
                  ),
                  fallback: (ctx) => Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Container(
                          width: double.infinity,
                          child: IconButton(
                            color: cubit.isDark ? Colors.white : Colors.black,
                            icon: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.calendar_month,
                                  size: 50,
                                  color: Colors.green,
                                ),
                                SizedBox(
                                  width: 15.0,
                                ),
                                Text(
                                  '${cubit.selectDate}',
                                  style: TextStyle(
                                      fontSize: 30,
                                      color: cubit.isDark ? Colors.white : Colors.black,
                                  ),
                                )
                              ],
                            ),
                            onPressed: () {
                              {
                                showDatePicker(
                                  context: context,
                                  initialDate: DateTime.now(),
                                  firstDate: DateTime.parse('2017-11-15'),
                                  lastDate: DateTime.parse('2100-11-15'),
                                ).then((value) {
                                  cubit.selectDate = DateFormat.yMd().format(value!).toString();
                                  cubit.changeMatches(value.toString());
                                }).catchError((error) {
                                  print("set date Erorr ${error.toString()}");
                                });
                              }
                            },
                          ),
                        ),
                        SizedBox(height: 200,),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image.network('https://seeklogo.com/images/Q/qatar-2022-logo-5010B2F302-seeklogo.com.png?v=637830203480000000',scale: 1.5,),
                            SizedBox(height: 20,),
                            Text('OOPS!',
                              style: Theme.of(context).textTheme.bodyText1,),
                            SizedBox(height: 20,),
                            Text('No World Cup Matches For Today',
                              style: TextStyle(
                                fontSize: 25,
                                color: Colors.white,

                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                builder: (ctx) => Center(child: CircularProgressIndicator(color: Colors.green,)),
              ),
            );
        }
    );
  }
}

