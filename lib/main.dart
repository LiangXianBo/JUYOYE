// ignore_for_file: depend_on_referenced_packages, prefer_const_constructors

import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:html_main_element/html_main_element.dart';
import 'package:http/io_client.dart';
import 'package:html_main_element/html_main_element.dart';
import 'package:http/io_client.dart' show IOClient;
import 'package:isar/isar.dart';
import 'package:juyoye/Routes/ReadPage.dart';
import 'package:path_provider/path_provider.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:window_manager/window_manager.dart';
import 'Global/global.dart';
import 'Modle/feed.dart';
import 'Modle/post.dart';
import 'package:html/parser.dart' as html_parser;
import 'Routes/AddFeedPage.dart';
import 'utils/parse_feed_utils.dart';
import 'utils/parse_post_utils.dart';
import 'dart:ui';
import 'package:flutter/services.dart';

void main() async {
  // WidgetsFlutterBinding 将是 Widget 架构和 Flutter Engine 连接的核心桥梁
  // 通过 ensureInitialized() 方法我们可以得到一个全局单例 WidgetsFlutterBinding
  // 为后面 flutter_inappwebview 插件 与 Flutter Engine 进行通信 调用原生代码做准备，创建WidgetsBinding实例
  // 在调用 runApp 之前初始化绑定时，才需要调用此方法
  WidgetsFlutterBinding.ensureInitialized();
  // DartPluginRegistrant.ensureInitialized();
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
  if (Platform.isAndroid) {
    // SystemUiOverlayStyle systemUiOverlayStyle = const SystemUiOverlayStyle(
    //   statusBarColor: Colors.transparent,
    //   systemNavigationBarColor: Colors.transparent,
    //   systemNavigationBarDividerColor: Colors.transparent,
    // );
    // SystemChrome.setSystemUIOverlayStyle(systemUiOverlayStyle);

    // SystemUiOverlayStyle systemUiOverlayStyle = SystemUiOverlayStyle(
    //     statusBarColor: Colors.transparent,
    //     systemNavigationBarColor: Colors.blueAccent);
    // SystemChrome.setSystemUIOverlayStyle(systemUiOverlayStyle);

    // SystemChrome.setSystemUIOverlayStyle(systemUiOverlayStyle);
    // SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual);
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
        overlays: [SystemUiOverlay.top]);
    // SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: []);
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.dark,
      ),
    );
  }
  // SystemChrome.setEnabledSystemUIMode(
  //   SystemUiMode.edgeToEdge,
  // );
  final Directory dir = await getApplicationDocumentsDirectory();

  Global.isar = await Isar.open(
    [FeedSchema, PostSchema],
    name: "JUYOYE_Isar_DB",
    directory: dir.path,
  );

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return
        // AnnotatedRegion<SystemUiOverlayStyle>(
        //   // 设置 AppBar 颜色属性
        //   value: SystemUiOverlayStyle.dark,
        //   child:
        // );
        MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Color.fromARGB(255, 48, 207, 121),
          // brightness: Brightness.light
        ),
        appBarTheme: AppBarTheme(
          systemOverlayStyle: SystemUiOverlayStyle.dark,
          titleTextStyle:
              TextStyle(color: Colors.black, fontFamily: "微软雅黑", fontSize: 20),
          backgroundColor: Colors.transparent,
          shadowColor: Colors.transparent,
          elevation: 0.0,
        ),
        useMaterial3: true, //Material3设计主题
      ),
      // home: const MyHomePage(),
      initialRoute: "/", //名为"/"的路由作为应用的home(首页)
      //注册路由表
      routes: {
        "/": (context) => MyHomePage(),
        "AddFeedPage": (context) => AddFeedPage(),
        "ReadPage": (context) => ReadPage(),
      },
      debugShowCheckedModeBanner: false, //取消调试标志
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final List<String> entries = <String>['A', 'B', 'C'];
  List<Feed> feed_list = [];
  List<Feed> geturldata = [];
  List<Post> postFeedData = [];
  final List<int> colorCodes = <int>[600, 500, 100];
  @override
  void initState() {
    postFeedData = Global.isar!.posts.where().findAllSync();
    feed_list = Global.isar!.feeds.where().findAllSync();
    super.initState();
  }

  void getpost() {
    postFeedData = Global.isar!.posts.where().findAllSync();
    print(postFeedData);
  }

  var response_content;
  Future _launchUrl(url) async {
    if (!await launchUrl(Uri.parse(url), mode: LaunchMode.inAppBrowserView)) {
      throw Exception("Could not launch ${Uri.parse(url)}");
    }
  }

  @override
  Widget build(BuildContext context) {
    print("feed_list.length:${feed_list.length}");
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "优聚阅",
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
      ),
      body: SafeArea(
        child: ListView.builder(
            itemCount: postFeedData.length,
            itemBuilder: (BuildContext context, int index) {
              return SizedBox(
                width: 200,
                child: Card(
                  child: Column(children: [
                    TextButton(
                      onPressed: () async {
                        final client = IOClient(
                          HttpClient()
                            ..badCertificateCallback =
                                ((cert, host, port) => true),
                        );
                        var content = await client.get(
                          Uri.parse(postFeedData[index]
                              .link
                              .toString()), //'https://www.theverge.com/rss/index.xml'
                        );
                        final document = html_parser.parse(content.body);
                        // Genererate score map and get score for every html element
                        final scoreMapReadability =
                            readabilityScore(document.documentElement!);
                        // Get the best scoring html element
                        final bestElemReadability =
                            readabilityMainElement(document.documentElement!);
                        print(content);
                        print(bestElemReadability.outerHtml);
                        setState(() {
                          response_content = bestElemReadability.outerHtml;
                        });
                        print(response_content);
                        Navigator.pushNamed(context, 'ReadPage',
                            arguments: response_content);
                      },
                      child: Text("${postFeedData[index].title}"),
                    ),
                    TextButton(
                      onPressed: () {
                        _launchUrl(postFeedData[index].link);
                      },
                      child: Text("跳转到浏览器"),
                    ),
                    Row(
                      children: [
                        Text("${postFeedData[index].feedName}"),
                        Text(
                            "${postFeedData[index].pubDate! != null ? postFeedData[index].pubDate!.substring(0, 10) : null}"),
                      ],
                    )
                  ]),
                ),
              );
            }),
      ),

      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, 'AddFeedPage');
        },
        child: Icon(Icons.add),
      ),
      // bottomNavigationBar: BottomNavigationBar(
      //   items: const <BottomNavigationBarItem>[
      //     BottomNavigationBarItem(
      //       icon: Icon(Icons.call),
      //       label: 'Calls',
      //     ),
      //     BottomNavigationBarItem(
      //       icon: Icon(Icons.camera),
      //       label: '',
      //     ),
      //     BottomNavigationBarItem(
      //       icon: Icon(Icons.chat),
      //       label: 'Chats',
      //     ),
      //   ],
      // ),
      drawer: Drawer(
        child: SizedBox(
          width: 200,
          height: 500,
          child: ListView.builder(
            itemCount: feed_list.length,
            itemBuilder: (BuildContext context, int index) {
              return SizedBox(
                child: Card(
                  child: Column(
                    children: [
                      TextButton(
                          onPressed: () {
                            parse_post(feed_list[index]);
                          },
                          child: Text("${feed_list[index].feedName},无操作")),
                      TextButton(
                          onPressed: () {
                            getpost();
                            setState(() {
                              parse_post(feed_list[index]);
                            });
                          },
                          child: const Text("insertpost_toDB")),
                      TextButton(
                          onPressed: () {
                            getpost();
                            setState(() {
                              Global.isar!.posts.where().findAllSync();
                              parse_post(feed_list[index]);
                            });
                          },
                          child: const Text("getpost_fromDB")),
                      Text("${feed_list[index].description}")
                    ],
                  ),
                ),
              );
            },
            // separatorBuilder: (BuildContext context, int index) =>
            //     const Divider(),
          ),
        ),
      ),
    );
  }
}
