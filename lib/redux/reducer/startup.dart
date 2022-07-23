import 'package:app/redux/actions.dart';
import 'package:app/redux/redux.dart';

class StartupAction extends Action {
  String value;
  StartupAction({required this.value}) : super(type: ActionType.startup);

  @override
  String toString() {
    return 'type:${ActionType.startup},value:$value';
  }
}

AppState startup(AppState state, StartupAction action) {
  state.startup = action.value;
  return state;
}

Map startUpReducer() {
  return {
    ActionType.startup: startup,
  };
}
