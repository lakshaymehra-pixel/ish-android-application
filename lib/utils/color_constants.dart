import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:tejas_loan/utils/shared_constants.dart';

import '../main.dart';

class ColorConstants {
  static const primaryColor = 0xFF52bbad;
  static const primaryColorDark = 0xFF52bbad;

  static const contrainerColorLight = 0xFFffffff;
  static const contrainerColorDark = 0xFF434343;

  static const textColorLight = 0xFF000000;
  static const textColorDark = 0xFFFFFFFF;

  // static const primaryColor2 = 0xFF235595;
  static const secondaryColor = 0xFF225e83;
  static const tertiaryColor = 0xFF225e83;

// static const secondaryColor2 = 0xFF18b8d8;

  static ThemeData themeLight = ThemeData(
    useMaterial3: false,
    primaryColor: const Color(ColorConstants.primaryColor),
    scaffoldBackgroundColor: Colors.white,
    highlightColor: Colors.white,
    shadowColor: Colors.black54,
    textTheme: TextTheme(
        headlineLarge: TextStyle(
          color: Colors.black,
          fontSize: 18.sp,
          fontWeight: FontWeight.bold,
        ),
        /** heading For General */
        headlineMedium: TextStyle(
          fontSize: 16.sp,
          color: Colors.black54,
          fontWeight: FontWeight.w500,
        ),
        /** Sub heading For General */
        titleSmall: TextStyle(
          letterSpacing: 1.sp,
          fontSize: 15.sp,
          fontWeight: FontWeight.w600,
          color: Colors.black,
        ),
        /** TextField Text*/
        titleMedium: TextStyle(fontWeight: FontWeight.w500, fontSize: 16.sp, color: Colors.black),
        /** heading textField Text*/
        titleLarge: TextStyle(
          letterSpacing: 0.sp,
          fontSize: 17.sp,
          color: Colors.black54,
          fontWeight: FontWeight.w400,
        ) /** hint text */
        ),
    appBarTheme: const AppBarTheme(
      elevation: 0,
      backgroundColor: Color(ColorConstants.primaryColor),
      iconTheme: IconThemeData(color: Colors.white),
    ),
  );
  static ThemeData themeDark = ThemeData(
    useMaterial3: false,
    highlightColor: const Color(ColorConstants.contrainerColorDark),
    primaryColor: const Color(ColorConstants.primaryColorDark),
    scaffoldBackgroundColor: Colors.black,
    shadowColor: Colors.white,
    appBarTheme: const AppBarTheme(
      elevation: 0,
      backgroundColor: Color(ColorConstants.primaryColorDark),
      iconTheme: IconThemeData(color: Colors.black),
    ),
    textTheme: TextTheme(
        headlineLarge: TextStyle(
          color: Colors.white,
          fontSize: 18.sp,
          fontWeight: FontWeight.bold,
        ),
        /** heading For General */
        headlineMedium: TextStyle(
          fontSize: 16.sp,
          color: const Color(0XFF7C8083),
          fontWeight: FontWeight.w500,
        ),
        /** Sub heading For General */
        titleSmall: TextStyle(
          letterSpacing: 1.sp,
          fontSize: 15.sp,
          fontWeight: FontWeight.w600,
          color: Colors.white,
        ),
        /** TextField Text*/
        titleMedium: TextStyle(fontWeight: FontWeight.w500, fontSize: 16.sp, color: Colors.white),
        /** heading textField Text*/
        titleLarge: TextStyle(
          letterSpacing: 0.sp,
          fontSize: 17.sp,
          color: const Color(0XFFA0A0A0),
          fontWeight: FontWeight.w400,
        ) /** hint text */
        ),
  );

  static getBrightColorARD(BuildContext context) {
    if ((prefs.getBool(SharedConstants.THEME) ?? false)) {
      return Brightness.light;
    } else {
      return Brightness.dark;
    }
  }

  static getBrightColorIOS(BuildContext context) {
    if ((prefs.getBool(SharedConstants.THEME) ?? false)) {
      return Brightness.dark;
    } else {
      return Brightness.light;
    }
  }
}
