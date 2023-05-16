import 'package:buildcondition/buildcondition.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:todoapp/shared/componants/componants.dart';
import 'package:todoapp/shared/cubit/cubit.dart';
import 'package:todoapp/shared/cubit/states.dart';

class HomePageScreen extends StatelessWidget
{
  // ********** Variables **********

  var titleTextController = TextEditingController();
  var timeTextController = TextEditingController();
  var dateTextController = TextEditingController();


  var scaffoldKey = GlobalKey<ScaffoldState>();
  var formKey = GlobalKey<FormState>();




  // @override
  // void initState() {
  //   super.initState();
  //   createDatabase();
  // }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => AppCubit()..createDatabase(),
      child: BlocConsumer<AppCubit,AppStates>(
        listener: (BuildContext context,AppStates state) {
          if (state is AppInsertDatabaseStates) {
            Navigator.pop(context);
          }
        },
        builder: (BuildContext context,AppStates state) {
          AppCubit cubit = AppCubit.get(context);
          return Scaffold(
            key: scaffoldKey,
            appBar: AppBar(
              backgroundColor: Colors.transparent,
              elevation: 0,
              toolbarHeight: 100,
              title: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 50.0,),
                child: Text(
                  cubit.tabTitles[cubit.currentTab],
                  style: const TextStyle(
                      fontSize: 40,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                  ),
                ),
              ),
              actions: [
                IconButton(
                  icon: Icon(
                      Icons.settings,
                  color: Colors.blue,
                  size: 35,),
                  onPressed: () {

                  },
                ),
                SizedBox(width: 20,)
              ],
            ),
            body: BuildCondition(
                condition: state is! AppGetDatabaseLoadingStates,
                builder: (context) => cubit.screens[cubit.currentTab],
                fallback: (context) => Center(child: CircularProgressIndicator()),
            ),
            floatingActionButton: FloatingActionButton(
                onPressed: () {
                  var time = DateTime.now();
                  if(timeTextController.text == '') {
                    timeTextController.text = DateFormat('jm').format(time);
                  }
                  if(dateTextController.text == '') {
                    dateTextController.text = DateFormat.yMMMd().format(time);
                  }
                  if (cubit.bottomSheetShow) {
                    if (formKey.currentState!.validate()) {
                      cubit.insertDatabase(
                        title: titleTextController.text,
                        date: dateTextController.text,
                        time: timeTextController.text,
                      );

                      titleTextController.text = '';
                      dateTextController.text = '';
                      timeTextController.text = '';

                      cubit.bottomSheetShow = false;
                    }
                  } else {
                    scaffoldKey.currentState?.showBottomSheet((context) => Container(
                      color: Colors.white,
                      padding: const EdgeInsets.all(20.0),
                      child: Form(
                        key: formKey,
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            defaultTextFormField(
                              context,
                              controller: titleTextController,
                              keyboardtype: TextInputType.text,
                              labelText: 'Task Title...',
                              submitFunction: (value) {},
                              validator: (value) {
                                if (value.isEmpty) {
                                  return 'title can\'t ba empty';
                                }
                                return null;
                              },
                              prefix: Icons.title,
                            ),
                            const SizedBox(
                              height: 15.0,
                            ),
                            defaultTextFormField(
                              context,
                              controller: timeTextController,
                              keyboardtype: TextInputType.none,
                              labelText: 'Task Time...',
                              submitFunction: (value) {},
                              validator: (value) {
                                if (value.isEmpty) {
                                  return 'time can\'t ba empty';
                                }
                                return null;
                              },
                              onTap: () {
                                showTimePicker(
                                    context: context,
                                    initialTime: TimeOfDay.now())
                                    .then((value) {
                                  timeTextController.text =
                                      value!.format(context).toString();
                                  print(value.format(context));
                                });
                              },
                              prefix: Icons.watch_later_outlined,
                            ),
                            const SizedBox(
                              height: 15.0,
                            ),
                            defaultTextFormField(
                              context,
                              controller: dateTextController,
                              keyboardtype: TextInputType.none,
                              labelText: 'Task Date...',
                              validator: (value) {
                                if (value.isEmpty) {
                                  return 'date can\'t ba empty';
                                }
                                return null;
                              },
                              onTap: () {
                                showDatePicker(
                                  context: context,
                                  initialDate: DateTime.now(),
                                  firstDate: DateTime.now(),
                                  lastDate: DateTime.parse('2100-11-15'),
                                ).then((value) {
                                  dateTextController.text =
                                      DateFormat.yMMMd().format(value!);
                                });
                              },
                              prefix: Icons.calendar_month,
                            ),
                          ],
                        ),
                      ),
                    ),
                      elevation: 20.0,
                    ).closed.then((value) {
                      cubit.changeBottomSheet(bottomsheetshow: false, floatIcon: Icons.add_task);
                    });
                    cubit.changeBottomSheet(bottomsheetshow: true, floatIcon: Icons.save_outlined);
                  }
                },
                child: Icon(cubit.floaticon)),
            bottomNavigationBar: BottomNavigationBar(
                type: BottomNavigationBarType.fixed,
                backgroundColor: Colors.transparent,
                elevation: 0.0,
                selectedFontSize: 17,
                selectedItemColor: Colors.blue,
                selectedLabelStyle: const TextStyle(fontWeight: FontWeight.bold),
                showUnselectedLabels: false,
                showSelectedLabels: true,
                iconSize: 30.0,
                unselectedItemColor: Colors.blue[200],
                currentIndex: cubit.currentTab,
                onTap: (index) {
                  cubit.changeNavbar(index);
                },
                items: const [
                  BottomNavigationBarItem(
                    icon: Icon(Icons.task_alt),
                    label: 'tasks',
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(Icons.check_box_outlined),
                    label: 'Done',
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(Icons.archive_outlined),
                    label: 'Archived',
                  ),
                ]),
          );
        },
      ),
    );
  }
}
