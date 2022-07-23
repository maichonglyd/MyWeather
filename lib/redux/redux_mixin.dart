import 'dart:async';
import 'package:app/app.dart';
import 'package:app/redux/redux.dart';
import 'package:flutter/material.dart';

mixin ReduxMixin<T extends StatefulWidget> on State<T> {
  @protected
  late StreamSubscription<AppState> stream;
  @override
  @mustCallSuper
  void initState() {
    super.initState();
    stream = app.store.onChange.listen(connect);
    connect(app.store.state);
  }

  void connect(AppState state) {}

  void setData(void Function() callback) {
    if (mounted) {
      setState(callback);
    }
  }

  @override
  @mustCallSuper
  void dispose() {
    stream.cancel();
    super.dispose();
  }
}
