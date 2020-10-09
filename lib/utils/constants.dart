import 'package:flutter/material.dart';

class Constants {
  static Color primaryLight30;

  static init(BuildContext context) {
    primaryLight30 = Theme.of(context).primaryColorLight.withAlpha(76);
  }
}