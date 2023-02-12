import 'package:buildcondition/buildcondition.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todoapp/shared/componants/componants.dart';
import 'package:todoapp/shared/componants/constants.dart';
import 'package:todoapp/shared/cubit/cubit.dart';
import 'package:todoapp/shared/cubit/states.dart';

class AddTaskScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
      listener: (BuildContext context, state) {},
      builder: (BuildContext context, state) {
        var tasks = AppCubit.get(context).newtasks;
        return BuildCondition(
          condition: tasks.isNotEmpty,
          builder: (context) => ListView.separated(
              itemBuilder: (context, index) =>
                  buildNewTaskItem(tasks[index], context),
              separatorBuilder: (context, index) => SizedBox(width: double.infinity,height: 1,),
              itemCount: tasks.length),
          fallback: (context) => Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.menu,
                  size: 120,
                  color: Colors.grey,
                ),
                Text(
                  'No Tasks yet ,please add some.',
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
    // return
  }
}
