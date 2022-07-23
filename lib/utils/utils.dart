import 'dart:async';
import 'dart:ui';

import 'package:app/theme.dart';
import 'package:app/utils/city.dart';
import 'package:day/day.dart';

Future delay(int ms) async {
  Completer c = Completer();
  Timer(Duration(milliseconds: ms), () => c.complete());
  return c.future;
}

String apiErrorText(String code) {
  switch (code) {
    case '204':
      return '暂无当前城市的数据';
    case '400':
      return '请求错误,缺少参数';
    case '401':
      return '认证失败';
    case '402':
      return '访问次数不足，因为没钱充值';
    case '403':
      return '没有权限，因为没钱充值';
    case '404':
      return '查询的地区或数据不存在';
    case '429':
      return '刷新太快了，1分钟后再来吧';
    case '500':
      return '接口无响应';
    default:
      return '未知错误';
  }
}

getCurrentCity(String id) {
  for (var province in cityData) {
    if ((province['subs'] as List<Map<String, dynamic>>?)?.isNotEmpty == true) {
      for (var city in (province['subs'] as List<Map<String, dynamic>>)) {
        if ((city['subs'] as List<Map<String, String>>?)?.isNotEmpty == true) {
          for (var country in (city['subs'] as List<Map<String, String>>)) {
            if (id == country['id']) {
              return country;
            }
          }
        }
      }
    }
  }
}

String dayToWeek(String day) {
  var week = Day.fromString(day).toLocal().weekday();
  if (week == 1) return '周一';
  if (week == 2) return '周二';
  if (week == 3) return '周三';
  if (week == 4) return '周四';
  if (week == 5) return '周五';
  if (week == 6) return '周六';
  return '周日';
}

String codeToBg(String code) {
  int _code = int.tryParse(code) ?? 999;
  if (_code >= 310 && _code <= 399) {
    _code = 306;
  } else if (_code >= 405 && _code <= 499) {
    _code = 405;
  } else if (_code == 508) {
    _code = 507;
  } else if (_code >= 509 && _code <= 515) {
    _code = 509;
  } else if (_code >= 801 && _code <= 803) {
    _code = 801;
  } else if (_code >= 805 && _code <= 807) {
    _code = 805;
  }
  if (!_codeList.contains(_code)) {
    _code = 999;
  }
  return 'images/bg$_code.png';
}

String codeToIcon(String code) {
  int _code = int.tryParse(code) ?? 999;
  return 'images/$_code.png';
}

Color? codeToColor(String code) {
  int _code = int.tryParse(code) ?? 999;
  if (_code < 300) {
    return Style.red;
  } else if (_code < 400) {
    return Style.blue;
  } else if (_code < 500) {
    return Style.purple;
  } else if (_code < 800) {
    return Style.orange;
  }
  return null;
}

/// 已有状态图片列表 判断是否有未知code
const _codeList = [
  100,
  101,
  102,
  103,
  104,
  150,
  151,
  152,
  153,
  154,
  300,
  301,
  302,
  303,
  304,
  305,
  306,
  307,
  308,
  309,
  400,
  401,
  402,
  403,
  404,
  405,
  500,
  501,
  502,
  503,
  504,
  507,
  509,
  800,
  801,
  804,
  805,
  900,
  901,
  999
];

final iconCode = [
  310,
  311,
  312,
  313,
  314,
  315,
  316,
  317,
  318,
  350,
  351,
  399,
  406,
  407,
  408,
  409,
  410,
  456,
  457,
  499,
  508,
  510,
  511,
  512,
  513,
  514,
  515,
  802,
  803,
  806,
  807,
  ..._codeList,
];
