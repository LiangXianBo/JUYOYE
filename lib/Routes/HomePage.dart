// ignore_for_file: invalid_use_of_visible_for_testing_member, invalid_use_of_protected_member

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/io_client.dart';
import 'package:isar/isar.dart';

import '../Global/global.dart';
import '../Modle/feed.dart';
import '../Modle/post.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:html/parser.dart' as html_parser;

import 'package:html_main_element/html_main_element.dart';
import 'package:http/io_client.dart' show IOClient;
import '../Riverpod/providers.dart';

import 'AddFeedPage.dart';
import 'FeedListPage.dart';
import 'PostListPage.dart';

class HomePage extends ConsumerStatefulWidget {
  const HomePage({super.key});

  @override
  ConsumerState<HomePage> createState() => HomePageState();
}

class HomePageState extends ConsumerState<HomePage> {
  final List<String> entries = <String>['A', 'B', 'C'];
  // List<Feed> feed_list = [];
  List<Feed> geturldata = [];
  List<Post> postFeedData = [];
  final List<int> colorCodes = <int>[600, 500, 100];

  @override
  void initState() {
    postFeedData = Global.isar!.posts.where().findAllSync();
    // feed_list = Global.isar!.feeds.where().findAllSync();
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

  PreferredSizeWidget buildAppBarHelper() {
    return AppBar(
      title: Text(
        "优聚阅",
        style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
      ),
      centerTitle: false,
    );
  }

  @override
  Widget build(BuildContext context) {
    final feed_list = ref.watch(feedList_Provider);
    print("feed_list.length:${feed_list.length}");

    return Scaffold(
      appBar: buildAppBarHelper(),
      body: PostListPage(),
      //  SafeArea(
      //   child: ListView.builder(
      //       itemCount: postFeedData.length,
      //       itemBuilder: (BuildContext context, int index) {
      //         return SizedBox(
      //           width: 200,
      //           child: Card(
      //             child: Column(children: [
      //               TextButton(
      //                 onPressed: () async {
      //                   final client = IOClient(
      //                     HttpClient()
      //                       ..badCertificateCallback =
      //                           ((cert, host, port) => true),
      //                   );
      //                   var content = await client.get(
      //                     Uri.parse(postFeedData[index]
      //                         .link
      //                         .toString()), //'https://www.theverge.com/rss/index.xml'
      //                   );
      //                   final document = html_parser.parse(content.body);
      //                   // Genererate score map and get score for every html element
      //                   final scoreMapReadability =
      //                       readabilityScore(document.documentElement!);
      //                   // Get the best scoring html element
      //                   final bestElemReadability =
      //                       readabilityMainElement(document.documentElement!);
      //                   print(content);
      //                   print(bestElemReadability.outerHtml);
      //                   setState(() {
      //                     response_content = bestElemReadability.outerHtml;
      //                   });
      //                   print(response_content);
      //                   Navigator.pushNamed(context, 'ReadPage',
      //                       arguments: response_content);
      //                 },
      //                 child: Text("${postFeedData[index].title}"),
      //               ),
      //               TextButton(
      //                 onPressed: () {
      //                   _launchUrl(postFeedData[index].link);
      //                 },
      //                 child: Text("跳转到浏览器"),
      //               ),
      //               Row(
      //                 children: [
      //                   Text("${postFeedData[index].feedName}"),
      //                   Text(
      //                       "${postFeedData[index].pubDate! != null ? postFeedData[index].pubDate!.substring(0, 10) : null}"),
      //                 ],
      //               )
      //             ]),
      //           ),
      //         );
      //       }),
      // ),
      floatingActionButton: FloatingActionButton(
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
        child: Icon(Icons.add),
      ),
      drawer: Drawer(
        child: FeedListPage(),

        // SizedBox(
        //   width: 200,
        //   height: 500,
        //   child: ListView.builder(
        //     itemCount: feed_list.length,
        //     itemBuilder: (BuildContext context, int index) {
        //       return SizedBox(
        //         child: Card(
        //           child: Column(
        //             children: [
        //               TextButton(
        //                   onPressed: () {
        //                     parse_post(feed_list[index]);
        //                   },
        //                   child: Text("${feed_list[index].feedName},无操作")),
        //               TextButton(
        //                   onPressed: () {
        //                     getpost();
        //                     setState(() {
        //                       parse_post(feed_list[index]);
        //                     });
        //                   },
        //                   child: const Text("insertpost_toDB")),
        //               TextButton(
        //                   onPressed: () {
        //                     getpost();
        //                     setState(() {
        //                       Global.isar!.posts.where().findAllSync();
        //                       parse_post(feed_list[index]);
        //                     });
        //                   },
        //                   child: const Text("getpost_fromDB")),
        //               Text("${feed_list[index].description}")
        //             ],
        //           ),
        //         ),
        //       );
        //     },
        //     // separatorBuilder: (BuildContext context, int index) =>
        //     //     const Divider(),
        //   ),
        // ),
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
