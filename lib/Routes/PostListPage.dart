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

class PostListPage extends ConsumerStatefulWidget {
  const PostListPage({super.key});

  @override
  ConsumerState<PostListPage> createState() => PostListPageState();
}

class PostListPageState extends ConsumerState<PostListPage> {
  List<Post> postFeedData = [];
  @override
  void initState() {
    postFeedData = Global.isar!.posts.where().findAllSync();
    // feed_list = Global.isar!.feeds.where().findAllSync();
    super.initState();
  }

  var response_content;
  Future _launchUrl(url) async {
    if (!await launchUrl(Uri.parse(url), mode: LaunchMode.inAppBrowserView)) {
      throw Exception("Could not launch ${Uri.parse(url)}");
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
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
                          ..badCertificateCallback = ((cert, host, port) =>
                              true), //发起HTTP请求时证书校验，接受安全连接
                      );
                      // 获取响应内容
                      var content = await client.get(
                        Uri.parse(postFeedData[index]
                            .link
                            .toString()), //'https://www.theverge.com/rss/index.xml'
                      );
                      // 对响应内容中的body进行解析，提取内容
                      final document = html_parser.parse(content.body);
                      // html可读
                      final scoreMapReadability =
                          readabilityScore(document.documentElement!);
                      //
                      final bestElemReadability =
                          readabilityMainElement(document.documentElement!);

                      setState(() {
                        response_content = bestElemReadability.outerHtml;
                      });
                      print(response_content);
                      // 跳转到阅读页面
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
    );
  }
}
