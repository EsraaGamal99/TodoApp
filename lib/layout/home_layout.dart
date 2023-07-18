import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:todo_app/shared/components/components.dart';
import 'package:todo_app/shared/cubit/cubit.dart';
import 'package:todo_app/shared/cubit/states.dart';

class HomeLayout extends StatelessWidget {

  var scaffoldKey = GlobalKey<ScaffoldState>();
  var formKey = GlobalKey<FormState>();

  var timeController = TextEditingController();
  var dateController = TextEditingController();
  var titleController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => AppCubit()..createDataBase(),
      child: BlocConsumer<AppCubit, AppStates>(
        listener: (BuildContext context, AppStates state) {},
        builder: (BuildContext context, AppStates state) {
          AppCubit cubit = AppCubit.get(context);
          return Scaffold(
              key: scaffoldKey,
              appBar: AppBar(
                title: Center(
                  child: Text(
                    cubit.titles[cubit.currentIndex],
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              body: ConditionalBuilder(
                condition: state != AppGetDatabaseLoadingState(),
                builder: (context) => cubit.screens[cubit.currentIndex],
                fallback: (context) =>
                    Center(child: CircularProgressIndicator()),),
              floatingActionButton: FloatingActionButton(
              onPressed: ()
          {
            if (cubit.isBottomSheetShown) {
              if (formKey.currentState!.validate()) {
                cubit.insertToDataBase(
                  title: titleController.text,
                  date: dateController.text,
                  time: timeController.text,
                ).then((value){
                  Navigator.pop(context);
                  cubit.isBottomSheetShown = false;
                  cubit.fabIcon = Icons.edit;
                });
              }
            }
            else {
              scaffoldKey.currentState!.showBottomSheet((context) =>
                    Container(
                      color: Colors.white,
                      padding: EdgeInsets.all(15.0,),
                      child: Form(
                        key: formKey,
                        child: Column(

                          mainAxisSize: MainAxisSize.min,
                          children: [
                            // Title Field
                            defaultTextFormField(
                              keyboardType: TextInputType.text,
                              controller: titleController,
                              validate: (String? value) {
                                if (value!.isEmpty) {
                                  return 'TITLE';
                                }
                                return null;
                              },
                              labelText: 'Title',
                              prefixIcon: Icons.title,
                            ),

                            SizedBox(
                              height: 15.0,
                            ),

                            // Date Field
                            defaultTextFormField(
                              keyboardType: TextInputType.text,
                              controller: dateController,
                              validate: (String? value) {
                                if (value!.isEmpty) {
                                  return 'Date';
                                }
                                return null;
                              },
                              labelText: 'Date',
                              prefixIcon: Icons.calendar_month_outlined,
                              onTap: () {
                                showDatePicker(
                                  context: context,
                                  initialDate: DateTime.now(),
                                  firstDate: DateTime.now(),
                                  lastDate: DateTime.parse('2025-12-30'),
                                ).then((value) {
                                  dateController.text =
                                      DateFormat.yMMMd().format(value!);
                                  print(DateFormat.yMMMd().format(value));
                                });
                              },
                            ),

                            SizedBox(
                              height: 15.0,
                            ),

                            // Time Field
                            defaultTextFormField(
                              keyboardType: TextInputType.text,
                              controller: timeController,
                              validate: (String? value) {
                                if (value!.isEmpty) {
                                  return 'Time';
                                }
                                return null;
                              },
                              onTap: () {
                                showTimePicker(
                                  context: context,
                                  initialTime: TimeOfDay.now(),
                                ).then((value) {
                                  timeController.text =
                                      (value!.format(context)).toString();
                                  print(value.format(context));
                                });
                              },
                              labelText: 'Time',
                              prefixIcon: Icons.access_time_filled,
                            ),
                          ],
                        ),
                      ),
                    ),
                elevation: 15.0,
              ).closed.then((value) {
                    cubit.ChangeBottomSheetState(isShow: false, icon: Icons.edit);
              });
              cubit.ChangeBottomSheetState(isShow: true, icon: Icons.add);
            }
          },
          child: Icon(
          cubit.fabIcon,
          ),
          ),
          bottomNavigationBar: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          currentIndex: cubit.currentIndex,
          onTap: (index) {
          cubit.changeIndex(index);
          print(cubit.currentIndex);
          },
          items: [
          BottomNavigationBarItem(
          icon: Icon(Icons.menu),
          label: 'Tasks',
          ),
          BottomNavigationBarItem(
          icon: Icon(Icons.check_box),
          label: 'Done',
          ),
          BottomNavigationBarItem(
          icon: Icon(Icons.archive_outlined),
          label: 'Archived',
          ),
          ],),
          );
          },
      ),
    );
  }}

