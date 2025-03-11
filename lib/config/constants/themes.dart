import 'package:flutter/material.dart';
import 'app_colors.dart';

final ThemeData darkTheme = ThemeData.dark();
final ThemeData lightTheme = ThemeData.light();
final ThemeData baseTheme = ThemeData(
  colorScheme: ColorScheme.fromSeed(seedColor: AppColors.purpleColor),
  scaffoldBackgroundColor: Colors.white,
  appBarTheme: AppBarTheme(backgroundColor: Colors.transparent),
  useMaterial3: true,
  bottomSheetTheme: BottomSheetThemeData(backgroundColor: Colors.transparent),
);
