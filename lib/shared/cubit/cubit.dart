import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sqflite/sqflite.dart';
import 'package:todo_app/shared/cubit/states.dart';

import '../../modules/archived_tasks.dart';
import '../../modules/done_tasks.dart';
import '../../modules/new_tasks.dart';

class AppCubit extends Cubit<AppStates>{
  AppCubit() : super(AppInitialState());

  static AppCubit get(context)=> BlocProvider.of(context);

  int currentIndex = 0;
  List<Map> newTasks=[];
  List<Map> doneTasks=[];
  List<Map> archivedTasks=[];
  bool isBottomSheetShown = false;
  IconData fabIcon = Icons.edit;
  List<Widget> screens = [
    NewTasks(),
    DoneTasks(),
    ArchivedTasks(),
  ];
  List<String> titles = [
    'New Tasks',
    'Done Tasks',
    'Archived Tasks',
  ];

  Database database;

  void changeIndex(int index){
    currentIndex = index;
    emit(AppChangeBottomNavBarState());
  }

  void createDataBase() {

    openDatabase(
      'todoDatabase.db',
      version: 1,
      onCreate: (database, version) {
        print('DataBase Created');

        database
            .execute(
            'CREATE TABLE Tasks (id INTEGER PRIMARY KEY, name TEXT, date TEXT, time TEXT,status TEXT)')
            .then((value) {
          print('Tables Created');
        }).catchError((Error) {
          print('Error when creating tables ${Error.toString()}');
        });
      },
      onOpen: (database) {
        print('DataBase Opened');
        getDataFromDatabase(database);
      },
    ).then((value) {
      database = value;
      emit(AppCrateDatabaseState());
    });
  }

  Future insertToDataBase(
      {
        @required String title,
        @required String time,
        @required String date,

      }) async {
    return await database.transaction(
          (txn) {
        txn
            .rawInsert(
            'INSERT INTO Tasks (name,date,time,status) VALUES ("$title","$date","$time","New")')
            .then((value) {
          print(' $value Insert Successfully');
          emit(AppInsertDataToDatabaseState());
          getDataFromDatabase(database);
        }).catchError((error) {
          print('Error when Inserting to Database ${error.toString()}');
        });

        return null;
      },
    );
  }

  void getDataFromDatabase(database) {

    emit(AppGetDatabaseLoadingState());

     database.rawQuery('SELECT * FROM Tasks').then((value) {

       value.forEach((element){
         if (element['status']=='new')
              newTasks.add(element);
         else if (element['statue'] == 'done')
              doneTasks.add(element);
         else
           archivedTasks.add(element);
       });
      emit(AppGetDataFromDatabaseState());
    });
  }

  void ChangeBottomSheetState({
    @required bool isShow,
    @required IconData icon,
}){
    isBottomSheetShown = isShow;
    fabIcon =icon;

    emit(AppChangeBottomSheetState());
  }

  void deleteData({
    @required int id,
  }) async{
    database.rawDelete('DELETE FROM Tasks WHERE id = ?', ['$id']).then((value) {

      emit(AppDeleteDataFromDatabaseState());
    });


  }

  void updateData({
    @required String status,
    @required int id,
}) async {
     database.rawUpdate(
        'UPDATE Tasks SET status = ?, id = ? WHERE id = ?',
        ['$status', '$id']).then((value) {
       emit(AppUpdateDataToDatabaseState());
     }

     );


  }
}