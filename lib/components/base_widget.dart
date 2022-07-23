import 'dart:io';
import 'dart:typed_data';
import 'package:app/r.dart';
import 'package:flutter/services.dart';

import '../theme.dart';
import 'package:flutter/material.dart';

/**
 * [Padding]        padding[x]        各个方向的内边距    直接使用
 * 
 * [EdgeInsets]     space[x]          各个方向的间隔      多用于padding属性或margin属性
 * 
 * [Text]           text              文本              内容 颜色 字号 粗体 对齐 溢出
 * 
 * [Image]          image             图片              本地或网络图片 给定宽高
 * 
 * [ClipRRect]      imageCirc[x]      各个方向圆角图片    直接使用
 * 
 * [BorderSide]     borderSide        边线              用于border属性
 * 
 * [BoxDecoration]  border[x]         各个方向边框        多用于Container.decoration属性
 * 
 * [BoxDecoration]  bgAndBorder[x]    背景色和边框        多用于Container.decoration属性
 * 
 * [BoxDecoration]  bgAndCirc[x]      背景色和圆角        多用于Container.decoration属性
 */

/// 左侧内边距
Padding paddingLeft([double? x]) {
  var t = x ?? Style.spacelg;
  return Padding(padding: EdgeInsets.only(left: t));
}

/// 右侧内边距
Padding paddingRight([double? x]) {
  var t = x ?? Style.spacelg;
  return Padding(padding: EdgeInsets.only(right: t));
}

/// 上侧内边距
Padding paddingTop([double? x]) {
  var t = x ?? Style.spacelg;
  return Padding(padding: EdgeInsets.only(top: t));
}

/// 下侧内边距
Padding paddingBottom([double? x]) {
  var t = x ?? Style.spacelg;
  return Padding(padding: EdgeInsets.only(bottom: t));
}

/// 左右两侧内边距 只写一个参数代表两侧用同一个值
Padding paddingHorizontal([double? left, double? right]) {
  var tl = left ?? Style.spacelg;
  var tr = right ?? left ?? Style.spacelg;
  return Padding(padding: EdgeInsets.only(left: tl, right: tr));
}

/// 上下两侧内边距 只写一个参数代表两侧用同一个值
Padding paddingVerticality([double? top, double? bottom]) {
  var tt = top ?? Style.spacelg;
  var tb = bottom ?? top ?? Style.spacelg;
  return Padding(padding: EdgeInsets.only(top: tt, bottom: tb));
}

/// 四周不同的内边距
Padding paddingRound(double top, double right, double bottom, double left) {
  return Padding(
      padding:
          EdgeInsets.only(top: top, bottom: bottom, left: left, right: right));
}

/// 四周相同的内边距
Padding padding([double? x]) {
  var t = x ?? Style.spacelg;
  return Padding(padding: EdgeInsets.all(t));
}

/// 左侧间距
EdgeInsets spaceLeft([double? x]) {
  var t = x ?? Style.spacelg;
  return EdgeInsets.only(left: t);
}

/// 右侧间距
EdgeInsets spaceRight([double? x]) {
  var t = x ?? Style.spacelg;
  return EdgeInsets.only(right: t);
}

/// 上侧间距
EdgeInsets spaceTop([double? x]) {
  var t = x ?? Style.spacelg;
  return EdgeInsets.only(top: t);
}

/// 下侧间距
EdgeInsets spaceBottom([double? x]) {
  var t = x ?? Style.spacelg;
  return EdgeInsets.only(bottom: t);
}

/// 左右两侧间距  只写一个参数代表两侧用同一个值
EdgeInsets spaceHorizontal([double? left, double? right]) {
  var tl = left ?? Style.spacelg;
  var tr = right ?? left ?? Style.spacelg;
  return EdgeInsets.only(left: tl, right: tr);
}

/// 上下两侧间距 只写一个参数代表两侧用同一个值
EdgeInsets spaceVerticality([double? top, double? bottom]) {
  var tt = top ?? Style.spacelg;
  var tb = bottom ?? top ?? Style.spacelg;
  return EdgeInsets.only(top: tt, bottom: tb);
}

/// 四周不同间距
EdgeInsets spaceRound(double top, double right, double bottom, double left) {
  return EdgeInsets.only(top: top, bottom: bottom, left: left, right: right);
}

/// 四周相同间距
EdgeInsets space([double? x]) {
  var t = x ?? Style.spacelg;
  return EdgeInsets.all(t);
}

