import 'package:flutter/material.dart';

final GlobalKey dropDownHackKey = GlobalKey();

GestureDetector? _detector;

void __dropdownSearch(BuildContext? context) {
  context?.visitChildElements((element) {
    if (_detector != null)
      return;
    if (element.widget is GestureDetector)
      _detector = element.widget as GestureDetector;
    else
      __dropdownSearch(element);
  });
}

///See: https://github.com/flutter/flutter/issues/53634
void openDropDownInternalHack() {
  __dropdownSearch(dropDownHackKey.currentContext);
  if (_detector != null)
    _detector?.onTap!();
}
