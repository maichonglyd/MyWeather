class RealTimeWeather {
  ///数据观测时间
  String? obsTime;

  ///温度，默认单位：摄氏度
  String? temp;

  ///体感温度，默认单位：摄氏度
  String? feelsLike;

  ///天气状况和图标的代码，图标可通过天气状况和图标下载
  String? icon;

  ///天气状况的文字描述，包括阴晴雨雪等天气状态的描述
  String? text;

  ///风向360角度
  String? wind360;

  ///风向
  String? windDir;

  ///风力等级
  String? windScale;

  ///风速，公里/小时
  String? windSpeed;

  /// 相对湿度，百分比数值
  String? humidity;

  /// 当前小时累计降水量，默认单位：毫米
  String? precip;

  ///大气压强，默认单位：百帕
  String? pressure;

  ///能见度，默认单位：公里
  String? vis;

  ///云量，百分比数值。可能为空
  String? cloud;

  ///露点温度。可能为空
  String? dew;
  static RealTimeWeather parse(dynamic data) {
    var t = RealTimeWeather();
    t.obsTime = data['obsTime'];
    t.temp = data['temp'];
    t.feelsLike = data['feelsLike'];
    t.icon = data['icon'];
    t.text = data['text'];
    t.wind360 = data['wind360'];
    t.windDir = data['windDir'];
    t.windScale = data['windScale'];
    t.windSpeed = data['windSpeed'];
    t.humidity = data['humidity'];
    t.precip = data['precip'];
    t.pressure = data['pressure'];
    t.vis = data['vis'];
    t.cloud = data['cloud'];
    t.dew = data['dew'];
    return t;
  }

  Map<String, dynamic> toMap() {
    return {
      'obsTime': obsTime,
      'temp': temp,
      'feelsLike': feelsLike,
      'icon': icon,
      'text': text,
      'wind360': wind360,
      'windDir': windDir,
      'windScale': windScale,
      'windSpeed': windSpeed,
      'humidity': humidity,
      'precip': precip,
      'pressure': pressure,
      'vis': vis,
      'cloud': cloud,
      'dew': dew
    };
  }
}
