import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hexcolor/hexcolor.dart';

ThemeData wzkorLight = ThemeData(
  primaryColor: Colors.black,
  canvasColor: HexColor('00ADB5'),
  cardColor: HexColor("EEEEEE"),
  appBarTheme: AppBarTheme(
      systemOverlayStyle: SystemUiOverlayStyle(
          statusBarIconBrightness: Brightness.dark,
          statusBarColor: HexColor('EEEEEE'),
          statusBarBrightness: Brightness.light),
      backgroundColor: HexColor('EEEEEE'),
      iconTheme: IconThemeData(
        size: 30,
        color: HexColor("303841"),
      )),
  scaffoldBackgroundColor: HexColor("D8E9A8"),
  bottomNavigationBarTheme: BottomNavigationBarThemeData(
      backgroundColor: Colors.white,
      unselectedItemColor: HexColor("3A4750"),
      unselectedIconTheme: IconThemeData(
        color: HexColor("3A4750"),
      ),
      // unselectedLabelStyle: ,
      selectedIconTheme:
      IconThemeData(color: HexColor('00ADB5'), size: 40)),
  textTheme: TextTheme(
    titleLarge: TextStyle(
      color: HexColor("3A4750"),
      fontSize: 30,
      fontWeight: FontWeight.bold,
    ),
    labelLarge: TextStyle(
      color: HexColor("00ADB5"),
      fontSize: 18,
      fontWeight: FontWeight.bold,
    ),
    titleMedium: TextStyle(
        color: HexColor("303841"),
        fontSize: 25,
        fontWeight: FontWeight.bold),
    labelMedium: TextStyle(
        color: HexColor("00ADB5"),
        fontSize: 18,
        fontWeight: FontWeight.bold),
    titleSmall: TextStyle(color: HexColor("303841"), fontSize: 30),
    labelSmall: TextStyle(
      fontSize: 20,
      fontWeight: FontWeight.bold,
    ),
  ),
);
ThemeData wzkorDark = ThemeData(
  primaryColor: Colors.white,
  canvasColor: HexColor('00ADB5'),
  cardColor: HexColor("3A4750"),
  appBarTheme: AppBarTheme(
      systemOverlayStyle: SystemUiOverlayStyle(
          statusBarIconBrightness: Brightness.light,
          statusBarColor: HexColor('3A4750'),
          statusBarBrightness: Brightness.light),
      backgroundColor: HexColor('3A4750'),
      iconTheme: IconThemeData(
        size: 30,
        color: Colors.white,
      )),
  scaffoldBackgroundColor: HexColor("303841"),
  bottomNavigationBarTheme: BottomNavigationBarThemeData(
      backgroundColor: HexColor('3A4750'),
      unselectedItemColor: Colors.white,
      unselectedIconTheme: IconThemeData(
        color: Colors.white,
      ),
      unselectedLabelStyle: TextStyle(color: Colors.white),
      selectedIconTheme:
      IconThemeData(color: HexColor('00ADB5'), size: 40)),
  textTheme: TextTheme(
    titleLarge: TextStyle(
      color: HexColor('D8E9A8'),
      fontSize: 30,
      fontWeight: FontWeight.bold,
    ),
    labelLarge: TextStyle(
      color: HexColor("00ADB5"),
      fontSize: 18,
      fontWeight: FontWeight.bold,
    ),
    titleMedium: TextStyle(
        color: Colors.white,
        fontSize: 25,
        fontWeight: FontWeight.bold),
    labelMedium: TextStyle(
        color: HexColor("00ADB5"),
        fontSize: 18,
        fontWeight: FontWeight.bold),
    titleSmall: TextStyle(color: HexColor("D8E9A8"), fontSize: 30),
    labelSmall: TextStyle(
      fontSize: 20,
      fontWeight: FontWeight.bold,
    ),
  ),
);