import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sqflite/sqflite.dart';
import 'package:todoapp/modules/todo_app/add_task/add_task_screen.dart';
import 'package:todoapp/modules/todo_app/archived_task/archived_task_screen.dart';
import 'package:todoapp/modules/todo_app/done_task/done_task_screen.dart';
import 'package:todoapp/shared/cubit/states.dart';

class AppCubit extends Cubit<AppStates> {
  AppCubit() : super(AppInitialStates());
  int currentTab = 0;
  List<Widget> screens = [
    AddTaskScreen(),
    DoneTaskScreen(),
    ArchivedTaskScreen(),
  ];

  List<String> tabTitles = [
    'Today',
    'Done',
    'Archived',
  ];
  
  static AppCubit get(BuildContext context) => BlocProvider.of(context);

  
  void changeNavbar(int index) {
    currentTab = index;
    emit(AppChangeNavbarStates());
  }

  // **************Database*****************
  List<Map> tasks = [];
  List<Map> newtasks = [];
  List<Map> donetasks = [];
  List<Map> archivedtasks = [];
  late Database dataBase;

  void createDatabase() {
    openDatabase('todo.db', version: 1,
        onCreate: (dataBase, version) {
          // id integer primary key
          // title String
          // date String
          // time String
          // status String
          dataBase
              .execute(
              'CREATE TABLE tasks (id INTEGER PRIMARY KEY,title TEXT, date TEXT, time TEXT, status TEXT)')
              .then((value) {
            print('Table Created');
          }).catchError((error) {
            print('We Find error : ${error.toString()}');
          });
          print('Database Created');
        },
        onOpen: (dataBase) async {
          getDataFromDatabase(dataBase);
          print('Database Opened');
        }).then((value) {
          dataBase = value;
          emit(AppCreateDatabaseStates());
    });
  }

  insertDatabase({
    required String title,
    required String time,
    required String date,
  }) async {
    await dataBase.transaction((txn) async {
      await txn.rawInsert(
          'INSERT INTO tasks(title, date, time, status) VALUES("$title", "$date", "$time", "new")');

    }).then((value) {
      print('$value inserted sucssesfully');
      emit(AppInsertDatabaseStates());
      getDataFromDatabase(dataBase);
    }).catchError((error) {
      print("error in insert New data ${error.toString()}");
    });
  }

// 1. Create DB
// 2. Open DB
// 3. Create Tables
// 4. Insert Values
// 5.Get Date From DB
// 6. Update Values
// 7. Delete Values
// 8. Close DB

void updateData({
  required String status,
  required int id,
}) {
    dataBase.rawUpdate(
      'UPDATE tasks SET status = ? WHERE id = ?',
      ['$status', id]).then((value) {
        getDataFromDatabase(dataBase);
        emit(AppUpdateDatabaseStates());
    });
}

  void deleteData({
    required int id,
  }) {
    dataBase.rawDelete('DELETE FROM tasks WHERE id = ?',[id]).then((value) {
      getDataFromDatabase(dataBase);
      emit(AppUpdateDatabaseStates());
    });
  }

void getDataFromDatabase(dataBase) {

    newtasks = [];
    donetasks = [];
    archivedtasks = [];
    emit(AppGetDatabaseLoadingStates());
    dataBase.rawQuery('SELECT * FROM tasks').then((value) {
      tasks = value;
      tasks.forEach((element) {
        if(element['status'] == 'new')
          newtasks.add(element);
        else if(element['status'] == 'done')
          donetasks.add(element);
        else archivedtasks.add(element);
      });

      emit(AppGetDatabaseStates());
    });
}

  bool bottomSheetShow = false;
  IconData floaticon = Icons.add_task;

  void changeBottomSheet({
    required bool bottomsheetshow,
    required IconData floatIcon,
  }) {
    bottomSheetShow = bottomsheetshow;
    floaticon = floatIcon;

    emit(AppChangeBottomSheetStates());
  }

}