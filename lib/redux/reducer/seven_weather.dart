import 'package:app/app.dart';
import 'package:app/redux/model/seven_weather.dart';
import 'package:app/utils/utils.dart';
import 'package:redux/redux.dart';
import '../redux.dart';
import '../actions.dart';

// action
class SevenWeatherRequestAction extends Action {
  final Function? callback;
  SevenWeatherRequestAction({this.callback})
      : super(type: ActionType.sevenWeatherRequest);
}

// success action
class SevenWeatherSuccessAction extends Action {
  List<SevenWeather> payload;

  SevenWeatherSuccessAction({required this.payload})
      : super(type: ActionType.sevenWeatherSuccess);
}

// failure action
class SevenWeatherFailureAction extends Action {
  String error;
  SevenWeatherFailureAction({required this.error})
      : super(type: ActionType.sevenWeatherFailure);
}

// 请求子reducer
AppState request(AppState state, SevenWeatherRequestAction action) {
  if (action.type == ActionType.sevenWeatherRequest) {
    var newState = state.clone();
    RecordList<SevenWeather>? weather =
        state.sevenWeather ?? RecordList<SevenWeather>();

    weather.fetching = true;
    newState.sevenWeather = weather;
    return newState;
  }
  return state;
}

// 成功获取数据 子reducer
AppState success(AppState state, SevenWeatherSuccessAction action) {
  if (action.type == ActionType.sevenWeatherSuccess) {
    RecordList<SevenWeather>? weather =
        state.sevenWeather ?? RecordList<SevenWeather>();

    weather.fetching = false;
    weather.loaded = true;
    weather.error = null;
    weather.results = action.payload;
    state.sevenWeather = weather;
    return state;
  }
  return state;
}

// 获取数据失败 子reducer
AppState failure(AppState state, SevenWeatherFailureAction action) {
  if (action.type == ActionType.sevenWeatherFailure) {
    RecordList<SevenWeather>? weather =
        state.sevenWeather ?? RecordList<SevenWeather>();

    weather.fetching = false;
    weather.loaded = true;
    weather.error = action.error;
    state.sevenWeather = weather;
  }
  return state;
}

Map sevenWeatherReducer() {
  return {
    ActionType.sevenWeatherRequest: request,
    ActionType.sevenWeatherSuccess: success,
    ActionType.sevenWeatherFailure: failure,
  };
}

// saga 要先执行next();否则数据更新顺序会乱
sevenWeatherEffect(Store<AppState> store, dynamic action, NextDispatcher next) {
  next(action);
  if (action.type == ActionType.sevenWeatherRequest) {
    _loadData(store, action);
  }
}

_loadData(store, SevenWeatherRequestAction action) async {
  if (app.currentCityId?.isNotEmpty != true) {
    dispatch(SevenWeatherFailureAction(error: '请选择城市'));
    return;
  }
  //请求数据
  try {
    var res = await app.api.get('/v7/weather/7d',
        queryParameters: {'key': app.apiKey, 'location': app.currentCityId});
    var data = res.data;
    if (data['code'] == '200') {
      List<SevenWeather> list = [];
      for (var item in data['daily']) {
        var t = SevenWeather.parse(item);
        list.add(t);
      }
      dispatch(SevenWeatherSuccessAction(payload: list));
    } else {
      dispatch(SevenWeatherFailureAction(error: apiErrorText(data['code'])));
    }
  } catch (e) {
    dispatch(SevenWeatherFailureAction(error: e.toString()));
  } finally {
    action.callback?.call();
  }
}
