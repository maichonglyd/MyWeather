// Action的类型，需要新类型时在此处添加

enum ActionType {
  startup,
  realTimeWeatherRequest,
  realTimeWeatherSuccess,
  realTimeWeatherFailure,

  hourWeatherRequest,
  hourWeatherSuccess,
  hourWeatherFailure,

  sevenWeatherRequest,
  sevenWeatherSuccess,
  sevenWeatherFailure,

  warningWeatherRequest,
  warningWeatherSuccess,
  warningWeatherFailure,

  indicesRequest,
  indicesSuccess,
  indicesFailure,
}

// 所有Action的基类
class Action {
  ActionType type;
  Action({required this.type});
}

// 详情基础数据类型
class Record<T> {
  bool fetching;
  bool loaded;
  String? error;
  T? result;
  Record({this.fetching = true, this.loaded = false, this.result, this.error});
}

// 所有不分页列表数据的基础类型，
class RecordList<T> {
  bool fetching;
  bool loaded;
  String? error;
  List<T>? results;
  RecordList(
      {this.fetching = true, this.loaded = false, this.results, this.error});
}
