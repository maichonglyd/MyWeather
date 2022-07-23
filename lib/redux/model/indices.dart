class Indices {
  ///预报日期
  String? date;

  ///生活指数类型ID
  String? type;

  ///生活指数类型的名称
  String? name;

  ///生活指数预报等级
  String? level;

  ///生活指数预报级别名称
  String? category;

  ///生活指数预报的详细描述，可能为空
  String? text;

  static Indices parse(dynamic data) {
    var t = Indices();
    t.date = data['date'];
    t.type = data['type'];
    t.name = data['name'];
    t.level = data['level'];
    t.category = data['category'];
    t.text = data['text'];
    return t;
  }
}
