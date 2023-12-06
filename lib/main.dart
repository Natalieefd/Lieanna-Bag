import 'dart:ui';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lienna_bag/Provider/themeMode.dart';
import 'package:lienna_bag/firebase_options.dart';
import 'package:lienna_bag/page/introduction.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => ThemeModeData()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeModeData>(
      builder: (context, themeModeData, child) {
        ThemeData themeData;

        switch (themeModeData.themeMode) {
          case ThemeMode.light:
            themeData = _getLightThemeData();
            break;
          case ThemeMode.dark:
            themeData = _getDarkThemeData();
            break;
          case ThemeMode.system:
            themeData = _getSystemThemeData();
            break;
          default:
            themeData = _getLightThemeData();
        }

        return MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: themeData,
          home: introduction(),
        );
      },
    );
  }

  ThemeData _getLightThemeData() {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.light,
      scaffoldBackgroundColor: Color.fromRGBO(255, 253, 246, 1),
      textTheme: GoogleFonts.interTextTheme(
        TextTheme(
          headlineLarge: TextStyle(
            fontSize: 24,
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
          headlineMedium: TextStyle(
            fontSize: 20,
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  ThemeData _getDarkThemeData() {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,
      scaffoldBackgroundColor: Color.fromRGBO(41, 44, 57, 1),
      textTheme: GoogleFonts.poppinsTextTheme(
        TextTheme(
          headlineLarge: TextStyle(
            fontSize: 24,
            color: const Color.fromARGB(255, 255, 255, 255),
            fontWeight: FontWeight.bold,
          ),
          headlineMedium: TextStyle(
            fontSize: 20,
            color: const Color.fromARGB(255, 255, 255, 255),
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  ThemeData _getSystemThemeData() {
    final Brightness platformBrightness = window.platformBrightness;

    if (platformBrightness == Brightness.dark) {
      return _getDarkThemeData();
    } else {
      return _getLightThemeData();
    }
  }
}
