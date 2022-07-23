import 'package:app/components/base_widget.dart';
import 'package:app/theme.dart';
import 'package:flutter/material.dart';

class PanelHeaderWidget extends StatelessWidget {
  final String label;
  const PanelHeaderWidget({Key? key, required this.label}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: spaceVerticality(Style.spacelg, Style.spacemd),
      padding: spaceHorizontal(),
      child:
          text(label, fontSize: Style.fontlg, color: Style.white, shadow: true),
    );
  }
}
