import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hexcolor/hexcolor.dart';

import 'colors.dart';

ThemeData darktheme =ThemeData(
  primarySwatch: defaultcolor,//لون علامه اللودنج

  scaffoldBackgroundColor: HexColor('333739'),
  appBarTheme: AppBarTheme(
    titleSpacing: 20.0,
    iconTheme: IconThemeData(
        color: Colors.white
    ),
    backwardsCompatibility: false, //عشان اقدر اتجكم في ال status barالي فوق
    systemOverlayStyle: SystemUiOverlayStyle(
      statusBarIconBrightness: Brightness.light,
      statusBarColor:HexColor('333739') ,
    ),
    backgroundColor: HexColor('333739'),
    elevation: 0.0,
    titleTextStyle: TextStyle(
      color: Colors.white,
      fontWeight: FontWeight.bold,
      fontSize: 20.0,
    ),
  ),
  bottomNavigationBarTheme: BottomNavigationBarThemeData(
    type: BottomNavigationBarType.fixed,
    selectedItemColor: defaultcolor,
    unselectedItemColor: Colors.grey,
    elevation: 30.0,
    backgroundColor: HexColor('333739'),

  ),
  textTheme: TextTheme(
    bodyText1: TextStyle(
        fontWeight: FontWeight.w600,
        fontSize: 18.0,
        color: Colors.white
    ),
  ),
  fontFamily: 'Jannah'
);
ThemeData lighttheme = ThemeData(
  primarySwatch: defaultcolor,//لون علامه اللودنج

  scaffoldBackgroundColor: Colors.white,
  appBarTheme: AppBarTheme(
    titleSpacing: 20.0,
    iconTheme: IconThemeData(
        color: Colors.black
    ),
    backwardsCompatibility: false, //عشان اقدر اتجكم في ال status barالي فوق
    systemOverlayStyle: SystemUiOverlayStyle(
      statusBarIconBrightness: Brightness.dark,
      statusBarColor: Colors.white,
    ),
    backgroundColor: Colors.white,
    elevation: 0.0,
    titleTextStyle: TextStyle(
      color: Colors.black,
      fontWeight: FontWeight.bold,
      fontSize: 20.0,
    ),
  ),
  bottomNavigationBarTheme: BottomNavigationBarThemeData(
    type: BottomNavigationBarType.fixed,
    selectedItemColor: defaultcolor,
    unselectedItemColor: Colors.grey,
    elevation: 30.0,
    backgroundColor: Colors.white,
  ),
  textTheme: TextTheme(
    bodyText1: TextStyle(
        fontWeight: FontWeight.w600,
        fontSize: 18.0,
        color: Colors.black
    ),
  ),
  fontFamily: 'Jannah'
);