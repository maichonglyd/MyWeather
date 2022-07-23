import 'package:app/app.dart';
import 'package:app/redux/model/real_time_weather.dart';
import 'package:app/utils/utils.dart';
import 'package:redux/redux.dart';
import '../redux.dart';
import '../actions.dart';

// action
class RealTimeWeatherRequestAction extends Action {
  final Function? callback;
  RealTimeWeatherRequestAction({this.callback})
      : super(type: ActionType.realTimeWeatherRequest);
}

// success action
class RealTimeWeatherSuccessAction extends Action {
  RealTimeWeather payload;

  RealTimeWeatherSuccessAction({required this.payload})
      : super(type: ActionType.realTimeWeatherSuccess);
}

// failure action
class RealTimeWeatherFailureAction extends Action {
  String error;
  RealTimeWeatherFailureAction({required this.error})
      : super(type: ActionType.realTimeWeatherFailure);
}

// 请求子reducer
AppState request(AppState state, RealTimeWeatherRequestAction action) {
  if (action.type == ActionType.realTimeWeatherRequest) {
    var newState = state.clone();
    Record<RealTimeWeather>? weather =
        state.realTimeWeather ?? Record<RealTimeWeather>();

    weather.fetching = true;
    newState.realTimeWeather = weather;
    return newState;
  }
  return state;
}

// 成功获取数据 子reducer
AppState success(AppState state, RealTimeWeatherSuccessAction action) {
  if (action.type == ActionType.realTimeWeatherSuccess) {
    Record<RealTimeWeather>? weather =
        state.realTimeWeather ?? Record<RealTimeWeather>();
    weather.fetching = false;
    weather.loaded = true;
    weather.error = null;
    weather.result = action.payload;
    state.realTimeWeather = weather;
    return state;
  }
  return state;
}

// 获取数据失败 子reducer
AppState failure(AppState state, RealTimeWeatherFailureAction action) {
  if (action.type == ActionType.realTimeWeatherFailure) {
    Record<RealTimeWeather>? weather =
        state.realTimeWeather ?? Record<RealTimeWeather>();

    weather.fetching = false;
    weather.loaded = true;
    weather.error = action.error;
    state.realTimeWeather = weather;
  }
  return state;
}

Map realTimeWeatherReducer() {
  return {
    ActionType.realTimeWeatherRequest: request,
    ActionType.realTimeWeatherSuccess: success,
    ActionType.realTimeWeatherFailure: failure,
  };
}

// saga 要先执行next();否则数据更新顺序会乱
realTimeWeatherEffect(
    Store<AppState> store, dynamic action, NextDispatcher next) {
  next(action);
  if (action.type == ActionType.realTimeWeatherRequest) {
    _loadData(store, action);
  }
}

_loadData(store, RealTimeWeatherRequestAction action) async {
  if (app.currentCityId?.isNotEmpty != true) {
    dispatch(RealTimeWeatherFailureAction(error: '请选择城市'));
    return;
  }
  //请求数据
  try {
    var res = await app.api.get('/v7/weather/now',
        queryParameters: {'key': app.apiKey, 'location': app.currentCityId});
    var data = res.data;
    if (data['code'] == '200') {
      var t = RealTimeWeather.parse(data['now']);
      dispatch(RealTimeWeatherSuccessAction(payload: t));
    } else {
      dispatch(RealTimeWeatherFailureAction(error: apiErrorText(data['code'])));
    }
  } catch (e) {
    dispatch(RealTimeWeatherFailureAction(error: e.toString()));
  } finally {
    action.callback?.call();
  }
}
