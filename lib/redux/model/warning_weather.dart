class WarningWeather {
  ///本条预警的唯一标识，可判断本条预警是否已经存在
  String? id;

  ///预警发布单位，可能为空
  String? sender;

  ///预警发布时间
  String? pubTime;

  ///预警信息标题
  String? title;

  ///预警开始时间，可能为空
  String? startTime;

  ///预警结束时间，可能为空
  String? endTime;

  ///预警信息的发布状态
  String? status;

  ///预警严重等级
  String? severity;

  ///预警严重等级颜色，可能为空
  String? severityColor;

  ///预警类型ID
  String? type;

  ///预警类型名称
  String? typeName;

  ///预警信息的紧迫程度，可能为空
  String? urgency;

  ///预警信息的确定性，可能为空
  String? certainty;

  ///预警详细文字描述
  String? text;

  static WarningWeather parse(dynamic data) {
    var t = WarningWeather();

    t.id = data['id'];
    t.sender = data['sender'];
    t.pubTime = data['pubTime'];
    t.title = data['title'];
    t.startTime = data['startTime'];
    t.endTime = data['endTime'];
    t.status = data['status'];
    t.severity = data['severity'];
    t.severityColor = data['severityColor'];
    t.type = data['type'];
    t.typeName = data['typeName'];
    t.text = data['text'];
    return t;
  }
}
