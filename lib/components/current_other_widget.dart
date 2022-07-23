import 'package:app/components/base_widget.dart';
import 'package:app/redux/model/real_time_weather.dart';
import 'package:app/redux/model/seven_weather.dart';
import 'package:app/theme.dart';
import 'package:flutter/material.dart';

class CurrentOtherWidget extends StatelessWidget {
  final RealTimeWeather curr;
  final SevenWeather seven;
  const CurrentOtherWidget({Key? key, required this.curr, required this.seven})
      : super(key: key);
  buildSmallItem(String label, String value, String unit, Color color) {
    return Expanded(
        child: Column(
      children: [
        Text.rich(TextSpan(children: [
          TextSpan(
              text: value, style: TextStyle(fontSize: rpx(50), color: color)),
          TextSpan(
              text: unit,
              style: TextStyle(fontSize: Style.fontxs, color: color))
        ])),
        // paddingBottom(Style.spacesm),
        text(label, color: color)
      ],
    ));
  }

  @override
  Widget build(BuildContext context) {
    var _text = seven.textDay ?? '';
    if (_text != seven.textNight) {
      _text = '$_text转${seven.textNight}';
    }
    var currPrecip = int.tryParse(curr.precip ?? '0') ?? 0;
    var allPrecip = int.tryParse(seven.precip ?? '0') ?? 0;
    if (currPrecip > 0) {
      _text = '$_text,预计当前降水量${curr.precip}mm,';
    }
    if (allPrecip > 0) {
      _text = '$_text,今天降水量${seven.precip}mm';
    }

    var _windDir = seven.windDirDay ?? '';
    if (_windDir != seven.windDirNight) {
      _windDir = '$_windDir转${seven.windDirNight}';
    }

    var _windScale = seven.windScaleDay ?? '';
    if (_windScale != seven.windScaleNight) {
      _windScale = '$_windScale转${seven.windScaleNight}';
    }
    var _humidity = int.tryParse(curr.humidity!) ?? 50;
    var _humidityText = _humidity < 40
        ? '较干，注意保湿'
        : _humidity > 70
            ? '较湿,注意防潮'
            : '比较舒适';
    return Container(
        margin: spaceHorizontal(),
        padding: space(),
        height: rpx(280),
        alignment: Alignment.center,
        decoration: cardDecoration(),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            text('今天白天到夜间$_text,$_windDir,风力$_windScale级,当前湿度$_humidityText'),
            paddingBottom(),
            Expanded(
                child: Row(
              children: [
                buildSmallItem(curr.windDir ?? '风向', curr.windScale ?? '1', '级',
                    Style.orange),
                buildSmallItem('空气湿度', curr.humidity ?? '50', '%', Style.blue),
                buildSmallItem(
                    '体感温度', curr.feelsLike ?? '22', '°C', Style.green),
                buildSmallItem(
                    '大气压强', curr.pressure ?? '1000', 'hPa', Style.purple),
              ],
            ))
          ],
        ));
  }
}
