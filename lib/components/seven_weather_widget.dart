import 'package:app/components/base_widget.dart';
import 'package:app/redux/model/seven_weather.dart';
import 'package:app/theme.dart';
import 'package:app/utils/utils.dart';
import 'package:day/day.dart';
import 'package:flutter/material.dart';

class SevenWeatherWidget extends StatelessWidget {
  final SevenWeather seven;

  const SevenWeatherWidget({Key? key, required this.seven}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: space(Style.spacemd),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          text(dayToWeek(seven.fxDate!), fontSize: Style.fontlg),
          text(Day.fromString(seven.fxDate!).toLocal().format('MM/DD'),
              fontSize: Style.fontxs, color: Style.textlight),
          image(codeToIcon(seven.iconDay!), rpx(40), rpx(40),
              color: codeToColor(seven.iconDay!)),
          text('${seven.textDay}', color: codeToColor(seven.iconDay!)),
          text('${seven.tempMax}°', color: Style.textgrey),
          text('${seven.windDirDay}${seven.windScaleDay}级',
              color: Style.textgrey, fontSize: Style.fontxs),
          Row(
            children: [
              Container(
                width: rpx(40),
                height: rpx(40),
                margin: spaceRight(Style.spacesm),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(rpx(40))),
                  gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [Style.white, Style.black],
                      stops: const [0.4, 1]),
                ),
              ),
              text('${seven.precip}mm',
                  color: Style.textBlue, fontSize: Style.fontxs),
            ],
          ),
          text('${seven.windDirNight}${seven.windScaleNight}级',
              color: Style.textgrey, fontSize: Style.fontxs),
          text('${seven.tempMin}°', color: Style.textgrey),
          text('${seven.textNight}', color: codeToColor(seven.iconNight!)),
          image(codeToIcon(seven.iconNight!), rpx(40), rpx(40),
              color: codeToColor(seven.iconNight!)),
        ],
      ),
    );
  }
}
