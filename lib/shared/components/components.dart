import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:todo_app/shared/cubit/cubit.dart';

Widget defaultButton({
  double width = double.infinity,
  Color backgroundColor = Colors.indigoAccent,
  double radius = 0.0,
  bool isUpperCase = true,
  required Function onPressed,
  required String text,
}) =>
    Container(
      width: width,
      child: MaterialButton(

        child: Text(
          isUpperCase ? text.toUpperCase() : text,
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        onPressed: (){
      onPressed();
      },
      )
      ,
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(radius),
      ),
    );

Widget defaultTextFormField({
  required TextInputType keyboardType,
  required TextEditingController controller,
  Function(String)? onFieldSubmitted,
  onChanged,
  bool isPassword = false,
  required String? Function(String?) validate,
  required String labelText,
  required IconData prefixIcon,
  IconData? suffixIcon,
  Function? suffixPressed,
  String? text,
  onTap,
}) =>
    TextFormField(
      controller: controller,
      keyboardType: keyboardType,
      onFieldSubmitted: onFieldSubmitted,
      onChanged: onChanged,
      onTap: onTap,
      validator: validate,
      obscureText: isPassword,
      decoration: InputDecoration(
        labelText: labelText,
        border: OutlineInputBorder(),
        prefixIcon: Icon(
          prefixIcon,
        ),
        suffixIcon: suffixIcon!=null
            ? IconButton(icon: Icon(suffixIcon),
          onPressed: () {
              suffixPressed!();
              },) : null,
        ),
    );

Widget buildTaskItem(Map model , context)=>
    Dismissible(
     // key: UniqueKey(),
      child: Padding(
  padding: const EdgeInsets.all(20.0),
  child: Row(
      children: [
        CircleAvatar(
          radius: 40.0,
          child: Text(
            '${model['time']}',
          ),
        ),
        SizedBox(
          width: 15.0,
        ),
        Expanded(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '${model['name']}',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20.0,
                ),
              ),

              Text(
                '${model['date']}',
                style: TextStyle(
                  color: Colors.grey,
                  fontSize: 20.0,
                ),
              ),
            ],
          ),
        ),
        SizedBox(
          width: 15.0,
        ),

        IconButton(onPressed: (){
          AppCubit.get(context).updateData(status: 'done', id: model['id'],);},
            icon: Icon(
          Icons.check_circle,
          color: Colors.teal,

        )
        ),
        IconButton(onPressed: (){
          AppCubit.get(context).updateData(status: 'archived', id: model['id'],);},
            icon: Icon(
          Icons.archive_outlined,
          color: Colors.blueGrey,
        )
        ),

      ],
  ),
),

      onDismissed: (direction ) {
        AppCubit.get(context).deleteData(id: model['id'],);
      }, key: Key(model['id'].toString(),),
    );

Widget tasksBuilder(
{
  required List<Map> tasks,
}
    ) => ConditionalBuilder(
  condition: tasks.length > 0,
  builder:(context) => ListView.separated(

    itemBuilder: (context, index) => buildTaskItem(tasks[index], context),
    separatorBuilder: (context, index) => Container(
      width: double.infinity,
      color: Colors.blueGrey[100],
      height: 1.0,
    ),
    itemCount: tasks.length,
  ),
  fallback: (context) => Center(
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(Icons.menu,
          size: 100.0,
          color: Colors.grey,),
        Text('No Tasks Yet, Please add Some Tasks',
          style: TextStyle(
            fontSize: 16.0,
            fontWeight: FontWeight.bold,
            color: Colors.grey,
          ),)
      ],
    ),
  ),
);
