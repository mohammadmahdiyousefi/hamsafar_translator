import 'package:flutter/material.dart';

class CustomTheme {
  static final ThemeData darkThem = ThemeData(
      useMaterial3: true,
      navigationBarTheme: NavigationBarThemeData(
        height: 65,
        elevation: 0,
        labelBehavior: NavigationDestinationLabelBehavior.onlyShowSelected,
        indicatorShape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        indicatorColor:
            const Color.fromARGB(255, 255, 255, 255).withOpacity(0.2),
        backgroundColor: const Color(0xFF2A64F9),
        labelTextStyle: MaterialStateTextStyle.resolveWith(
          (states) => const TextStyle(
              color: Color(0xFFFFFFFF),
              fontFamily: "ROBR",
              fontWeight: FontWeight.w400,
              fontSize: 12),
        ),
      ),
      appBarTheme: const AppBarTheme(
        titleTextStyle: TextStyle(
            color: Color(0xFFFFFFFF),
            fontFamily: "ROBM",
            fontWeight: FontWeight.w400,
            fontSize: 18),
      ),
      listTileTheme: const ListTileThemeData(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(14))),
        tileColor: Color(0xFF28282a),
        titleTextStyle: TextStyle(
            fontFamily: "ROBR",
            fontSize: 14,
            fontWeight: FontWeight.w400,
            overflow: TextOverflow.ellipsis,
            color: Color(0xFFFFFFFF)),
        subtitleTextStyle: TextStyle(
            fontFamily: "ROBR",
            fontSize: 12,
            fontWeight: FontWeight.w300,
            overflow: TextOverflow.ellipsis,
            color: Color(0xff8E8E8E)),
      ),
      textTheme: const TextTheme(
        displayLarge: TextStyle(
            color: Color(0xFFFFFFFF),
            fontFamily: "ROBR",
            fontWeight: FontWeight.w500,
            fontSize: 22),
        bodyLarge: TextStyle(
            color: Color(0xFFFFFFFF),
            fontFamily: "ROBR",
            fontWeight: FontWeight.w500,
            fontSize: 16),
        bodyMedium: TextStyle(
            color: Color(0xFFFFFFFF),
            fontFamily: "ROBR",
            fontWeight: FontWeight.w500,
            fontSize: 14),
        bodySmall: TextStyle(
            color: Color(0xFFFFFFFF),
            fontFamily: "ROBR",
            fontWeight: FontWeight.w500,
            fontSize: 12),
      ),
      iconTheme: const IconThemeData(color: Colors.white),
      cardColor: const Color(0xFF28282a),
      primaryColor: const Color(0xFF2A64F9),
      colorScheme: darkColorScheme);

  static final ThemeData lightTheme = ThemeData(
      useMaterial3: true,
      navigationBarTheme: NavigationBarThemeData(
        height: 65,
        elevation: 0,
        labelBehavior: NavigationDestinationLabelBehavior.onlyShowSelected,
        indicatorShape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        indicatorColor:
            const Color.fromARGB(255, 255, 255, 255).withOpacity(0.2),
        backgroundColor: const Color(0xFF2A64F9),
        labelTextStyle: MaterialStateTextStyle.resolveWith(
          (states) => const TextStyle(
              color: Color(0xFFFFFFFF),
              fontFamily: "ROBR",
              fontWeight: FontWeight.w400,
              fontSize: 12),
        ),
      ),
      appBarTheme: const AppBarTheme(
        titleTextStyle: TextStyle(
            color: Color(0xFF000000),
            fontFamily: "ROBM",
            fontWeight: FontWeight.w400,
            fontSize: 18),
      ),
      listTileTheme: const ListTileThemeData(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(14))),
        tileColor: Colors.white,
        titleTextStyle: TextStyle(
            fontFamily: "ROBR",
            fontSize: 14,
            fontWeight: FontWeight.w400,
            overflow: TextOverflow.ellipsis,
            color: Color(0xff000000)),
        subtitleTextStyle: TextStyle(
            fontFamily: "ROBR",
            fontSize: 12,
            fontWeight: FontWeight.w300,
            overflow: TextOverflow.ellipsis,
            color: Color(0xff8E8E8E)),
      ),
      textTheme: const TextTheme(
        displayLarge: TextStyle(
            color: Color(0xFF000000),
            fontFamily: "ROBR",
            fontWeight: FontWeight.w500,
            fontSize: 22),
        bodyLarge: TextStyle(
            color: Color(0xFF000000),
            fontFamily: "ROBR",
            fontWeight: FontWeight.w500,
            fontSize: 16),
        bodyMedium: TextStyle(
            color: Color(0xFF000000),
            fontFamily: "ROBR",
            fontWeight: FontWeight.w500,
            fontSize: 14),
        bodySmall: TextStyle(
            color: Color(0xFF000000),
            fontFamily: "ROBR",
            fontWeight: FontWeight.w500,
            fontSize: 12),
      ),
      iconTheme: const IconThemeData(color: Colors.black),
      cardColor: const Color(0xFFFFFFFF),
      primaryColor: const Color(0xFF2A64F9),
      colorScheme: lightColorScheme);
}

