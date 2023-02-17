

import 'package:flutter/material.dart';

class MyThemeData {
  static Color primary = Color(0xff232323);
  static Color blackColor = Color.fromARGB(255, 24, 24, 24);
  static Color wightColor = Colors.white;
  static Color containerColor = Color.fromARGB(255, 65, 64, 64);
  static Color containerLighterColor = Color.fromARGB(255, 143, 141, 141);
  static Color darkYelowColor = Color.fromARGB(255, 232, 207, 77);


  static ThemeData movieDarkMode = ThemeData(
    //disable splash button effects :
    splashColor: Colors.transparent,
    highlightColor: Colors.transparent,
    hoverColor: Colors.transparent,

    primaryColor: primary,
    canvasColor: containerColor,
    cardColor: containerLighterColor,
    scaffoldBackgroundColor: Colors.transparent,
    appBarTheme: AppBarTheme(
        centerTitle: true,
        titleTextStyle: TextStyle(color: wightColor, fontSize: 20),
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: IconThemeData(
            color: wightColor
        )
    ),
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
        selectedItemColor: darkYelowColor,
        unselectedItemColor: wightColor
    ),
    textTheme: TextTheme(
      headline1: TextStyle(fontSize: 14,
          fontWeight: FontWeight.w700,
          color: wightColor),
      headline2: TextStyle(fontSize: 10,
          fontWeight: FontWeight.bold,
          color: wightColor,),

      headline3:  TextStyle(fontSize: 21,
          color: wightColor),

      headline4:  TextStyle(fontSize: 13,
          color: wightColor),
    ),

  );
}