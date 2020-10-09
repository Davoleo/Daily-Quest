import 'package:flutter/material.dart';

class Task {
  final UniqueKey _id;
  String _title;
  bool _complete = false;
  bool _delayed = false;
  IconData _icon;

  Task(this._id, this._title, this._icon);

  bool get delayed => _delayed;

  set delayed(bool value) {
    _delayed = value;
  }

  bool get complete => _complete;

  set complete(bool value) {
    _complete = value;
  }

  String get title => _title;

  set title(String value) {
    _title = value;
  }

  UniqueKey get id => _id;

  set icon(IconData icon) {
    _icon = icon;
  }

  IconData get icon => _icon;
}