import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app/cubit/states.dart';


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