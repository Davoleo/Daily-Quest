import 'package:flutter/material.dart';

class SCheckbox extends StatelessWidget {
  final String label;
  final bool value;
  final ValueChanged<bool?> onChanged;
  final TextStyle? labelStyle;
  final EdgeInsets padding;

  SCheckbox({
    Key? key,
    required this.label,
    this.value = false,
    required this.onChanged,
    this.labelStyle,
    this.padding = EdgeInsets.zero
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => onChanged(!value),
      child: Padding(
        padding: padding,
        child: FittedBox(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(label, style: labelStyle,),
              Checkbox(
                materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                value: value,
                onChanged: onChanged,
                activeColor: Theme.of(context).primaryColor,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
