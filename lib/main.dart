import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app/cubit/cubit.dart';
import 'package:todo_app/cubit/states.dart';
import 'package:todo_app/shared/bloc_observer.dart';
import 'package:todo_app/styles/themes.dart';
import 'layout/home_layout.dart';
import 'network/local/cach_helper.dart';

Future<void> main() async {

  WidgetsFlutterBinding.ensureInitialized();
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
    return
         BlocProvider(
           create: (context) => FirstCubit()..changeThemeMode(modeFromShared: isDark,),
           child: BlocConsumer<FirstCubit,FirstStates>(
             listener: (context, state) {},
             builder: (context, state) {
               return MaterialApp(
                 debugShowCheckedModeBanner: false,
                 theme: lightTheme,
                 darkTheme: darkTheme,
                 themeMode: FirstCubit.get(context).isDark ? ThemeMode.dark : ThemeMode.light,
                 home: HomeLayout(),
               );
             },

           ),
         );

  }
}

