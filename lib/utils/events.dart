import 'package:app/app.dart';

class MyEvents {
  MyEvents._();
  static MyEvents? _app;
  static MyEvents getInstanse() {
    _app ??= MyEvents._();
    return _app!;
  }

  final Map<String, List<Function>> _event = {};

  addListener(String eventName, Function func) {
    if (_event[eventName] == null) {
      _event[eventName] = <Function>[];
    }
    List<Function> list = _event[eventName]!;
    bool has = false;
    for (var item in list) {
      if (item == func) {
        has = true;
      }
    }
    if (!has) {
      _event[eventName]!.add(func);
    }
  }

  removeListener(String eventName, Function func) {
    if (_event.containsKey(eventName)) {
      List<Function> list = _event[eventName] ?? [];
      if (list.contains(func)) {
        list.remove(func);
      }
    }
  }

  send<T>(String eventName, T data) {
    List<Function> list = _event[eventName] ?? [];
    for (var func in list) {
      try {
        func(data);
      } catch (e) {
        if (kDebugMode) {
          mprint('error: $e');
        }
      }
    }
  }
}
