import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:lienna_bag/Provider/themeMode.dart';
import 'package:lienna_bag/page/introduction.dart';
import 'package:lienna_bag/pages/home_screen.dart';
import 'package:lienna_bag/firebase_options.dart';
import 'package:provider/provider.dart';

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
    ColorScheme lightTheme = ColorScheme(
      background: Color.fromARGB(255, 206, 190, 190), //warna backgorund
      onBackground: Color.fromARGB(255, 0, 0, 0), // text
      primary: Color.fromARGB(255, 226, 212, 225),
      onPrimary: Color.fromARGB(255, 0, 0, 0), // text
      secondary: Color.fromARGB(255, 74, 83, 114),
      onSecondary: Color.fromARGB(255, 104, 95, 95),
      error: Colors.red,
      onError: Colors.red,
      surface: Colors.red,
      onSurface: Colors.red,
      brightness: Brightness.light,
    );

    ColorScheme darkTheme = ColorScheme(
      background: Color.fromARGB(255, 0, 0, 0),
      onBackground: Color.fromARGB(255, 255, 255, 255), // text
      primary: const Color.fromARGB(255, 122, 125, 156),
      onPrimary: const Color.fromARGB(255, 255, 255, 255),
      secondary: Color.fromARGB(255, 74, 83, 114),
      onSecondary: Color.fromARGB(255, 104, 95, 95),
       error: Colors.red,
      onError: Colors.red,
      surface: Colors.red,
      onSurface: Colors.red,
      brightness: Brightness.dark,
    );

    return MultiProvider(
      providers: [
        // provider yang digunakan
        ChangeNotifierProvider(create: (context) => ThemeModeData()),
      ],
      child: Builder(builder: (ctx) {
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
                      fontWeight: FontWeight.bold),
                  titleLarge: TextStyle(
                      fontSize: 20,
                      color: Colors.black,
                      fontWeight: FontWeight.bold),
                  titleMedium: TextStyle(
                    fontSize: 16,
                   color: Colors.black),
                  titleSmall: TextStyle(
                    fontSize: 15, 
                    color: Colors.black))),
          darkTheme: ThemeData(
              useMaterial3: true,
              brightness: Brightness.light,
              scaffoldBackgroundColor: Color.fromARGB(255, 0, 0, 0),
              textTheme: TextTheme(
                  bodyLarge: TextStyle(
                      fontSize: 23,
                      color: const Color.fromARGB(255, 255, 255, 255),
                      fontWeight: FontWeight.bold),
                  titleLarge: TextStyle(
                      fontSize: 20,
                      color: const Color.fromARGB(255, 255, 255, 255),
                      fontWeight: FontWeight.bold),
                  titleMedium: TextStyle(
                    fontSize: 16,
                    color: const Color.fromARGB(255, 255, 255, 255),
                  ),
                  titleSmall: TextStyle(
                    fontSize: 15,
                    color: const Color.fromARGB(255, 255, 255, 255),
                  ))),
          themeMode: Provider.of<ThemeModeData>(ctx).themeMode,
          home: introduction(),
        );
      }),
    );
  }
}