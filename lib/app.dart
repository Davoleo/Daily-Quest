import 'package:daily_quest/ui/home_screen.dart';
import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Daily Quest',
      theme: ThemeData(
        primaryColor: Color(0xFF6d4c41),
        primaryColorDark: Color(0xFF40241a),
        primaryColorLight: Color(0xFF9c786c),
        accentColor: Color(0xFFce7e00)
      ),
      home: HomePage(),
    );
  }
}