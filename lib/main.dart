import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:lienna_bag/firebase_options.dart';
import 'package:lienna_bag/page/home_screen.dart';
import 'package:lienna_bag/page/login_page.dart';

void main() async {
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
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Lieanna Bag',
      theme: ThemeData(
        // colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
        textTheme: TextTheme(
          bodyLarge: TextStyle(
            fontSize: 24,
            color: Colors.black,
            fontWeight: FontWeight.bold
          ),

          titleLarge: TextStyle(
            fontSize: 20,
            color: Colors.black
          ),

          titleMedium: TextStyle(
            fontSize: 18,
              color: Colors.black
          ),

          titleSmall: TextStyle(
            fontSize: 15,
              color: Colors.black
          )
        )
      ),
      home: hom_scrn(),
    );
  }
}