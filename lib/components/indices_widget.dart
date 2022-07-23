import 'package:app/components/base_widget.dart';
import 'package:app/redux/model/indices.dart';
import 'package:app/theme.dart';
import 'package:flutter/material.dart';

class IndicesWidget extends StatelessWidget {
  final Indices indices;
  final int index;
  const IndicesWidget({Key? key, required this.indices, required this.index})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    Color mainColor = Style.red;
    if ([0, 2].contains(index)) {
      mainColor = Style.red;
    } else if ([1, 7].contains(index)) {
      mainColor = Style.blue;
    } else if ([4].contains(index)) {
      mainColor = Style.orange;
    } else if ([3, 5].contains(index)) {
      mainColor = Style.green;
    } else if ([6, 8].contains(index)) {
      mainColor = Style.purple;
    }
    return Container(
      width: rpx(229),
      padding: space(Style.spacesm),
      alignment: Alignment.center,
      color: mainColor.withOpacity(0.1),
      child: Column(children: [
        Stack(
          alignment: Alignment.bottomCenter,
          children: [
            text(indices.level!,
                fontSize: rpx(80),
                lineHeight: 1,
                color: mainColor.withOpacity(0.8)),
            text(indices.category!, fontSize: Style.fontsm, color: Style.white),
          ],
        ),
        text(indices.name!, color: Style.white)
      ]),
    );
  }
}
