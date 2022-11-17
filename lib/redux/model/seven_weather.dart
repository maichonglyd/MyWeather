class SevenWeather {
  ///预报日期
  String? fxDate;

  ///日出时间
  String? sunrise;

  ///日落时间
  String? sunset;

  ///月升时间
  String? moonrise;

  ///月落时间
  String? moonset;

  ///月相名称
  String? moonPhase;

  ///月相图标代码，图标可通过天气状况和图标下载
  String? moonPhaseIcon;

  ///预报当天最高温度
  String? tempMax;

  ///预报当天最低温度
  String? tempMin;

  ///预报白天天气状况的图标代码，图标可通过天气状况和图标下载
  String? iconDay;

  ///预报白天天气状况文字描述，包括阴晴雨雪等天气状态的描述
  String? textDay;

  ///预报夜间天气状况的图标代码，图标可通过天气状况和图标下载
  String? iconNight;

  ///预报晚间天气状况文字描述，包括阴晴雨雪等天气状态的描述
  String? textNight;

  ///预报白天风向360角度
  String? wind360Day;

  ///预报白天风向
  String? windDirDay;

  ///预报白天风力等级
  String? windScaleDay;

  ///预报白天风速，公里/小时
  String? windSpeedDay;

  ///预报夜间风向360角度
  String? wind360Night;

  ///预报夜间当天风向
  String? windDirNight;

  ///预报夜间风力等级
  String? windScaleNight;

  ///预报夜间风速，公里/小时
  String? windSpeedNight;

  ///预报当天总降水量，默认单位：毫米
  String? precip;

  ///紫外线强度指数
  String? uvIndex;

  ///相对湿度，百分比数值
  String? humidity;

  ///大气压强，默认单位：百帕
  String? pressure;

  ///能见度，默认单位：公里
  String? vis;

  ///云量，百分比数值。可能为空
  String? cloud;

  static SevenWeather parse(dynamic data) {
    var t = SevenWeather();
    t.fxDate = data['fxDate'];
    t.sunrise = data['sunrise'];
    t.sunset = data['sunset'];
    t.moonrise = data['moonrise'];
    t.moonset = data['moonset'];
    t.moonPhase = data['moonPhase'];
    t.moonPhaseIcon = data['moonPhaseIcon'];
    t.tempMax = data['tempMax'];
    t.tempMin = data['tempMin'];
    t.iconDay = data['iconDay'];
    t.textDay = data['textDay'];
    t.iconNight = data['iconNight'];
    t.textNight = data['textNight'];
    t.wind360Day = data['wind360Day'];
    t.windDirDay = data['windDirDay'];
    t.windScaleDay = data['windScaleDay'];
    t.windSpeedDay = data['windSpeedDay'];
    t.wind360Night = data['wind360Night'];
    t.windDirNight = data['windDirNight'];
    t.windScaleNight = data['windScaleNight'];
    t.windSpeedNight = data['windSpeedNight'];
    t.humidity = data['humidity'];
    t.precip = data['precip'];
    t.pressure = data['pressure'];
    t.vis = data['vis'];
    t.cloud = data['cloud'];
    t.uvIndex = data['uvIndex'];
    return t;
  }

  Map<String, dynamic> toMap() {
    return {
      'fxDate': fxDate,
      'sunrise': sunrise,
      'sunset': sunset,
      'moonrise': moonrise,
      'moonset': moonset,
      'moonPhase': moonPhase,
      'moonPhaseIcon': moonPhaseIcon,
      'tempMax': tempMax,
      'tempMin': tempMin,
      'iconDay': iconDay,
      'textDay': textDay,
      'iconNight': iconNight,
      'textNight': textNight,
      'wind360Day': wind360Day,
      'windDirDay': windDirDay,
      'windScaleDay': windScaleDay,
      'wind360Night': wind360Night,
      'windDirNight': windDirNight,
      'windScaleNight': windScaleNight,
      'windSpeedNight': windSpeedNight,
      'humidity': humidity,
      'precip': precip,
      'pressure': pressure,
      'vis': vis,
      'cloud': cloud,
      'uvIndex': uvIndex
    };
  }
}
