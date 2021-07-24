import 'package:daily_quest/ui/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  MyApp() {
    // SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    //     statusBarColor: Colors.transparent,
    //     statusBarIconBrightness: Brightness.light
    // ));
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Daily Quest',
      theme: ThemeData(
        scaffoldBackgroundColor: Color(0xffefe7e7),
        primaryColor: Color(0xFF6d4c41),
        primaryColorDark: Color(0xFF40241a),
        primaryColorLight: Color(0xFF9c786c),
        accentColor: Color(0xff4C6D42),
        brightness: Brightness.light,
        primarySwatch: Colors.green,

        dialogBackgroundColor: Color(0xffe5ccc5),
        appBarTheme: AppBarTheme(brightness: Brightness.dark),

      ),
      home: HomePage(),
    );
  }
}