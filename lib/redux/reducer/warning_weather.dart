import 'package:app/app.dart';
import 'package:app/redux/model/warning_weather.dart';
import 'package:app/utils/utils.dart';
import 'package:redux/redux.dart';
import '../redux.dart';
import '../actions.dart';

// action
class WarningWeatherRequestAction extends Action {
  final Function? callback;
  WarningWeatherRequestAction({this.callback})
      : super(type: ActionType.warningWeatherRequest);
}

// success action
class WarningWeatherSuccessAction extends Action {
  List<WarningWeather> payload;

  WarningWeatherSuccessAction({required this.payload})
      : super(type: ActionType.warningWeatherSuccess);
}

// failure action
class WarningWeatherFailureAction extends Action {
  String error;
  WarningWeatherFailureAction({required this.error})
      : super(type: ActionType.warningWeatherFailure);
}

// 请求子reducer
AppState request(AppState state, WarningWeatherRequestAction action) {
  if (action.type == ActionType.warningWeatherRequest) {
    var newState = state.clone();
    RecordList<WarningWeather>? weather =
        state.warningWeather ?? RecordList<WarningWeather>();

    weather.fetching = true;
    newState.warningWeather = weather;
    return newState;
  }
  return state;
}

// 成功获取数据 子reducer
AppState success(AppState state, WarningWeatherSuccessAction action) {
  if (action.type == ActionType.warningWeatherSuccess) {
    RecordList<WarningWeather>? weather =
        state.warningWeather ?? RecordList<WarningWeather>();

    weather.fetching = false;
    weather.loaded = true;
    weather.error = null;
    weather.results = action.payload;
    state.warningWeather = weather;
    return state;
  }
  return state;
}

// 获取数据失败 子reducer
AppState failure(AppState state, WarningWeatherFailureAction action) {
  if (action.type == ActionType.warningWeatherFailure) {
    RecordList<WarningWeather>? weather =
        state.warningWeather ?? RecordList<WarningWeather>();

    weather.fetching = false;
    weather.loaded = true;
    weather.error = action.error;
    state.warningWeather = weather;
  }
  return state;
}

Map warningWeatherReducer() {
  return {
    ActionType.warningWeatherRequest: request,
    ActionType.warningWeatherSuccess: success,
    ActionType.warningWeatherFailure: failure,
  };
}

// saga 要先执行next();否则数据更新顺序会乱
warningWeatherEffect(
    Store<AppState> store, dynamic action, NextDispatcher next) {
  next(action);
  if (action.type == ActionType.warningWeatherRequest) {
    _loadData(store, action);
  }
}

_loadData(store, WarningWeatherRequestAction action) async {
  if (app.currentCityId?.isNotEmpty != true) {
    dispatch(WarningWeatherFailureAction(error: '请选择城市'));
    return;
  }
  //请求数据
  try {
    var res = await app.api.get('/v7/warning/now',
        queryParameters: {'key': app.apiKey, 'location': app.currentCityId});
    var data = res.data;
    if (data['code'] == '200') {
      List<WarningWeather> list = [];
      for (var item in data['warning']) {
        var t = WarningWeather.parse(item);
        list.add(t);
      }
      dispatch(WarningWeatherSuccessAction(payload: list));
    } else {
      dispatch(WarningWeatherFailureAction(error: apiErrorText(data['code'])));
    }
  } catch (e) {
    dispatch(WarningWeatherFailureAction(error: e.toString()));
  } finally {
    action.callback?.call();
  }
}
