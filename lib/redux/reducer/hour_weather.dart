import 'package:app/app.dart';
import 'package:app/redux/model/hour_weather.dart';
import 'package:app/utils/utils.dart';
import 'package:redux/redux.dart';
import '../redux.dart';
import '../actions.dart';

// action
class HourWeatherRequestAction extends Action {
  final Function? callback;
  HourWeatherRequestAction({this.callback})
      : super(type: ActionType.hourWeatherRequest);
}

// success action
class HourWeatherSuccessAction extends Action {
  List<HourWeather> payload;

  HourWeatherSuccessAction({required this.payload})
      : super(type: ActionType.hourWeatherSuccess);
}

// failure action
class HourWeatherFailureAction extends Action {
  String error;
  HourWeatherFailureAction({required this.error})
      : super(type: ActionType.hourWeatherFailure);
}

// 请求子reducer
AppState request(AppState state, HourWeatherRequestAction action) {
  if (action.type == ActionType.hourWeatherRequest) {
    var newState = state.clone();
    RecordList<HourWeather>? weather =
        state.hourWeather ?? RecordList<HourWeather>();

    weather.fetching = true;
    newState.hourWeather = weather;
    return newState;
  }
  return state;
}

// 成功获取数据 子reducer
AppState success(AppState state, HourWeatherSuccessAction action) {
  if (action.type == ActionType.hourWeatherSuccess) {
    RecordList<HourWeather>? weather =
        state.hourWeather ?? RecordList<HourWeather>();

    weather.fetching = false;
    weather.loaded = true;
    weather.error = null;
    weather.results = action.payload;
    state.hourWeather = weather;
    return state;
  }
  return state;
}

// 获取数据失败 子reducer
AppState failure(AppState state, HourWeatherFailureAction action) {
  if (action.type == ActionType.hourWeatherFailure) {
    RecordList<HourWeather>? weather =
        state.hourWeather ?? RecordList<HourWeather>();

    weather.fetching = false;
    weather.loaded = true;
    weather.error = action.error;
    state.hourWeather = weather;
  }
  return state;
}

Map hourWeatherReducer() {
  return {
    ActionType.hourWeatherRequest: request,
    ActionType.hourWeatherSuccess: success,
    ActionType.hourWeatherFailure: failure,
  };
}

// saga 要先执行next();否则数据更新顺序会乱
hourWeatherEffect(Store<AppState> store, dynamic action, NextDispatcher next) {
  next(action);
  if (action.type == ActionType.hourWeatherRequest) {
    _loadData(store, action);
  }
}

_loadData(store, HourWeatherRequestAction action) async {
  if (app.currentCityId?.isNotEmpty != true) {
    dispatch(HourWeatherFailureAction(error: '请选择城市'));
    return;
  }
  //请求数据
  try {
    var res = await app.api.get('/v7/weather/24h',
        queryParameters: {'key': app.apiKey, 'location': app.currentCityId});
    var data = res.data;
    if (data['code'] == '200') {
      List<HourWeather> list = [];
      for (var item in data['hourly']) {
        var t = HourWeather.parse(item);
        list.add(t);
      }
      dispatch(HourWeatherSuccessAction(payload: list));
    } else {
      dispatch(HourWeatherFailureAction(error: apiErrorText(data['code'])));
    }
  } catch (e) {
    dispatch(HourWeatherFailureAction(error: e.toString()));
  } finally {
    action.callback?.call();
  }
}
