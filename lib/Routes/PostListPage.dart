// ignore_for_file: invalid_use_of_visible_for_testing_member, invalid_use_of_protected_member, unused_local_variable

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:html_main_element/html_main_element.dart';
import 'package:http/io_client.dart';
import 'package:isar/isar.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:html/parser.dart' as html_parser;

import '../Global/global.dart';
import '../Modle/post.dart';
import '../Riverpod/providers.dart';

class PostListPage extends ConsumerStatefulWidget {
  const PostListPage({super.key});

  @override
  ConsumerState<PostListPage> createState() => PostListPageState();
}

class PostListPageState extends ConsumerState<PostListPage> {
  // List<Post> postFeedData = [];
  String? getArticleHTML;
  @override
  void initState() {
    // postFeedData = Global.isar!.posts.where().findAllSync();

    super.initState();
  }

  Future _launchUrl(url) async {
    if (!await launchUrl(Uri.parse(url), mode: LaunchMode.inAppBrowserView)) {
      throw Exception("Could not launch ${Uri.parse(url)}");
    }
  }

  Future _onrefresh() async {
    // 通过当前Feed解析获取post
    ref
        .read(postNotifier_provider.notifier)
        .postfeed(ref.read(feedNotifier_provider.notifier).state);
    // 重新读取Post数据表中的所有数据
    ref.read(postList_Provider.notifier).state =
        Global.isar!.posts.where().findAllSync();
  }

  // Post文章发布的时间格式设置
  String postPubDate(List postList, int index) {
    String post_pubdate;
    var pubdate = postList[index].pubDate;
    if (pubdate == null || pubdate == "" || pubdate == "null") {
      post_pubdate = "";
    } else {
      post_pubdate = pubdate.substring(0, 10);
    }
    return post_pubdate;
  }

  @override
  Widget build(BuildContext context) {
    var postList = ref.watch(postList_Provider);

    return SafeArea(
      child: RefreshIndicator(
        onRefresh: _onrefresh,
        child: ListView.builder(
            itemCount: postList.length,
            itemBuilder: (BuildContext context, int index) {
              return Padding(
                padding: EdgeInsets.only(left: 10, right: 10, top: 5),
                // width: 200,
                child: Card(
                  child: InkWell(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                    onTap: () async {
                      final client = IOClient(
                        HttpClient()
                          ..badCertificateCallback = ((cert, host, port) =>
                              true), //发起HTTP请求时证书校验，接受安全连接
                      );
                      // 获取响应内容
                      var content = await client.get(
                        Uri.parse(postList[index]
                            .link
                            .toString()), //'https://www.theverge.com/rss/index.xml'
                      );
                      // 对响应内容中的body进行解析，提取内容
                      final document = html_parser.parse(content.body);

                      // 成得分图并获取每个 html 元素的得分
                      // final scoreMapReadability =
                      //     readabilityScore(document.documentElement!);
                      // print(scoreMapReadability);

                      // 获取得分最高的html元素
                      final bestElemReadability =
                          readabilityMainElement(document.documentElement!);

                      setState(() {
                        getArticleHTML = bestElemReadability.outerHtml;
                      });
                      // Feed名称
                      ref.read(FeedTitle_Provider.notifier).state =
                          postList[index].feedName!;
                      // 文章标题
                      ref.read(ArticalTitle_Provider.notifier).state =
                          postList[index].title!;

                      // 跳转到阅读页面
                      Navigator.pushNamed(context, 'ReadPage',
                          arguments: getArticleHTML);
                    },
                    child: Padding(
                      padding: EdgeInsets.all(10),
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "${postList[index].title}",
                              style: TextStyle(fontSize: Global.Fontsize_16),
                            ),
                            SizedBox(height: 8),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                SizedBox(
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Text(
                                        "${postList[index].feedName}",
                                        style: TextStyle(
                                            fontSize: Global.Fontsize_12),
                                      ),
                                      SizedBox(
                                        width: 10,
                                      ),
                                      Text(
                                        postPubDate(postList, index),
                                        style: TextStyle(
                                            fontSize: Global.Fontsize_12),
                                      ),
                                    ],
                                  ),
                                ),
                                InkWell(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10)),
                                  onTap: () {
                                    // 跳转带网页
                                    _launchUrl(postList[index].link);
                                  },
                                  child: Icon(
                                    Icons.open_in_browser,
                                    size: 20,
                                  ),
                                ),

                                // ),
                              ],
                            ),
                          ]),
                    ),
                  ),
                ),
              );
            }),
      ),
    );
  }
}
