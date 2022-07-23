import 'package:app/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';

typedef AsyncFunction = Future Function();

class PullDownRefresh extends StatelessWidget {
  final AsyncFunction? refresh;
  final AsyncFunction? loadMore;
  final Widget? child;
  final List<Widget>? children;
  const PullDownRefresh(
      {Key? key, this.refresh, this.loadMore, this.child, this.children})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    List<Widget> _children = children ?? [];
    if (child != null) {
      _children.add(child!);
    }
    return EasyRefresh.custom(
      header: ClassicalHeader(
        refreshReadyText: '松手后刷新',
        refreshText: '下滑刷新',
        refreshedText: '刷新完成',
        refreshingText: '加载中...',
        infoText: '更新时间:${DateTime.now().hour}:${DateTime.now().minute}',
        textColor: Style.textdark,
        infoColor: Style.textdark,
      ),
      footer: ClassicalFooter(
        loadText: '加载更多',
        loadedText: '加载完成',
        loadingText: '加载中...',
        infoText: '更新时间:${DateTime.now().hour}:${DateTime.now().minute}',
        textColor: Style.textdark,
        infoColor: Style.textdark,
      ),
      onRefresh: refresh,
      onLoad: loadMore,
      slivers: [
        SliverList(
          delegate: SliverChildListDelegate(_children),
        )
      ],
    );
  }
}
