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
    Icon(Icons.accessibility),
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

  static final List<DayOfWeek> weekDays = [
    DayOfWeek("Monday", DateTime.monday),
    DayOfWeek("Tuesday", DateTime.tuesday),
    DayOfWeek("Wednesday", DateTime.wednesday),
    DayOfWeek("Thursday", DateTime.thursday),
    DayOfWeek("Friday", DateTime.friday),
    DayOfWeek("Saturday", DateTime.saturday),
    DayOfWeek("Sunday", DateTime.sunday),
  ];

  static init(BuildContext context) {
    primaryLight30 = Theme.of(context).primaryColorLight.withAlpha(76);
    statusBar = SystemUiOverlayStyle(statusBarIconBrightness: Brightness.light);
  }
}