const lightColorScheme = ColorScheme(
  brightness: Brightness.light,
  background: Color(0xffedeff2),
  onBackground: Color(0xFF1f1f1f),
  primary: Color(0xFF2A64F9),
  onPrimary: Color(0xFFFFFFFF),
  primaryContainer: Color(0xFFDEE0FF),
  onPrimaryContainer: Color(0xFF000F5C),
  secondary: Color(0xFF3A52CB),
  onSecondary: Color(0xFFFFFFFF),
  secondaryContainer: Color(0xFFDEE0FF),
  onSecondaryContainer: Color(0xFF00115A),
  tertiary: Color(0xFF4758AC),
  onTertiary: Color(0xFFFFFFFF),
  tertiaryContainer: Color(0xFFDEE1FF),
  onTertiaryContainer: Color(0xFF001258),
  error: Color(0xFFBA1A1A),
  errorContainer: Color(0xFFFFDAD6),
  onError: Color(0xFFFFFFFF),
  onErrorContainer: Color(0xFF410002),
  surface: Color(0xFFFFFBFF),
  onSurface: Color(0xFF1B1B1F),
  surfaceVariant: Color(0xFFE3E1EC),
  onSurfaceVariant: Color(0xFF46464F),
  outline: Color(0xFF767680),
  onInverseSurface: Color(0xFFF3F0F4),
  inverseSurface: Color(0xFF303034),
  inversePrimary: Color(0xFFBBC3FF),
  shadow: Color(0xFF000000),
  surfaceTint: Color(0xFF2748EE),
  outlineVariant: Color(0xFFC7C5D0),
  scrim: Color(0xFF000000),
);

const darkColorScheme = ColorScheme(
  brightness: Brightness.dark,
  background: Color(0xFF1f1f1f),
  onBackground: Color(0xffedeff2),
  primary: Color(0xFF2A64F9),
  onPrimary: Color(0xFF000F5C),
  primaryContainer: Color(0xFFDEE0FF),
  onPrimaryContainer: Color(0xFF000F5C),
  secondary: Color(0xFF3A52CB),
  onSecondary: Color(0xFF00115A),
  secondaryContainer: Color(0xFFDEE0FF),
  onSecondaryContainer: Color(0xFF00115A),
  tertiary: Color(0xFF4758AC),
  onTertiary: Color(0xFFFFFFFF),
  tertiaryContainer: Color(0xFFDEE1FF),
  onTertiaryContainer: Color(0xFF001258),
  error: Color(0xFFFFB4AB),
  errorContainer: Color(0xFF93000A),
  onError: Color(0xFF690005),
  onErrorContainer: Color(0xFFFFDAD6),
  surface: Color(0xFF1B1B1F),
  onSurface: Color(0xffefefef),
  surfaceVariant: Color(0xFF46464F),
  onSurfaceVariant: Color(0xFFC7C5D0),
  outline: Color(0xFF91909A),
);
