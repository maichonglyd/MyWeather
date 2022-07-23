import 'package:app/components/base_widget.dart';
import 'package:app/redux/model/hour_weather.dart';
import 'package:app/theme.dart';
import 'package:app/utils/utils.dart';
import 'package:day/day.dart';
import 'package:flutter/material.dart';

class HourWeatherWidget extends StatelessWidget {
  final HourWeather hour;

  const HourWeatherWidget({Key? key, required this.hour}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: space(Style.spacemd),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          text('${hour.temp}°', color: Style.textgrey),
          image(codeToIcon(hour.icon!), rpx(40), rpx(40),
              color: codeToColor(hour.icon!)),
          text('${hour.text}', color: codeToColor(hour.icon!)),
          text('${hour.precip}mm',
              color: codeToColor(hour.icon!), fontSize: Style.fontxs),
          text('${hour.windDir}',
              color: Style.textgrey, fontSize: Style.fontsm),
          text('${hour.windScale}级',
              color: Style.textgrey, fontSize: Style.fontsm),
          text(Day.fromString(hour.fxTime!).toLocal().format('HH:mm'),
              color: Style.blue),
        ],
      ),
    );
  }
}
