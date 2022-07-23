import 'package:app/page/city_list_page.dart';
import 'package:app/page/home_page.dart';
import 'package:app/page/main_page.dart';
import 'package:flutter/material.dart';

class RouteName {
  static const String mainPage = '/';
  static const String cityListPage = '/city-list';
  static const String homePage = '/home';
}

buildRoutes(arg) {
  return {
    RouteName.mainPage: (_) => const MainPage(),
    RouteName.cityListPage: (_) => CityListPage(
          showBack: arg != false,
        ),
    RouteName.homePage: (_) => HomePage(),
  };
}

Route<dynamic> generateRoute(RouteSettings settings) {
  var route = buildRoutes(settings.arguments);
  var builder = route[settings.name];
  return PageRouteBuilder(
      pageBuilder: (ctx, ani1, ani2) => builder(ctx),
      transitionsBuilder: (context, animaton1, animaton2, child) {
        /// 缩放动画效果
        // return ScaleTransition(
        //   scale: Tween(begin: 0.0, end: 1.0).animate(
        //       CurvedAnimation(parent: animaton1, curve: Curves.fastOutSlowIn)),
        //   child: child,
        // );

        /// 滑动效果
        return SlideTransition(
          position: Tween(begin: const Offset(1, 0), end: const Offset(0, 0))
              .animate(CurvedAnimation(
                  parent: animaton1, curve: Curves.fastOutSlowIn)),
          child: child,
        );

        /// 渐隐动画
        // return FadeTransition(
        //   opacity: Tween(begin: 0.0, end: 10.0).animate(
        //       CurvedAnimation(parent: animaton1, curve: Curves.fastOutSlowIn)),
        //   child: child,
        // );

        // // 旋转加缩放动画效果
        // return RotationTransition(
        //   turns: Tween(begin: 0.0, end: 1.0).animate(CurvedAnimation(
        //     parent: animaton1,
        //     curve: Curves.fastOutSlowIn,
        //   )),
        //   child: ScaleTransition(
        //     scale: Tween(begin: 0.0, end: 1.0).animate(CurvedAnimation(
        //         parent: animaton1, curve: Curves.fastOutSlowIn)),
        //     child: child,
        //   ),
        // );
      });
  // return MaterialPageRoute(builder: builder);
}
