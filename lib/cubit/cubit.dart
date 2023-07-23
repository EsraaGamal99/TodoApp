import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sqflite/sqflite.dart';
import 'package:todo_app/cubit/states.dart';
import 'package:todo_app/shared/app_cubit/states.dart';

import '../../modules/archived_tasks.dart';
import '../../modules/done_tasks.dart';
import '../../modules/new_tasks.dart';
import '../../network/local/cach_helper.dart';

class FirstCubit extends Cubit<FirstStates>{
  FirstCubit() : super(FirstInitialState());

  static FirstCubit get(context)=> BlocProvider.of(context);


  bool isDark = false;

  changeThemeMode({
    bool? modeFromShared,
  }) {
    if (modeFromShared != null) {
      isDark = modeFromShared;
      emit(FirstChangeMode());
    } else {
      isDark = !isDark;
      CacheHelper.putBoolean(key: 'isDark', value: isDark).then((value) {
        emit(FirstChangeMode());
      });
    }
    print(' DARK MoDE IS $isDark');
  }
}