import 'package:buildcondition/buildcondition.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todoapp/shared/componants/componants.dart';
import 'package:todoapp/shared/cubit/cubit.dart';
import 'package:todoapp/shared/cubit/states.dart';

class DoneTaskScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
      listener: (BuildContext context, state) {},
      builder: (BuildContext context, state) {
        var tasks = AppCubit.get(context).donetasks;
        return BuildCondition(
          condition: tasks.isNotEmpty,
          builder: (context) => ListView.separated(
              itemBuilder: (context, index) =>
                  buildDoneTaskItem(tasks[index], context),
              separatorBuilder: (context, index) => SizedBox(height: 5,),
              itemCount: tasks.length),
          fallback: (context) => Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.download_done,
                  size: 120,
                  color: Colors.grey,
                ),
                Text(
                  'No Done Tasks yet ,please check some.',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.grey,
                  ),
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