/// 文本
///
/// * [String] v 内容
/// * [double] fontSize 字号 默认为 Style.fontMedium
/// * [Color] color 颜色 默认为 Style.textDefault
/// * [double] height 行高 默认为 1.0
/// * [bool] blod 粗体 默认为 false
/// * [TextAlign] align 文本对齐方式
/// * [TextOverflow] overflow 溢出；只能决定文字最后是否显示省略号 配合maxLines使用
/// * [int] maxLines 显示最大行数
/// * [bool] deleteline 显示删除线 与underline同时存在时显示删除线
/// * [bool] underline 显示下划线 与deleteline同时存在时显示删除线
Text text(String v,
    {double? fontSize,
    Color? color,
    double? lineHeight,
    bool blod = false,
    TextAlign? align,
    TextOverflow? overflow,
    int? maxLines,
    bool deleteline = false,
    bool underline = false,
    bool shadow = false}) {
  TextAlign textAlign = align ?? TextAlign.start;

  TextOverflow of = overflow ?? TextOverflow.visible;

  TextDecoration? td;
  if (underline) td = TextDecoration.underline;
  if (deleteline) td = TextDecoration.lineThrough;

  return Text(
    v,
    textAlign: textAlign,
    overflow: of,
    maxLines: maxLines ?? 100,
    softWrap: true,
    textScaleFactor: 1.0,
    style: TextStyle(
        height: lineHeight ?? 1.4,
        decoration: td,
        color: color ?? Style.textdark,
        fontSize: fontSize ?? Style.fontmd,
        fontWeight: blod ? FontWeight.w600 : null,
        shadows: shadow
            ? [
                Shadow(
                  offset: const Offset(1, 1),
                  blurRadius: 5.0,
                  color: Style.white.withOpacity(0.5),
                ),
              ]
            : null),
  );
}

/// 显示一个给定宽高的图片
///
/// 可以是网络图片 也可以是本地图片，网络图片需要以http开头
Widget image(dynamic img, double? width, double height,
    {Color? color, BoxFit? fit}) {
  if (img is File) {
    return Image.file(img,
        fit: BoxFit.fill, width: width, height: height, color: color);
  } else if (img is String) {
    if (img.startsWith('http')) {
      return Image.network(img,
          fit: fit ?? BoxFit.fill, width: width, height: height, color: color);
    } else if (img.isEmpty) {
      return Image.asset('images/pic_default.jpg',
          fit: BoxFit.fill, width: width, height: height, color: color);
    }
  } else if (img is Uint8List) {
    return Image.memory(img,
        fit: fit ?? BoxFit.fill, width: width, height: height, color: color);
  }
  return Image.asset(img,
      fit: BoxFit.fill, width: width, height: height, color: color);
}

/// 显示一个给定宽高-左侧两个圆角的图片
///
/// 可以是网络图片 也可以是本地图片，网络图片需要以http开头
ClipRRect imageCircLeft(
    dynamic img, double? width, double height, double radius,
    [Color? color]) {
  var r = Radius.circular(radius);
  return ClipRRect(
      child: image(img, width, height, color: color),
      borderRadius: BorderRadius.only(topLeft: r, bottomLeft: r));
}

/// 显示一个给定宽高-上侧两个圆角的图片
///
/// 可以是网络图片 也可以是本地图片，网络图片需要以http开头
ClipRRect imageCircTop(
    dynamic img, double? width, double height, double radius) {
  var r = Radius.circular(radius);
  return ClipRRect(
      child: image(img, width, height),
      borderRadius: BorderRadius.only(topLeft: r, topRight: r));
}

/// 显示一个给定宽高-右侧两个圆角的图片
///
/// 可以��网���图片 也可以是��地图片，网络图片需要以http开头
ClipRRect imageCircRight(
    dynamic img, double? width, double height, double radius) {
  var r = Radius.circular(radius);
  return ClipRRect(
      child: image(img, width, height),
      borderRadius: BorderRadius.only(bottomRight: r, topRight: r));
}

/// 显示一个给定宽高-下侧两个圆角的图片
///
/// 可以是网络图片 也可以是本地图片，网络图片需要以http开头
ClipRRect imageCircBottom(
    dynamic img, double? width, double height, double radius) {
  var r = Radius.circular(radius);
  return ClipRRect(
      child: image(img, width, height),
      borderRadius: BorderRadius.only(bottomRight: r, bottomLeft: r));
}

/// 显示一个给定宽高-四个圆角的图片
///
/// 可以是网络图片 也可以是本地图片，网络图片需要以http开头
ClipRRect imageCirc(dynamic img, double width, double height, double radius) {
  var r = Radius.circular(radius);
  return ClipRRect(
      child: image(img, width, height), borderRadius: BorderRadius.all(r));
}

/// 边线宽度和颜色 默认宽度为1，颜色为BorderColor.light
BorderSide borderSide([double? width, Color? color]) {
  return BorderSide(width: width ?? rpx(1), color: color ?? Style.borderlight);
}

