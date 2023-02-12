import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:todoapp/modules/shop_app/login_screen/login_screen.dart';
import 'package:todoapp/shared/componants/componants.dart';
import 'package:todoapp/shared/network/local/cache_helper.dart';

ThemeData lightTheme = ThemeData(
  primarySwatch: Colors.amber,
  scaffoldBackgroundColor: Colors.white,
  appBarTheme: AppBarTheme(
    titleTextStyle: TextStyle(
      color: Colors.black,
      fontWeight: FontWeight.bold,
      fontSize: 30,
    ),
    iconTheme: IconThemeData(
      color: Colors.black,
    ),
    systemOverlayStyle: SystemUiOverlayStyle(
      statusBarColor: Colors.white,
      statusBarIconBrightness: Brightness.dark,
    ),
    backgroundColor: Colors.white,
    elevation: 0.0,
  ),
  bottomNavigationBarTheme: BottomNavigationBarThemeData(
    type: BottomNavigationBarType.fixed,
    elevation: 20,
    selectedItemColor: Colors.green,
    showSelectedLabels: false,
  ),
  textTheme: TextTheme(
      headline1: TextStyle(
        fontSize: 23,
        fontWeight: FontWeight.bold,
        color: Colors.black,
      )
  ),
);
ThemeData darkTheme = ThemeData(
  primarySwatch: Colors.amber,
  scaffoldBackgroundColor: HexColor('444444'),
  appBarTheme: AppBarTheme(
    titleTextStyle: TextStyle(
      color: Colors.white,
      fontWeight: FontWeight.bold,
      fontSize: 30,
    ),
    iconTheme: IconThemeData(
      color: Colors.white,
    ),
    systemOverlayStyle: SystemUiOverlayStyle(
      statusBarColor: HexColor('444444'),
      statusBarIconBrightness: Brightness.light,
    ),
    backgroundColor: HexColor('444444'),
    elevation: 0.0,
  ),
  bottomNavigationBarTheme: BottomNavigationBarThemeData(
    type: BottomNavigationBarType.fixed,
    elevation: 0.0,
    backgroundColor: HexColor('444444'),
    selectedItemColor: Colors.green,
    unselectedItemColor: Colors.grey,
    showSelectedLabels: false,
  ),
  textTheme: TextTheme(
      headline1: TextStyle(
        fontSize: 23,
        fontWeight: FontWeight.bold,
        color: Colors.white,
      )
  ),
);

ThemeData shopLightTheme = ThemeData(
  primarySwatch: Colors.amber,
  scaffoldBackgroundColor: Colors.white,
  appBarTheme: AppBarTheme(
    titleTextStyle: TextStyle(
      color: Colors.black,
      fontWeight: FontWeight.bold,
      fontSize: 30,
    ),
    iconTheme: IconThemeData(
      color: Colors.black,
    ),
    systemOverlayStyle: SystemUiOverlayStyle(
      statusBarColor: Colors.white,
      statusBarIconBrightness: Brightness.dark,
    ),
    backgroundColor: Colors.white,
    elevation: 0.0,
  ),
  bottomNavigationBarTheme: BottomNavigationBarThemeData(
    type: BottomNavigationBarType.fixed,
    elevation: 20,
    selectedItemColor: Colors.amber,
    showSelectedLabels: false,
    unselectedItemColor: Colors.grey,
  ),
  textTheme: TextTheme(
      headline1: TextStyle(
        fontSize: 23,
        fontWeight: FontWeight.bold,
        color: Colors.black,
      )
  ),
);
String token = '';

void signOut (context) {
  cacheHelper.removeData(key: 'token').then((value) {
    navigateAndFinish(context, ShopLoginScreen());
    showSnackBar(context, 'تم تسجيل الخروج بنجاح', SnackState.SUCCESS);
  });
}