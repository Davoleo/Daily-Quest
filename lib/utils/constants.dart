import 'package:daily_quest/model/day.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';

class Constants {
  static late Color primaryLight30;
  static late SystemUiOverlayStyle statusBar;
  static const double dividerHPadding = 16;

  static DateFormat dailyFormat = DateFormat("HH:mm");
  static DateFormat weeklyFormat = DateFormat("EEEEE - HH:mm");
  static DateFormat monthlyFormat = DateFormat("dd/MM/yy - HH:mm");

  static OutlineInputBorder fieldOutline = OutlineInputBorder(
    borderRadius: BorderRadius.all(Radius.circular(8))
  );

  static final List<Icon> supportedTaskIcons = [
    Icon(Icons.emoji_emotions_outlined),
    Icon(Icons.note),
    Icon(Icons.edit),
    Icon(Icons.title),
    Icon(Icons.alarm),
    Icon(Icons.ac_unit),
    Icon(Icons.fitness_center),
    Icon(Icons.accessible),
    Icon(Icons.account_balance),
    Icon(Icons.camera_alt),
    Icon(Icons.phone),
    Icon(Icons.message),
    Icon(Icons.airplanemode_active),
    Icon(Icons.alternate_email),
    Icon(Icons.anchor),
    Icon(Icons.assignment_outlined),
    Icon(Icons.attach_file),
    Icon(Icons.watch_later_outlined),
    Icon(Icons.work),
    Icon(Icons.weekend),
    Icon(Icons.sports_basketball),
    Icon(Icons.sports_esports),
    Icon(Icons.smartphone),
    Icon(Icons.account_circle),
    Icon(Icons.audiotrack),
    Icon(Icons.flag),
    Icon(Icons.apps),
    Icon(Icons.alt_route),
    Icon(Icons.all_inbox),
    Icon(Icons.category),
    Icon(Icons.bar_chart),
  ];

  static final List<Month> months = [
    Month("January", DateTime.january),
    Month("February", DateTime.february),
    Month("March", DateTime.march),
    Month("April", DateTime.april),
    Month("May", DateTime.may),
    Month("June", DateTime.june),
    Month("July", DateTime.july),
    Month("August", DateTime.august),
    Month("September", DateTime.september),
    Month("October", DateTime.october),
    Month("November", DateTime.november),
    Month("December", DateTime.december),
  ];

  static final List<DayOfWeek> weekDays = [
    DayOfWeek("Monday", DateTime.monday),
    DayOfWeek("Tuesday", DateTime.tuesday),
    DayOfWeek("Wednesday", DateTime.wednesday),
    DayOfWeek("Thursday", DateTime.thursday),
    DayOfWeek("Friday", DateTime.friday),
    DayOfWeek("Saturday", DateTime.saturday),
    DayOfWeek("Sunday", DateTime.sunday),
  ];

  static final MaterialColor accentSwatch = new MaterialColor(0xff4C6D42, {
    50: Color(0xff9daf97),
    100: Color(0xff94a78e),
    200: Color(0xff82997b),
    300: Color(0xff708a68),
    400: Color(0xff5e7c55),
    500: Color(0xff4c6d42),
    600: Color(0xff44623b),
    700: Color(0xff3d5735),
    800: Color(0xff354c2e),
    900: Color(0xff2e4128),
  });

  static init(BuildContext context) {
    primaryLight30 = Theme.of(context).primaryColorLight.withAlpha(76);
    statusBar = SystemUiOverlayStyle(statusBarIconBrightness: Brightness.light);
  }
}