/// 左边框
/// * [double] width 宽度 默认为1
/// * [Color] color 边框颜色 默认为BorderColor.light
BoxDecoration borderLeft({double? width, Color? color}) {
  return BoxDecoration(border: Border(left: borderSide(width, color)));
}

/// 右边框
/// * [double] width 宽度 默认为1
/// * [Color] color 边框颜色 默认为BorderColor.light
BoxDecoration borderRight({double? width, Color? color}) {
  return BoxDecoration(border: Border(right: borderSide(width, color)));
}

/// 上边框
/// * [double] width 宽度 默认为1
/// * [Color] color 边框颜色 默认为BorderColor.light
BoxDecoration borderTop({double? width, Color? color}) {
  return BoxDecoration(border: Border(top: borderSide(width, color)));
}

/// 下边框
/// * [double] width 宽度 默认为1
/// * [Color] color 边框颜色 默认为BorderColor.light
BoxDecoration borderBottom({double? width, Color? color}) {
  return BoxDecoration(border: Border(bottom: borderSide(width, color)));
}

/// 四边框
/// * [double] width 宽度 默认为1
/// * [Color] color 边框颜色 默认为BorderColor.light
BoxDecoration border({double? width, Color? color}) {
  return BoxDecoration(
      border: Border.all(width: width ?? 1, color: color ?? Style.borderlight));
}

/// 边框和圆角
/// * [double] radius 圆角
/// * [double] width 宽度 默认为1
/// * [Color] color 边框颜色 默认为BorderColor.light
BoxDecoration borderCirc(
    {double? width, Color? color, required double radius}) {
  return BoxDecoration(
      border: Border.all(color: color ?? Style.borderlight, width: width ?? 1),
      borderRadius: BorderRadius.circular(radius));
}

/// 背景色和左边框
/// * [Color] bg 背景色 默认为BgColor.white
/// * [double] width 宽度 默认为1
/// * [Color] color 边框颜色 默认为BorderColor.light
BoxDecoration bgAndBorderLeft({Color? bg, double? width, Color? color}) {
  return BoxDecoration(
      color: bg ?? Style.white, border: Border(left: borderSide(width, color)));
}

/// 背景色和右边框
/// * [Color] bg 背景色 默认为BgColor.white
/// * [double] width 宽度 默认为1
/// * [Color] color 边框颜色 默认为BorderColor.light
BoxDecoration bgAndBorderRight({Color? bg, double? width, Color? color}) {
  return BoxDecoration(
      color: bg ?? Style.white,
      border: Border(right: borderSide(width, color)));
}

/// 背景色和上边框
/// * [Color] bg 背景色 默认为BgColor.white
/// * [double] width 宽度 默认为1
/// * [Color] color 边框颜色 默认为BorderColor.light
BoxDecoration bgAndBorderTop({Color? bg, double? width, Color? color}) {
  return BoxDecoration(
      color: bg ?? Style.white, border: Border(top: borderSide(width, color)));
}

/// 背景色和下边框
/// * [Color] bg 背景色 默认为BgColor.white
/// * [double] width 宽度 默认为1
/// * [Color] color 边框颜色 默认为BorderColor.light
BoxDecoration bgAndBorderBottom({Color? bg, double? width, Color? color}) {
  return BoxDecoration(
      color: bg ?? Style.white,
      border: Border(bottom: borderSide(width, color)));
}

/// 背景色和四边框
/// * [Color] bg 背景色 默认为BgColor.white
/// * [double] width 宽度 默认为1
/// * [Color] color 边框颜色 默认为BorderColor.light
BoxDecoration bgAndBorder({Color? bg, double? width, Color? color}) {
  return BoxDecoration(
      color: bg ?? Style.white,
      border: Border.all(width: width ?? 1, color: color ?? Style.borderlight));
}

/// 背景色和左侧两圆角
/// * [Color] bg 背景色 默认为BgColor.white
/// * [double] radius 宽度 默认为0
BoxDecoration bgAndCircLeft({Color? bg, double? radius}) {
  var r = Radius.circular(radius ?? 0);
  return BoxDecoration(
      color: bg ?? Style.white,
      borderRadius: BorderRadius.only(bottomLeft: r, topLeft: r));
}

/// 背景色和上侧两圆角
/// * [Color] bg 背景色 默认为BgColor.white
/// * [double] radius 宽度 默认为0
BoxDecoration bgAndCircTop({Color? bg, double? radius}) {
  var r = Radius.circular(radius ?? 0);
  return BoxDecoration(
      color: bg ?? Style.white,
      borderRadius: BorderRadius.only(topRight: r, topLeft: r));
}

