import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../shared/components/components.dart';
import '../shared/cubit/cubit.dart';
import '../shared/cubit/states.dart';

class NewTasks extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
     return BlocConsumer<AppCubit, AppStates>(
       listener: (context, state) {},
       builder: (context, state) {
       var tasks = AppCubit.get(context).newTasks;
       return tasksBuilder(
         tasks: tasks,
       );
  },);}
}
