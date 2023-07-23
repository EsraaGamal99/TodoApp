import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:todo_app/styles/colors.dart';

ThemeData lightTheme = ThemeData(
  scaffoldBackgroundColor: Colors.white,
  textTheme: TextTheme(
    bodyLarge: TextStyle(
      fontSize: 17.0,
      fontWeight: FontWeight.w600,
      color: Colors.black,
    ),
    bodySmall:  TextStyle(
      fontSize: 14.0,
      fontWeight: FontWeight.w600,
      color: Colors.white,
      height: 1.2,
    ),
  ),
  appBarTheme: AppBarTheme(
    backgroundColor: Colors.white,
    titleSpacing: 20.0,
    elevation: 0.0,
    titleTextStyle: TextStyle(
      fontSize: 20.0,
      fontWeight: FontWeight.bold,
      color: defaultColoForLightModer,
      fontFamily: 'jannah',
    ),
    toolbarTextStyle:
    TextStyle(
      fontSize: 18.0,
      color: Colors.black,
      fontWeight: FontWeight.w600,
    ),
    iconTheme: IconThemeData(
      color: defaultColoForLightModer,
    ),
    systemOverlayStyle: SystemUiOverlayStyle(
      statusBarColor: Colors.white,
      statusBarIconBrightness: Brightness.dark,
    ),
  ),
  bottomNavigationBarTheme: BottomNavigationBarThemeData(
    backgroundColor: defaultColoForLightModer,
    type: BottomNavigationBarType.fixed,
    selectedItemColor: selectedItemColorForLightMode,
    unselectedItemColor: Colors.white,
    elevation: 20.0,

  ),


  fontFamily: 'jannah',
  primarySwatch: defaultColoForLightModer,

);



ThemeData darkTheme = ThemeData(
  scaffoldBackgroundColor: Color(0xFF333739),
  textTheme: TextTheme(
    bodyLarge: TextStyle(
      fontSize: 18.0,
      fontWeight: FontWeight.w600,
      color: Colors.white,
    ),
    bodyMedium: TextStyle(
      fontSize: 14.0,
      fontWeight: FontWeight.w600,
      color: Colors.white,
      height: 1.2,
    ),
  ),
  bottomNavigationBarTheme: BottomNavigationBarThemeData(
    backgroundColor: Colors.purple,
    //Color(0xFF854E6B),
    type: BottomNavigationBarType.fixed,
    selectedItemColor: selectedItemColorForLightMode,
    unselectedItemColor: Colors.white,
    elevation: 20.0,

  ),
  appBarTheme: AppBarTheme(
    backgroundColor: Color(0xFF333739),
    titleSpacing: 20.0,
    elevation: 0.0,
    titleTextStyle: TextStyle(
      fontSize: 20.0,
      fontWeight: FontWeight.bold,
      color: Colors.white,
      fontFamily: 'jannah',
    ),
    toolbarTextStyle:
    TextStyle(
      fontSize: 18.0,
      color: Colors.white,
      fontWeight: FontWeight.w600,
    ),
    iconTheme: IconThemeData(
      color: Colors.white,
    ),
    systemOverlayStyle: SystemUiOverlayStyle(
      statusBarColor: Color(0xFF333739),
      statusBarIconBrightness: Brightness.light,
    ),
  ),
  fontFamily: 'jannah',
  primarySwatch: defaultColoForDarkModer,
bottomSheetTheme: BottomSheetThemeData(
  modalBackgroundColor: Colors.red,
  dragHandleColor: Colors.red,
  modalBarrierColor: Colors.red,
  shadowColor: Colors.red,
  surfaceTintColor: Colors.red,
  backgroundColor: Colors.red,
),
);