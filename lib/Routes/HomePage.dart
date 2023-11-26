// ignore_for_file: invalid_use_of_visible_for_testing_member, invalid_use_of_protected_member

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:isar/isar.dart';
import 'package:juyoye/Modle/post.dart';
import '../main.dart';
import 'AddFeedPage.dart';
import 'FeedListPage.dart';
import 'PostListPage.dart';
import '../Global/global.dart';
import '../Modle/feed.dart';
import '../Riverpod/providers.dart';

class HomePage extends ConsumerStatefulWidget {
  const HomePage({super.key});

  @override
  ConsumerState<HomePage> createState() => HomePageState();
}

class HomePageState extends ConsumerState<HomePage> with RouteAware {
// 进入下一个页面退回当前页面时的回调函数
  @override
  void didPopNext() {
    // 重新读取Post数据表中的所有数据
    ref.read(postList_Provider.notifier).state =
        Global.isar!.posts.where().findAllSync();
  }

// 订阅页面
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    routeObserver.subscribe(this, ModalRoute.of(context)!);
  }

// 取消订阅
  @override
  void dispose() {
    routeObserver.unsubscribe(this);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "优聚阅",
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
        centerTitle: false,
      ),
      body: PostListPage(),
      floatingActionButtonLocation: CustomFloatingActionButtonLocation(
          FloatingActionButtonLocation.endFloat, 0, -150),
      // 右侧悬浮按钮
      floatingActionButton: FloatingActionButton(
        elevation: 5,
        backgroundColor: Theme.of(context).colorScheme.primary,
        onPressed: () {
          // 解析订阅源获取Feed值的状态
          ref.read(feedNotifier_provider.notifier).state = Feed(
              feedName: "",
              feedUrl: "",
              description: "",
              category: null,
              fullText: null,
              openType: null);
          // feed信息卡片显示状态
          ref.read(isShowfeedCard_Provider.notifier).state = false;
          // 底部弹窗
          AddFeed_showModalBottomSheet();
        },
        child: Icon(
          Icons.add,
          color: Global.icon_color,
        ),
      ),
      drawer: Drawer(
        child: FeedListPage(),
      ),
    );
  }

  Future<void> AddFeed_showModalBottomSheet() {
    return showModalBottomSheet<void>(
      isScrollControlled: true,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(10.0),
          topRight: Radius.circular(10.0),
        ),
      ),
      useSafeArea: true,
      context: context,
      builder: (BuildContext context) {
        return AddFeedPage();
      },
    );
  }
}

// 悬浮按钮位置方法重写
class CustomFloatingActionButtonLocation extends FloatingActionButtonLocation {
  FloatingActionButtonLocation location;
  double offsetX; // X方向的偏移量
  double offsetY; // Y方向的偏移量
  CustomFloatingActionButtonLocation(this.location, this.offsetX, this.offsetY);

  @override
  Offset getOffset(ScaffoldPrelayoutGeometry scaffoldGeometry) {
    Offset offset = location.getOffset(scaffoldGeometry);
    return Offset(offset.dx + offsetX, offset.dy + offsetY);
  }
}
