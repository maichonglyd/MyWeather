import 'package:app/app.dart';
import 'package:app/redux/model/indices.dart';
import 'package:app/utils/utils.dart';
import 'package:redux/redux.dart';
import '../redux.dart';
import '../actions.dart';

// action
class IndicesRequestAction extends Action {
  final Function? callback;
  IndicesRequestAction({this.callback})
      : super(type: ActionType.indicesRequest);
}

// success action
class IndicesSuccessAction extends Action {
  List<Indices> payload;

  IndicesSuccessAction({required this.payload})
      : super(type: ActionType.indicesSuccess);
}

// failure action
class IndicesFailureAction extends Action {
  String error;
  IndicesFailureAction({required this.error})
      : super(type: ActionType.indicesFailure);
}

// 请求子reducer
AppState request(AppState state, IndicesRequestAction action) {
  if (action.type == ActionType.indicesRequest) {
    var newState = state.clone();
    RecordList<Indices>? weather = state.indicesList ?? RecordList<Indices>();

    weather.fetching = true;
    newState.indicesList = weather;
    return newState;
  }
  return state;
}

// 成功获取数据 子reducer
AppState success(AppState state, IndicesSuccessAction action) {
  if (action.type == ActionType.indicesSuccess) {
    RecordList<Indices>? weather = state.indicesList ?? RecordList<Indices>();

    weather.fetching = false;
    weather.loaded = true;
    weather.error = null;
    weather.results = action.payload;
    state.indicesList = weather;
    return state;
  }
  return state;
}

// 获取数据失败 子reducer
AppState failure(AppState state, IndicesFailureAction action) {
  if (action.type == ActionType.indicesFailure) {
    RecordList<Indices>? weather = state.indicesList ?? RecordList<Indices>();

    weather.fetching = false;
    weather.loaded = true;
    weather.error = action.error;
    state.indicesList = weather;
  }
  return state;
}

Map indicesReducer() {
  return {
    ActionType.indicesRequest: request,
    ActionType.indicesSuccess: success,
    ActionType.indicesFailure: failure,
  };
}

// saga 要先执行next();否则数据更新顺序会乱
indicesEffect(Store<AppState> store, dynamic action, NextDispatcher next) {
  next(action);
  if (action.type == ActionType.indicesRequest) {
    _loadData(store, action);
  }
}

_loadData(store, IndicesRequestAction action) async {
  if (app.currentCityId?.isNotEmpty != true) {
    dispatch(IndicesFailureAction(error: '请选择城市'));
    return;
  }
  //请求数据
  try {
    var res = await app.api.get('/v7/indices/1d', queryParameters: {
      'key': app.apiKey,
      'location': app.currentCityId,
      'type': '1,2,3,4,5,9,11,15,16'
    });
    var data = res.data;
    if (data['code'] == '200') {
      List<Indices> list = [];
      for (var item in data['daily']) {
        var t = Indices.parse(item);
        list.add(t);
      }
      dispatch(IndicesSuccessAction(payload: list));
    } else {
      dispatch(IndicesFailureAction(error: apiErrorText(data['code'])));
    }
  } catch (e) {
    dispatch(IndicesFailureAction(error: e.toString()));
  } finally {
    action.callback?.call();
  }
}
