import 'package:app/app.dart';
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
import 'package:app/redux/reducer/startup.dart';
import 'package:app/redux/reducer/warning_weather.dart';

dispatch<T extends Action>(T action) {
  app.store.dispatch(action);
}

// Store的数据类型，所有在Store的顶层显示的数据在此处定义
class AppState {
  String startup;
  Record<RealTimeWeather>? realTimeWeather;
  RecordList<SevenWeather>? sevenWeather;
  RecordList<HourWeather>? hourWeather;
  RecordList<Indices>? indicesList;
  RecordList<WarningWeather>? warningWeather;
  AppState({
    required this.startup,
    this.realTimeWeather,
    this.sevenWeather,
    this.hourWeather,
    this.indicesList,
    this.warningWeather,
  });

  AppState clone() {
    var newState = AppState(
        startup: startup,
        realTimeWeather: realTimeWeather,
        sevenWeather: sevenWeather,
        hourWeather: hourWeather,
        indicesList: indicesList,
        warningWeather: warningWeather);
    return newState;
  }
}

// 总 reducer,根据类型不同，和type不同，分化到不同文件中处理子reducer,
AppState mainReducer(AppState state, dynamic action) {
  Map<dynamic, dynamic> subReducer = {};
  subReducer.addAll(startUpReducer());
  subReducer.addAll(realTimeWeatherReducer());
  subReducer.addAll(sevenWeatherReducer());
  subReducer.addAll(hourWeatherReducer());
  subReducer.addAll(indicesReducer());
  subReducer.addAll(warningWeatherReducer());
  Function? fn = subReducer[action.type];
  if (fn != null) {
    return fn(state, action);
  }
  return state;
}

allMiddleware() {
  return [
    log,
    realTimeWeatherEffect,
    sevenWeatherEffect,
    hourWeatherEffect,
    indicesEffect,
    warningWeatherEffect,
  ];
}

AppState initialState() {
  return AppState(startup: 'noRequest');
}

log(store, action, next) {
  print('store -> action: ${action.type}');
  next(action);
}
