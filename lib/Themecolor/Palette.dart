import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Palette {
  static const Color Kmain = Color(0xFF003049);

  static const Color Ksecondary = Color(0xFFf48668);

  static const Color Kwhite = Color(0xFFFDF0D5);

  static const Color Kblack = Colors.black;

  static const Color Kgrey = Colors.grey;
}

class RSHRMSTheme {
  ThemeData hrapptheme = ThemeData(
    bottomAppBarTheme: BottomAppBarTheme(
      color: Colors.grey[100],
    ),
    useMaterial3: true,
    cardTheme: CardThemeData(
      color: Palette.Kwhite,
      elevation: 10,
    ),
    scaffoldBackgroundColor: Colors.white,
    textTheme: GoogleFonts.poppinsTextTheme(Typography.blackCupertino),
    appBarTheme: AppBarTheme(
      centerTitle: true,
      elevation: 5,
      // backgroundColor: Colors.white,
    ),
    colorScheme: ColorScheme.fromSeed(
      seedColor: Palette.Kmain,
      brightness: Brightness.light,
      contrastLevel: 0.0,
    ),
  );
}