/// 背景色和右侧两圆角
/// * [Color] bg 背景色 默认为BgColor.white
/// * [double] radius 宽度 默认为0
BoxDecoration bgAndCircRight({Color? bg, double? radius}) {
  var r = Radius.circular(radius ?? 0);
  return BoxDecoration(
      color: bg ?? Style.white,
      borderRadius: BorderRadius.only(topRight: r, bottomRight: r));
}

/// 背景色和下侧两圆角
/// * [Color] bg 背景色 默认为BgColor.white
/// * [double] radius 宽度 默认为0
BoxDecoration bgAndCircBottom({Color? bg, double? radius}) {
  var r = Radius.circular(radius ?? 0);
  return BoxDecoration(
      color: bg ?? Style.white,
      borderRadius: BorderRadius.only(bottomLeft: r, bottomRight: r));
}

/// 背景色和四圆角
/// * [Color] bg 背景色 默认为BgColor.white
/// * [double] radius 宽度 默认为0
BoxDecoration bgAndCirc({Color? bg, double? radius}) {
  return BoxDecoration(
      color: bg ?? Style.white,
      borderRadius: BorderRadius.all(Radius.circular(radius ?? 0)));
}

PreferredSize appBarBorder(AppBar child) {
  return PreferredSize(
    child: Container(decoration: borderBottom(), child: child),
    preferredSize: const Size.fromHeight(kToolbarHeight),
  );
}

/// 自动生成一个白底黑字的标题栏，可选是否有后退按钮，有的话会自动加上点击事件
AppBar appBar(
  BuildContext context,
  String title, {
  bool showBack = true,
  List<Widget>? actions,
  Color? backgroundColor,
  bool centerTitle = true,
  bool showRightSpace = true,
  Brightness brightness = Brightness.dark,
  Color? color,
  Color? backIconColor,
  double? fontSize,
}) {
  var nActions = actions;
  if (actions?.isNotEmpty == true && showRightSpace) {
    nActions!.add(Padding(
      padding: EdgeInsets.only(right: Style.spacesm),
    ));
  }
  return AppBar(
    backgroundColor: backgroundColor ?? Style.blue,
    leadingWidth: rpx(48) + Style.spacelg * 2,
    leading: showBack == true
        ? IconButton(
            icon: image(R.imagesIconBackPng, rpx(48), rpx(48),
                color: backIconColor ?? Style.white),
            onPressed: () => Navigator.of(context).pop(),
          )
        : null,
    elevation: 0,
    titleSpacing: showBack ? 0 : Style.spacelg,
    actions: nActions,
    centerTitle: centerTitle,
    systemOverlayStyle:
        SystemUiOverlayStyle(statusBarIconBrightness: brightness),
    automaticallyImplyLeading: false,
    title: text(
      title,
      fontSize: fontSize ?? Style.fontlg,
      color: color ?? Style.white,
    ),
  );
}

BoxDecoration cardDecoration([Color? bgColor]) {
  return BoxDecoration(
      border: Border.all(color: Style.borderlight, width: rpx(1)),
      gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Style.red.withOpacity(0.1),
            Style.blue.withOpacity(0.1),
            Style.orange.withOpacity(0.1),
            Style.green.withOpacity(0.1),
            Style.purple.withOpacity(0.1),
          ],
          stops: const [
            0.2,
            0.4,
            0.6,
            0.8,
            1
          ]),
      borderRadius: BorderRadius.all(Radius.circular(Style.borderRadiussm)),
      boxShadow: [
        BoxShadow(
            offset: const Offset(0, 0),
            color: (bgColor ?? Style.white).withOpacity(0.6),
            blurRadius: 1)
      ]);
}

Widget? dataStatus(
  realTimeWeather,
  sevenWeather,
  hourWeather,
  indicesList,
  warningWeather,
) {
  var loaded = false;
  var error = '';
  if (realTimeWeather?.loaded == true &&
      sevenWeather?.loaded == true &&
      hourWeather?.loaded == true &&
      indicesList?.loaded == true &&
      warningWeather?.loaded == true) {
    loaded = true;
  }
  if (realTimeWeather?.error?.isNotEmpty == true) {
    error = realTimeWeather!.error!;
  } else if (hourWeather?.error?.isNotEmpty == true) {
    error = hourWeather!.error!;
  } else if (sevenWeather?.error?.isNotEmpty == true) {
    error = sevenWeather!.error!;
  } else if (indicesList?.error?.isNotEmpty == true) {
    error = indicesList!.error!;
  } else if (warningWeather?.error?.isNotEmpty == true) {
    error = warningWeather!.error!;
  }
  Widget? preView;
  if (!loaded) {
    preView = Center(
        child: text('正在加载...', color: Style.white, fontSize: Style.fontlg));
  } else if (error.isNotEmpty == true) {
    preView = Center(
        child: text('数据错误,$error', color: Style.white, fontSize: Style.fontlg));
  }
  return preView;
}
