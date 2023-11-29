import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:lienna_bag/firebase_options.dart';
import 'package:lienna_bag/page/home_screen.dart';
import 'package:lienna_bag/page/introduction.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
      ColorScheme lightTheme = ColorScheme.fromSeed(
      background: Color.fromARGB(255, 206, 190, 190), //warna backgorund
      onPrimary: Color.fromARGB(255, 0, 0, 0), // text
      secondary: Color.fromARGB(255, 206, 190, 190),
      onSecondary: Color.fromARGB(255, 33, 32, 32), // text
      tertiary: Color.fromARGB(255, 206, 190, 190),
      seedColor: Color.fromARGB(255, 206, 190, 190),
      brightness: Brightness.light,
      );

    ColorScheme darkTheme = ColorScheme.fromSeed(
      background: Color.fromARGB(255, 0, 0, 0),
      primary: const Color.fromARGB(255, 255, 255, 255),
      onPrimary: const Color.fromARGB(255, 255, 255, 255),
      secondary: Color.fromARGB(255, 206, 190, 190),
      onSecondary: Color.fromARGB(255, 228, 220, 220),
      seedColor: Color.fromARGB(255, 206, 190, 190),
      brightness: Brightness.dark,
      );

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Lieanna Bag',
      theme: ThemeData(
        useMaterial3: true,
        brightness: Brightness.light,
        scaffoldBackgroundColor: Color.fromARGB(255, 206, 190, 190),
        textTheme: TextTheme(
          
          bodyLarge: TextStyle(
            fontSize: 23,
            color: Colors.black,
            fontWeight: FontWeight.bold
          ),

          titleLarge: TextStyle(
            fontSize: 20,
            color: Colors.black,
            fontWeight: FontWeight.bold
          ),

          titleMedium: TextStyle(
            fontSize: 16,
              color: Colors.black
          ),

          titleSmall: TextStyle(
            fontSize: 15,
              color: Colors.black
          )
        )
      ),
      darkTheme:ThemeData(
        useMaterial3: true,
        brightness: Brightness.light,
        scaffoldBackgroundColor: Color.fromARGB(255, 0, 0, 0),
        textTheme: TextTheme(
          
          bodyLarge: TextStyle(
            fontSize: 23,
            color: const Color.fromARGB(255, 255, 255, 255),
            fontWeight: FontWeight.bold
          ),

          titleLarge: TextStyle(
            fontSize: 20,
            color: const Color.fromARGB(255, 255, 255, 255),
            fontWeight: FontWeight.bold
          ),

          titleMedium: TextStyle(
            fontSize: 16,
              color: const Color.fromARGB(255, 255, 255, 255),
          ),

          titleSmall: TextStyle(
            fontSize: 15,
              color: const Color.fromARGB(255, 255, 255, 255),
          )
        )
      ),
      themeMode: ThemeMode.light,
      home: hom_scrn(),
    );
  }
}