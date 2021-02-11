import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class Constants {
  static Color primaryLight30;
  static const double dividerHPadding = 16;

  static DateFormat dailyFormat = DateFormat("HH:mm");
  static DateFormat weeklyFormat = DateFormat("EEEEE - HH:mm");
  static DateFormat monthlyFormat = DateFormat("dd/MM/yy - HH:mm");

  static OutlineInputBorder fieldOutline = OutlineInputBorder(
    borderRadius: BorderRadius.all(Radius.circular(8))
  );

  static init(BuildContext context) {
    primaryLight30 = Theme.of(context).primaryColorLight.withAlpha(76);
  }
}