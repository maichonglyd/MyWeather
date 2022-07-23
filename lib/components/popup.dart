import 'dart:math';

import 'package:app/components/base_widget.dart';
import 'package:app/theme.dart';
import 'package:flutter/material.dart';

class Popup extends StatelessWidget {
  final Widget child;
  final String label;
  final GlobalKey _globalKey = GlobalKey(
      debugLabel: 'pop-dropdown-' + Random().nextInt(100000000).toString());
  Popup({Key? key, required this.label, required this.child}) : super(key: key);

  static OverlayEntry? _ove;

  _hide() {
    if (_ove != null) {
      _ove!.remove();
      _ove = null;
    }
  }

  _show(context) {
    _hide();
    OverlayState os = Overlay.of(context)!;
    _ove = handleShowPopup();
    os.insert(_ove!);
  }

  handleShowPopup() {
    _hide();
    RenderBox renderBox =
        _globalKey.currentContext!.findRenderObject() as RenderBox;
    var childSize = renderBox.size;
    var childPosition = renderBox.localToGlobal(Offset.zero);

    /// 三角形左边距，一般应该在被点击的组件最中间，最少应该大于marginHorizontal + 10 加10是圆角问题，显示到最边边不好看
    var shapeLeft = max(childPosition.dx + (childSize.width - rpx(42)) / 2,
        Style.spacelg + rpx(15));

    /// 三角形也不能超过右侧自身人宽度 + 10 + margin
    shapeLeft =
        min(shapeLeft, PageSize.width - Style.spacelg - rpx(15) - rpx(42));

    /// 计算菜单显示位置 同三角形
    var menuLeft =
        max(Style.spacelg, (childPosition.dx + childSize.width / 2) - rpx(200));
    menuLeft = min(menuLeft, PageSize.width - Style.spacelg - rpx(400));

    /// 菜单底部距离屏幕顶部的高度
    var menuBottom = PageSize.height - childPosition.dy + rpx(20);

    return OverlayEntry(builder: (context) {
      return GestureDetector(
        onTap: _hide,
        child: Scaffold(
          backgroundColor: Colors.transparent,
          body: Container(
            color: Colors.transparent,
            child: Stack(
              children: <Widget>[
                Positioned(
                    left: menuLeft,
                    bottom: menuBottom,
                    child: Container(
                        decoration: BoxDecoration(
                            color: Style.white,
                            boxShadow: [
                              BoxShadow(
                                  color: Colors.black.withOpacity(0.16),
                                  offset: Offset(0, rpx(8)),
                                  blurRadius: rpx(32),
                                  spreadRadius: rpx(-8)),
                            ],
                            borderRadius: BorderRadius.all(
                                Radius.circular(Style.borderRadiusmd)),
                            border: Border.fromBorderSide(
                                borderSide(rpx(1), Style.borderlight))),
                        padding: space(Style.spacemd),
                        width: rpx(400),
                        child: text(label))),
                Positioned(
                    bottom: PageSize.height - childPosition.dy,
                    left: shapeLeft,
                    child: CustomPaint(
                      painter: BorderPainter(lineColor: Style.borderlight),
                      child: ClipPath(
                        clipper: TriangleClipper(),
                        child: Container(
                          width: rpx(42),
                          height: rpx(21),
                          color: Style.white,
                        ),
                      ),
                    )),
              ],
            ),
          ),
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        key: _globalKey, onTap: () => _show(context), child: child);
  }
}

/// 画三角形
class TriangleClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();

    path.moveTo(0, 0);
    path.lineTo(size.width, 0);
    path.lineTo(size.width / 2, size.height);

    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper oldClipper) {
    return oldClipper != this;
  }
}

/// 画三角形的边框
class BorderPainter extends CustomPainter {
  final Color lineColor;
  BorderPainter({required this.lineColor});
  @override
  void paint(Canvas canvas, Size size) {
    Paint p = Paint();
    p.color = lineColor;
    p.strokeWidth = rpx(1);
    canvas.drawLine(const Offset(0, 0), Offset(size.width / 2, size.height), p);
    canvas.drawLine(Offset(size.width, size.height),
        Offset(size.width / 2, size.height), p);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return oldDelegate != this;
  }
}
