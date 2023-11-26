// ignore_for_file: depend_on_referenced_packages, prefer_const_constructors

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:isar/isar.dart';
import 'package:juyoye/Routes/ReadPage.dart';
import 'package:path_provider/path_provider.dart';

import 'package:window_manager/window_manager.dart';
import 'Global/global.dart';
import 'Modle/feed.dart';
import 'Modle/post.dart';

import 'Routes/AddFeedPage.dart';
import 'Routes/HomePage.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

///定义全局的 routeObserver 对象
final RouteObserver<ModalRoute> routeObserver = RouteObserver<ModalRoute>();

void main() async {
  // WidgetsFlutterBinding 将是 Widget 架构和 Flutter Engine 连接的核心桥梁
  // 通过 ensureInitialized() 方法我们可以得到一个全局单例 WidgetsFlutterBinding
  // 为后面 flutter_inappwebview 插件 与 Flutter Engine 进行通信 调用原生代码做准备，创建WidgetsBinding实例
  // 在调用 runApp 之前初始化绑定时，才需要调用此方法
  WidgetsFlutterBinding.ensureInitialized();
  //Windows窗口的初始化(MacOS未适配)
  if (!(Platform.isAndroid || Platform.isIOS)) {
    //窗口初始化
    await windowManager.ensureInitialized();
    //窗口选项，基本设置
    WindowOptions windowOptions = const WindowOptions(
      size: Size(380, 800), //窗口尺寸
      //固定窗口大小
      // minimumSize: Size(800, 450), //最小窗口尺寸
      // maximumSize: Size(800, 450), //最大窗口尺寸
      center: true, //居中
      backgroundColor: Colors.transparent, //窗口背景色透明
      title: "优聚阅", //标题名
      titleBarStyle: TitleBarStyle.normal, //窗口标题栏
      skipTaskbar: false, //任务栏显示
    );
    // windowManager.setIcon("lib/assets/Images/QJ.ico");
    windowManager.setMaximizable(false);
    windowManager.waitUntilReadyToShow(windowOptions, () async {
      await windowManager.show();
      await windowManager.focus();
    });
  }
  final Directory dir = await getApplicationDocumentsDirectory();

  Global.isar = await Isar.open(
    [FeedSchema, PostSchema],
    name: "JUYOYE_Isar_DB",
    directory: dir.path,
  );

  // 设置Android的顶部和底部状态栏
  if (Platform.isAndroid) {
    SystemUiOverlayStyle systemUiOverlayStyle = const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.dark,
      systemNavigationBarColor: Colors.transparent,
      systemNavigationBarDividerColor: Colors.transparent,
    );
    SystemChrome.setSystemUIOverlayStyle(systemUiOverlayStyle);
    SystemChrome.setEnabledSystemUIMode(
      SystemUiMode.edgeToEdge,
    );
  }
  runApp(
    ProviderScope(child: MyApp()),
  );
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          brightness: Brightness.light,
          seedColor: Color.fromRGBO(20, 190, 100, 1),
          primary: Color.fromRGBO(20, 190, 100, 1),
        ),
        fontFamily: '微软雅黑',
        // textTheme: TextTheme(labelSmall: TextStyle(color: Colors.blue)),
        appBarTheme: AppBarTheme(
          titleTextStyle: TextStyle(
            color: Colors.black,
            // fontFamily: "NotoSansSC",
            fontSize: 20,
          ),
          shadowColor: Colors.transparent,
          elevation: 0.0,
        ),
        //Material3设计主题
        useMaterial3: true,
      ),
      // home: const MyHomePage(),
      initialRoute: "/", //名为"/"的路由作为应用的home(首页)
      //注册路由表
      routes: {
        "/": (context) => HomePage(),
        "AddFeedPage": (context) => AddFeedPage(),
        "ReadPage": (context) => ReadPage(),
        //  "AddFeed_showModalBottomSheet": (context) => AddFeed_showModalBottomSheet(),
      },
      // 添加RouteObserverExample观察者
      navigatorObservers: [routeObserver],
      debugShowCheckedModeBanner: false, //取消调试标志
    );
  }
}
