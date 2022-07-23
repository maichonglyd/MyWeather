import 'dart:ui';
import 'package:flutter/material.dart';

double rpx(double size) {
  return size * PageSize.sizeRatio;
}

class PageSize {
  static final MediaQueryData mediaQueryData =
      MediaQueryData.fromWindow(window);
  static const baseScreenWidth = 750;
  static final sizeRatio = mediaQueryData.size.width / baseScreenWidth;
  static final double statusBarHeight = mediaQueryData.padding.top;
  static const double titleBarHeight = kToolbarHeight;
  static const double bottomBarHeight = kBottomNavigationBarHeight;
  static final double width = mediaQueryData.size.width;
  static final double height = mediaQueryData.size.height;
  static final double safeAreaHeight = mediaQueryData.padding.bottom;
}

class Style {
  /// 20
  static double fontxs = rpx(20);

  /// 24
  static double fontsm = rpx(24);

  /// 28
  static double fontmd = rpx(28);

  /// 32
  static double fontlg = rpx(32);

  /// 36
  static double fontxl = rpx(36);

  /// 42
  static double fontxxl = rpx(42);

  /// 5
  static double spacexs = rpx(5);

  /// 10
  static double spacesm = rpx(10);

  /// 20
  static double spacemd = rpx(20);

  /// 30
  static double spacelg = rpx(30);

  /// 40
  static double spacexl = rpx(40);

  /// 50
  static double spacexxl = rpx(50);

  /// 60
  static double spacexxxl = rpx(60);

  /// 5
  static double borderRadiusxs = rpx(5);

  /// 10
  static double borderRadiussm = rpx(10);

  /// 20
  static double borderRadiusmd = rpx(20);

  /// 30
  static double borderRadiuslg = rpx(30);

  /// 40
  static double borderRadiusxl = rpx(40);

  /// 50
  static double borderRadiusxxl = rpx(50);

  /// 60
  static double borderRadiusxxxl = rpx(60);

  ///0xff999999
  static Color textlight = const Color(0xff999999);

  /// 0xff666666
  static Color textgrey = const Color(0xff666666);

  /// 0xff333333
  static Color textdark = const Color(0xff333333);

  static Color textBlue = const Color.fromARGB(226, 21, 111, 229);

  ///0xfff9f9f9
  static Color bglight = const Color(0xfff2f2f2);

  ///0xffF4F4F4
  static Color bggrey = const Color(0xffcccccc);

  ///0xffb2b2b2
  static Color bgdark = const Color(0xffb2b2b2);

  ///0xffefefef
  static Color borderlight = const Color(0xffefefef);

  ///0xffdddddd
  static Color bordergrey = const Color(0xffdddddd);

  ///0xff666666
  static Color borderdark = const Color(0xff666666);

  static Color white = Colors.white;

  /// 0xff000000
  static Color black = const Color(0xff000000);
  static Color red = const Color(0xfffb3d55);
  static Color orange = const Color(0xffee9f16);
  static Color purple = const Color(0xffb724e5);
  static Color blue = const Color(0xff3686f2);
  static Color green = const Color(0xff01c1a3);
}
