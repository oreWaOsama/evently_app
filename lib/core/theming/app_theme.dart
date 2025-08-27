import 'package:evently_app/core/theming/colors_manager.dart';
import 'package:evently_app/core/theming/text_styles.dart';
import 'package:flutter/material.dart';

class AppTheme {
  static final ThemeData lightTheme = ThemeData(
    appBarTheme: AppBarTheme(
      backgroundColor: ColorsManager.transparentColor,
      iconTheme: IconThemeData(color: ColorsManager.primaryLight),
    ),

    focusColor: ColorsManager.whiteColor,
    primaryColor: ColorsManager.primaryLight,
    highlightColor: ColorsManager.whiteColor,
    scaffoldBackgroundColor: ColorsManager.whiteBgColor,
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      elevation: 0,
      showUnselectedLabels: true,
      selectedItemColor: ColorsManager.whiteColor,
      selectedLabelStyle: TextStyles.bold12White,
      unselectedLabelStyle: TextStyles.bold12White,
    ),
    floatingActionButtonTheme: FloatingActionButtonThemeData(
      iconSize: 35,
      backgroundColor: ColorsManager.primaryLight,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadiusGeometry.circular(35),
        side: BorderSide(color: ColorsManager.whiteColor, width: 6),
      ),
    ),
    textTheme: TextTheme(
      headlineLarge: TextStyles.bold20Black,
      headlineMedium: TextStyles.bold20Black,
      headlineSmall: TextStyles.medium16Primary,
      bodyLarge: TextStyles.bold16Black,
    ),
  );

  static final ThemeData darkTheme = ThemeData(
    appBarTheme: AppBarTheme(
      backgroundColor: ColorsManager.transparentColor,
      iconTheme: IconThemeData(color: ColorsManager.primaryLight),
    ),
    highlightColor: ColorsManager.primaryDark,
    focusColor: ColorsManager.primaryLight,
    primaryColor: ColorsManager.primaryDark,
    scaffoldBackgroundColor: ColorsManager.primaryDark,
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      elevation: 0,
      showUnselectedLabels: true,
      selectedLabelStyle: TextStyles.bold12White,
      unselectedLabelStyle: TextStyles.bold12White,
    ),
    floatingActionButtonTheme: FloatingActionButtonThemeData(
      backgroundColor: ColorsManager.primaryDark,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadiusGeometry.circular(35),
        side: BorderSide(color: ColorsManager.whiteColor, width: 6),
      ),
    ),
    textTheme: TextTheme(
      headlineLarge: TextStyles.bold20White,
      headlineMedium: TextStyles.bold20Black,
      headlineSmall: TextStyles.medium16White,
      bodyLarge: TextStyles.bold16White,
    ),
  );
}
