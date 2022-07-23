import 'package:app/components/base_widget.dart';
import 'package:app/redux/model/warning_weather.dart';
import 'package:app/theme.dart';
import 'package:day/day.dart';
import 'package:flutter/material.dart';

class WarningWeatherWidget extends StatelessWidget {
  final WarningWeather weather;
  const WarningWeatherWidget({Key? key, required this.weather})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    Color _bgColor = Colors.white;
    Color _textColor = Style.textdark;
    String _text = '';
    var _c = weather.severityColor?.toLowerCase();
    if (_c == 'white') {
      _bgColor = Colors.white;
      _textColor = Style.textdark;
      _text = '白';
    } else if (_c == 'blue') {
      _bgColor = Colors.blue;
      _textColor = Style.white;
      _text = '蓝';
    } else if (_c == 'green') {
      _bgColor = Colors.green;
      _textColor = Style.white;
      _text = '绿';
    } else if (_c == 'yellow') {
      _bgColor = Colors.yellow;
      _textColor = Style.textdark;
      _text = '黄';
    } else if (_c == 'orange') {
      _bgColor = Colors.orange;
      _textColor = Style.white;
      _text = '橙';
    } else if (_c == 'red') {
      _bgColor = Colors.red;
      _textColor = Style.white;
      _text = '红';
    } else if (_c == 'black') {
      _bgColor = Colors.black;
      _textColor = Style.white;
      _text = '黑';
    }

    return Container(
      margin: spaceRound(0, Style.spacelg, Style.spacemd, Style.spacelg),
      alignment: Alignment.topLeft,
      decoration: cardDecoration(_bgColor),
      padding: space(Style.spacemd),
      child: Column(children: [
        Row(
          children: [
            Container(
                padding: space(Style.spacexs),
                margin: spaceRight(Style.spacemd),
                decoration: BoxDecoration(
                    color: _bgColor,
                    borderRadius: BorderRadius.circular(Style.borderRadiussm)),
                child: text('$_text色预警',
                    color: _textColor, fontSize: Style.fontsm)),
            text(weather.typeName!, color: _textColor, fontSize: Style.fontlg),
          ],
        ),
        paddingBottom(Style.spacesm),
        text(weather.text!, color: _textColor, fontSize: Style.fontsm),
        weather.startTime?.isNotEmpty == true ||
                weather.endTime?.isNotEmpty == true
            ? Container(
                decoration: borderTop(color: Style.bordergrey),
                padding: spaceTop(Style.spacemd),
                margin: spaceTop(Style.spacemd),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    weather.startTime?.isNotEmpty == true
                        ? text(
                            Day.fromString(weather.startTime!)
                                .toLocal()
                                .format('MM-DD HH:mm'),
                            color: _textColor,
                            fontSize: Style.fontsm)
                        : Container(),
                    weather.endTime?.isNotEmpty == true
                        ? text(
                            Day.fromString(weather.endTime!)
                                .toLocal()
                                .format('MM-DD HH:mm'),
                            color: _textColor,
                            fontSize: Style.fontsm)
                        : Container()
                  ],
                ),
              )
            : Container()
      ]),
    );
  }
}
