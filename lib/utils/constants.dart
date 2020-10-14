import 'package:flutter/material.dart';

class Constants {
  static Color primaryLight30;
  static double dividerHPadding;

  static init(BuildContext context) {
    primaryLight30 = Theme.of(context).primaryColorLight.withAlpha(76);
    dividerHPadding = 16;
  }
}