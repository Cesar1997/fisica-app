
import 'package:fisica_app/FreeFall.dart';
import 'package:fisica_app/home.dart';
import 'package:flutter/material.dart';
void main() {
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
      initialRoute: 'home',
      routes: {
        'home' : (BuildContext context) => HomePage(),
        'resolve' : (BuildContext context) => FreeFall()
      },
    );
  }
}
