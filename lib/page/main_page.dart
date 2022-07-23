import 'package:app/app.dart';
import 'package:app/components/base_widget.dart';
import 'package:app/routes.dart';
import 'package:app/utils/utils.dart';
import 'package:flutter/material.dart';

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _MainPage();
}

class _MainPage extends State<MainPage> {
  @override
  void initState() {
    super.initState();
    checkLocalCity();
  }

  checkLocalCity() {
    delay(300).then((value) {
      if (app.currentCityId?.isNotEmpty == true) {
        Navigator.pushReplacementNamed(context, RouteName.homePage);
      } else {
        Navigator.pushReplacementNamed(context, RouteName.cityListPage,
            arguments: false);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: text('loading...'),
      ),
    );
  }
}
