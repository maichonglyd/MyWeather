import 'dart:async';

import 'package:app/app.dart';
import 'package:app/components/base_widget.dart';
import 'package:app/components/current_other_widget.dart';
import 'package:app/components/hour_weather_widget.dart';
import 'package:app/components/indices_widget.dart';
import 'package:app/components/panel_header_widget.dart';
import 'package:app/components/pull_down_refresh.dart';
import 'package:app/components/seven_weather_widget.dart';
import 'package:app/components/warning_weather_widget.dart';
import 'package:app/redux/actions.dart';
import 'package:app/redux/model/hour_weather.dart';
import 'package:app/redux/model/indices.dart';
import 'package:app/redux/model/real_time_weather.dart';
import 'package:app/redux/model/seven_weather.dart';
import 'package:app/redux/model/warning_weather.dart';
import 'package:app/redux/reducer/hour_weather.dart';
import 'package:app/redux/reducer/indices.dart';
import 'package:app/redux/reducer/real_time_weather.dart';
import 'package:app/redux/reducer/seven_weather.dart';
import 'package:app/redux/reducer/warning_weather.dart';
import 'package:app/redux/redux.dart';
import 'package:app/redux/redux_mixin.dart';
import 'package:app/routes.dart';
import 'package:app/theme.dart';
import 'package:app/utils/utils.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _HomePage();
}

class _HomePage extends State<HomePage> with ReduxMixin {
  Record<RealTimeWeather>? realTimeWeather;
  RecordList<SevenWeather>? sevenWeather;
  RecordList<HourWeather>? hourWeather;
  RecordList<Indices>? indicesList;
  RecordList<WarningWeather>? warningWeather;

  late Map<String, String> currentCity;
  @override
  void initState() {
    currentCity = getCurrentCity(app.currentCityId!);
    super.initState();
    handleRefresh();
  }

  @override
  connect(AppState state) {
    setData(() {
      realTimeWeather = state.realTimeWeather;
      sevenWeather = state.sevenWeather;
      hourWeather = state.hourWeather;
      indicesList = state.indicesList;
      warningWeather = state.warningWeather;
    });
  }

  handleSelectCity() async {
    await Navigator.pushNamed(context, RouteName.cityListPage);
    setData(() {
      currentCity = getCurrentCity(app.currentCityId!);
    });
    await handleRefresh();
  }

  Future handleRefresh() async {
    Completer c = Completer();
    var t = 0;
    var max = 5;
    dispatch(RealTimeWeatherRequestAction(callback: () {
      t += 1;
      if (t == max) c.complete();
    }));
    dispatch(SevenWeatherRequestAction(callback: () {
      t += 1;
      if (t == max) c.complete();
    }));
    dispatch(HourWeatherRequestAction(callback: () {
      t += 1;
      if (t == max) c.complete();
    }));
    dispatch(IndicesRequestAction(callback: () {
      t += 1;
      if (t == max) c.complete();
    }));
    dispatch(WarningWeatherRequestAction(callback: () {
      t += 1;
      if (t == max) c.complete();
    }));
    return c.future;
  }

  buildCurrentWeather() {
    var _curr = realTimeWeather?.result;
    return Container(
      height: rpx(180),
      margin: spaceTop(),
      padding: spaceHorizontal(),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          text('${_curr?.temp}',
              fontSize: rpx(180),
              lineHeight: 1,
              color: codeToColor(_curr!.icon!),
              shadow: true),
          paddingRight(Style.spacemd),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              text('⭘',
                  fontSize: rpx(60),
                  lineHeight: 1,
                  color: codeToColor(_curr.icon!),
                  blod: true,
                  shadow: true),
              text('${_curr.text}',
                  color: codeToColor(_curr.icon!), shadow: true),
              paddingBottom(Style.spacesm),
              text('${_curr.windDir}${_curr.windScale}级',
                  color: codeToColor(_curr.icon!), shadow: true),
            ],
          ),
          Expanded(child: Container()),
          image(codeToIcon(_curr.icon!), rpx(60), rpx(60),
              color: codeToColor(_curr.icon!))
        ],
      ),
    );
  }

  buildCurrentOther() {
    var _curr = realTimeWeather?.result;
    var _seven = sevenWeather?.results?[0];
    return CurrentOtherWidget(seven: _seven!, curr: _curr!);
  }

  buildWarningWeather() {
    List<WarningWeather> _list = warningWeather!.results!;
    return Column(
      children: List.generate(
          _list.length, (index) => WarningWeatherWidget(weather: _list[index])),
    );
  }

  buildIndicesList() {
    List<Indices> _list = indicesList?.results ?? [];
    return Container(
      margin: spaceHorizontal(),
      alignment: Alignment.topLeft,
      decoration: cardDecoration(),
      child: Wrap(
          children: List.generate(_list.length,
              (index) => IndicesWidget(indices: _list[index], index: index))),
    );
  }

  buildHourWeather() {
    List<HourWeather> _list = hourWeather?.results ?? [];
    return Container(
      margin: spaceHorizontal(),
      height: rpx(330),
      alignment: Alignment.center,
      decoration: cardDecoration(),
      child: ListView(
          scrollDirection: Axis.horizontal,
          children: List.generate(
              _list.length, (index) => HourWeatherWidget(hour: _list[index]))),
    );
  }

  buildSevenWeather() {
    List<SevenWeather> _list = sevenWeather?.results ?? [];
    return Container(
      margin: spaceRound(0, Style.spacelg, Style.spacelg, Style.spacelg),
      height: rpx(620),
      alignment: Alignment.center,
      decoration: cardDecoration(),
      child: ListView(
          scrollDirection: Axis.horizontal,
          children: List.generate(_list.length,
              (index) => SevenWeatherWidget(seven: _list[index]))),
    );
  }

  @override
  Widget build(BuildContext context) {
    Widget? preView = dataStatus(realTimeWeather, sevenWeather, hourWeather,
        indicesList, warningWeather);
    var hasWarning = (warningWeather?.results?.length ?? 0) > 0;
    return Scaffold(
        body: Container(
      decoration: BoxDecoration(
          image: DecorationImage(
        alignment: Alignment.topCenter,
        image: AssetImage(codeToBg(realTimeWeather?.result?.icon ??
            '999')), // realTimeWeather?.result?.icon ??
        fit: BoxFit.fitHeight,
      )),
      child: Container(
        color: Style.blue.withOpacity(0.2),
        child: Column(
          children: [
            appBar(context, '${currentCity['name']}',
                showBack: false,
                centerTitle: false,
                brightness: Brightness.light,
                backgroundColor: Colors.transparent,
                fontSize: Style.fontxl,
                actions: [
                  GestureDetector(
                    onTap: handleSelectCity,
                    child: Container(
                      padding: spaceHorizontal(),
                      alignment: Alignment.center,
                      child: text('切换城市', color: Style.white),
                    ),
                  )
                ]),
            Expanded(
              child: preView ??
                  PullDownRefresh(
                    refresh: handleRefresh,
                    children: [
                      paddingTop(rpx(100)),
                      buildCurrentWeather(),
                      buildCurrentOther(),
                      hasWarning
                          ? const PanelHeaderWidget(label: '天气灾害预警')
                          : Container(),
                      hasWarning ? buildWarningWeather() : Container(),
                      const PanelHeaderWidget(label: '未来24小时'),
                      buildHourWeather(),
                      const PanelHeaderWidget(label: '今日天气指数'),
                      buildIndicesList(),
                      const PanelHeaderWidget(label: '未来7天'),
                      buildSevenWeather()
                    ],
                  ),
            )
          ],
        ),
      ),
    ));
  }
}
