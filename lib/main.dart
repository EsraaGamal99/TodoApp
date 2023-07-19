import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app/layout/home_layout.dart';
import 'package:todo_app/shared/bloc_observer.dart';
import 'package:todo_app/shared/cubit/cubit.dart';

import 'network/local/cach_helper.dart';

Future<void> main() async {
  Bloc.observer = MyBlocObserver();
  await CacheHelper.init();
  bool? isDark = CacheHelper.getBoolean(key: 'isDark');
  runApp( MyApp(isDark!));

}

class MyApp extends StatelessWidget {
  final bool isDark;

  MyApp(this.isDark);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AppCubit()..createDataBase()..changeThemeMode(modeFromShared: isDark,),
    );
    //MaterialApp(
    //         debugShowCheckedModeBanner: false,
    //         home: HomeLayout(),
    //       )
  }
}

