import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app/layout/home_layout.dart';
import 'package:todo_app/shared/bloc_observer.dart';
import 'package:todo_app/shared/cubit/cubit.dart';
import 'package:todo_app/shared/cubit/states.dart';
import 'package:todo_app/shared/styels/themes.dart';

import 'network/local/cach_helper.dart';

Future<void> main() async {

  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer = MyBlocObserver();
  await CacheHelper.init();
  bool? isDark = CacheHelper.getBoolean(key: 'isDark');

  runApp( MyApp(isDark: isDark,));

}

class MyApp extends StatelessWidget {
  final bool? isDark ;

  MyApp({this.isDark});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AppCubit()..createDataBase(),
      child: BlocConsumer<AppCubit,AppStates>(
        listener: (context, state) {},
        builder: (context, state) => MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: lightTheme,
          darkTheme: darkTheme,
          themeMode: AppCubit.get(context).isDark ? ThemeMode.dark : ThemeMode.light,
          home: HomeLayout(),
        ),
      ),
    );
  }

}

