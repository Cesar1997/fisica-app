import 'package:fisica_app/FiguresAnimation.dart';
import 'package:fisica_app/FreeFall.dart';
import 'package:fisica_app/SmileFace.dart';
import 'package:fisica_app/home.dart';
import 'package:flutter/material.dart';
final Color darkBlue =  Colors.white;//Color.fromARGB(255, 18, 32, 47);

void main(List<String> args) {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.from(colorScheme: ColorScheme.light(
        primary: Colors.redAccent,
        secondary: Colors.yellow
      )), //ThemeData.dark().copyWith(scaffoldBackgroundColor: darkBlue),
      home: HomePage()
    );
  }
}
