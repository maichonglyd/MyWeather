import 'package:app/app.dart';
import 'package:app/components/base_widget.dart';
import 'package:app/routes.dart';
import 'package:app/theme.dart';
import 'package:app/utils/city.dart';
import 'package:app/utils/utils.dart';
import 'package:flutter/material.dart';

class CityListPage extends StatefulWidget {
  final bool showBack;
  const CityListPage({Key? key, this.showBack = true}) : super(key: key);
  @override
  State<StatefulWidget> createState() => _CityListPage();
}

class _CityListPage extends State<CityListPage> {
  Map<String, String>? current;
  String search = '';
  TextEditingController controller = TextEditingController();
  FocusNode focusNode = FocusNode();
  ScrollController scrollController = ScrollController();
  List<Map<String, Object>> comboCityData = cityData;
  @override
  void initState() {
    if (app.currentCityId?.isNotEmpty == true) {
      current = getCurrentCity(app.currentCityId!);
    }
    scrollController.addListener(handleCloseKeyboard);
    super.initState();
  }

  handleSelectCity(Map<String, String> item) {
    handleCloseKeyboard();
    setState(() {
      current = item;
      app.currentCityId = item['id'];
      app.sharePreference.setString('city', item['id'].toString());
    });
  }

  handleConfirm() {
    handleCloseKeyboard();
    if (widget.showBack == true) {
      Navigator.pop(context);
    } else {
      Navigator.pushReplacementNamed(context, RouteName.homePage);
    }
  }

  handleCloseKeyboard([v]) {
    if (focusNode.hasFocus) {
      focusNode.unfocus();
    }
  }

  handleSearch() {
    handleCloseKeyboard();
    if (search.isNotEmpty != true) return;
    Map<String, Map<String, Object>> _data = {};
    for (var province in cityData) {
      if ((province['name']).toString().contains(search) ||
          search.contains((province['name']).toString())) {
        _data[province['name'].toString()] = province;
        continue;
      }
      List citys = province['subs'] as List;
      for (var city in citys) {
        if (city['name'].toString().contains(search) ||
            search.contains(city['name'].toString())) {
          if (!_data.containsKey(province['name'].toString())) {
            _data[province['name'].toString()] = {
              'name': province['name'].toString(),
              'map': {},
              'subs': []
            };
          }
          (_data[province['name'].toString()]!['map']
              as Map)[city['name'].toString()] = city;
          _data[province['name'].toString()]!['subs'] =
              (_data[province['name'].toString()]!['map'] as Map)
                  .values
                  .toList();
          continue;
        }
        List countries = city['subs'] as List;
        for (var country in countries) {
          if (country['name'].toString().contains(search) ||
              search.contains(country['name'].toString())) {
            if (!_data.containsKey(province['name'].toString())) {
              _data[province['name'].toString()] = {
                'name': province['name'].toString(),
                'map': {},
                'subs': []
              };
            }
            if (!((_data[province['name'].toString()] as Map)['map'] as Map)
                .containsKey(city['name'])) {
              (_data[province['name'].toString()]!['map']
                  as Map)[city['name'].toString()] = {
                'name': city['name'],
                'map': {},
                'subs': []
              };
            }
            ((_data[province['name'].toString()]!['map']
                    as Map)[city['name'].toString()] as Map)['map']
                [country['name'].toString()] = country;
            ((_data[province['name'].toString()]!['map']
                    as Map)[city['name'].toString()] as Map)['subs'] =
                (_data[province['name'].toString()]!['map']
                        as Map)[city['name'].toString()]['map']
                    .values
                    .toList();
            (_data[province['name'].toString()] as Map)['subs'] =
                (_data[province['name'].toString()]!['map'] as Map)
                    .values
                    .toList();
            continue;
          }
        }
      }
      if (_data.containsKey(province['name'])) {
        (_data[province['name']] as Map).remove('map');
        for (var city in (_data[province['name']] as Map)['subs']) {
          city.remove('map');
        }
      }
    }
    setState(() {
      comboCityData = _data.values.toList();
    });
  }

  handleClearSearch() {
    controller.text = '';
    setState(() {
      search = '';
      comboCityData = cityData;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Style.white,
      appBar: appBar(context, '选择城市',
          brightness: Brightness.light,
          showBack: widget.showBack,
          actions: [
            InkWell(
              onTap: handleConfirm,
              child: Container(
                alignment: Alignment.center,
                padding: spaceHorizontal(),
                child: text('确定', color: Style.white),
              ),
            )
          ]),
      body: GestureDetector(
        onTap: handleCloseKeyboard,
        child: Column(children: [
          Container(
              color: Style.bglight,
              alignment: Alignment.centerLeft,
              padding: space(Style.spacelg),
              child: text('当前城市: ${current?['name'] ?? '请选择'}')),
          Container(
            padding: spaceLeft(),
            child: Row(children: [
              Expanded(
                  child: Container(
                height: rpx(88),
                padding: spaceBottom(Style.spacesm),
                child: TextField(
                  decoration: InputDecoration(
                      suffixIcon: search.isNotEmpty == true
                          ? GestureDetector(
                              onTap: handleClearSearch,
                              child: const Icon(Icons.close))
                          : null,
                      hintText: '模糊搜索省市县/区'),
                  controller: controller,
                  focusNode: focusNode,
                  onChanged: (v) {
                    setState(() {
                      search = v;
                    });
                  },
                ),
              )),
              InkWell(
                  onTap: handleSearch,
                  child: Container(
                    height: rpx(88),
                    padding: spaceHorizontal(),
                    alignment: Alignment.center,
                    child: text('搜索'),
                  ))
            ]),
          ),
          Expanded(
              child: ListView(
            controller: scrollController,
            children: List.generate(comboCityData.length, (index) {
              Map<String, dynamic> province = comboCityData[index];
              return ExpansionTile(
                key: Key(province['name']),
                onExpansionChanged: handleCloseKeyboard,
                title: text('${province['name']}'),
                children: List.generate(province['subs'].length, (index) {
                  Map<String, dynamic> city = province['subs'][index];
                  return ExpansionTile(
                    key: Key(city['name']),
                    onExpansionChanged: handleCloseKeyboard,
                    title: Container(
                        child: text('${city['name']}'), padding: spaceLeft()),
                    children: List.generate(city['subs'].length, (index) {
                      Map<String, String> country = city['subs'][index];
                      return InkWell(
                        onTap: () => handleSelectCity(country),
                        child: Container(
                          key: Key(country['name']!),
                          decoration: borderTop(color: Style.bordergrey),
                          padding: spaceLeft(Style.spacelg * 3),
                          alignment: Alignment.centerLeft,
                          height: rpx(96),
                          child: text('${country['name']}'),
                        ),
                      );
                    }),
                  );
                }),
              );
            }),
          ))
        ]),
      ),
    );
  }
}
