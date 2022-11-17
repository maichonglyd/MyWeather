import 'package:app/redux/reducer/startup.dart';
import 'package:app/redux/redux.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:redux/redux.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'utils/events.dart';

class App {
  final MyEvents events = MyEvents.getInstanse();
  final Dio api = Dio(BaseOptions(baseUrl: 'https://devapi.qweather.com'));
  late Store<AppState> store;
  late SharedPreferences sharePreference;
  final apiKey = 'b55dc643e21f4b12a23937542d1ebe84';
  final publicId = 'HE2207191052501184';
  String? currentCityId;

  init() async {
    store = Store<AppState>(
      mainReducer,
      initialState: initialState(),
      middleware: allMiddleware(),
    );

    store.dispatch(StartupAction(value: 'start'));
    sharePreference = await SharedPreferences.getInstance();
    currentCityId = sharePreference.getString('city');
  }
}

final App app = App();

const bool kDebugMode = true;

mprint(s) {
  debugPrint(s);
}
