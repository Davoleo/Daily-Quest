import 'package:flutter/material.dart';

class IconPicker extends StatelessWidget {

  const IconPicker({
    this.title = const Text("Icon Picker"),
    this.icons = const [Icon(Icons.emoji_emotions_outlined)],
    this.itemsPerRow = 5,
    this.backgroundColor,
    this.elevation,
    this.clipBehaviour = Clip.none,
    this.shapeBorder,
  });

  final Widget title;
  final List<Icon> icons;

  final int itemsPerRow;

  //Default SimpleDialog Padding
  final EdgeInsetsGeometry titlePadding = const EdgeInsets.fromLTRB(24.0, 24.0, 24.0, 0.0);
  final EdgeInsetsGeometry contentPadding = const EdgeInsets.fromLTRB(12.0, 12.0, 12.0, 16.0);

  final Color? backgroundColor;
  final double? elevation;

  final Clip clipBehaviour;
  final ShapeBorder? shapeBorder;

  final EdgeInsets insetPadding = const EdgeInsets.symmetric(horizontal: 40.0, vertical: 24.0);

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final TextDirection? textDirection = Directionality.maybeOf(context);

    List<Widget> dialogOptions = [];
    icons.forEach((icon) {
      dialogOptions.add(new SimpleDialogOption(
        onPressed: () => Navigator.pop(context, icon),
        child: icon,
        padding: const EdgeInsets.all(8.0),
      ));
    });

    Widget titleWidget;
    final EdgeInsets effectiveTitlePadding = titlePadding.resolve(textDirection);
    titleWidget = Padding(
      padding: EdgeInsets.only(
        left: effectiveTitlePadding.left,
        right: effectiveTitlePadding.right,
        top: effectiveTitlePadding.top,
        bottom: effectiveTitlePadding.bottom,
      ),
      child: DefaultTextStyle(
        style: DialogTheme.of(context).titleTextStyle ?? theme.textTheme.headline6!,
        child: Semantics(child: title),
      ),
    );

    Widget contentWidget;
    final EdgeInsets effectiveContentPadding = contentPadding.resolve(textDirection);
    contentWidget = ConstrainedBox(
      //TODO : Generify Dialog content box height
      constraints: BoxConstraints.tightForFinite(height: 500),
      child: GridView.count(
        crossAxisCount: itemsPerRow,
        padding: EdgeInsets.only(
          left: effectiveContentPadding.left,
          right: effectiveContentPadding.right,
          top: effectiveContentPadding.top,
          bottom: effectiveContentPadding.bottom,
        ),
        children: dialogOptions,
      ),
    );

    Widget dialogChild = ConstrainedBox(
      constraints: const BoxConstraints(minWidth: 280.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          titleWidget,
          contentWidget,
        ],
      ),
    );

    return Dialog(
      backgroundColor: backgroundColor,
      elevation: elevation,
      insetPadding: insetPadding,
      clipBehavior: clipBehaviour,
      shape: shapeBorder,
      child: dialogChild,
    );
  }
}
