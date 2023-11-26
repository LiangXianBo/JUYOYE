// ignore_for_file: invalid_use_of_visible_for_testing_member, invalid_use_of_protected_member

import 'package:expansion_tile_card/expansion_tile_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:isar/isar.dart';
import 'package:juyoye/Modle/feed.dart';
import 'package:juyoye/Modle/post.dart';

import '../Global/global.dart';
import '../Riverpod/providers.dart';

class FeedListPage extends ConsumerStatefulWidget {
  const FeedListPage({super.key});

  @override
  ConsumerState<FeedListPage> createState() => FeedListPageState();
}

class FeedListPageState extends ConsumerState<FeedListPage> {
  final GlobalKey<ExpansionTileCardState> feeds_ExpansionCard_key = GlobalKey();

  @override
  Widget build(BuildContext context) {
    final feed_list = ref.watch(feedList_Provider);

    return Scrollbar(
      child: SingleChildScrollView(
        primary: true,
        scrollDirection: Axis.vertical,
        physics: BouncingScrollPhysics(),
        padding: EdgeInsets.only(
            top: MediaQuery.of(context).padding.top, left: 16, right: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 40,
              child: InkWell(
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                  onTap: () {
                    // 获取post
                    for (var feed in feed_list) {
                      ref.read(postNotifier_provider.notifier).postfeed(feed);
                    }

                    // 将post的数据存入数据库
                    ref
                        .read(postNotifier_provider.notifier)
                        .state
                        .insertPostdata_toDB()
                        .then((value) {
                      // 读取Post数据表中的所有数据
                      ref.read(postList_Provider.notifier).state =
                          Global.isar!.posts.where().findAllSync();
                    });
                    // 点击所有订阅，读取Post数据表中的所有数据
                    ref.read(postList_Provider.notifier).state =
                        Global.isar!.posts.where().findAllSync();
                  },
                  child: Container(
                    child: Text(
                      "所有订阅",
                      style: TextStyle(fontSize: 25),
                    ),
                  )),
            ),
            Padding(
              padding: EdgeInsets.only(left: 20),
              child: Column(
                children:
                    //Feeds列表项
                    feed_list
                        .map(
                          (e_feed) => InkWell(
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                            onTap: () {
                              // 点击当前Feed，只从数据库读取该Feed的Post数据
                              ref.read(postList_Provider.notifier).state =
                                  Global.isar!.posts
                                      .where()
                                      .filter()
                                      .feedIdEqualTo(e_feed.id)
                                      .findAllSync();
                              // 获取post
                              ref
                                  .read(postNotifier_provider.notifier)
                                  .postfeed(e_feed);
                              // 将post的数据存入数据库
                              ref
                                  .read(postNotifier_provider.notifier)
                                  .state
                                  .insertPostdata_toDB()
                                  .then((value) {
                                // 读取Post数据表中的所有数据
                                ref.read(postList_Provider.notifier).state =
                                    Global.isar!.posts.where().findAllSync();
                              });
                            },
                            child: Container(
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "${e_feed.feedName}",
                                    style:
                                        TextStyle(fontSize: Global.Fontsize_16),
                                  ),
                                  PopupMenuButton(
                                    itemBuilder: (BuildContext context) {
                                      return [
                                        PopupMenuItem(
                                          value: 1,
                                          child: Text("编辑提要"),
                                        ),
                                        PopupMenuItem(
                                          value: 2,
                                          child: Text(
                                            "删除提要",
                                            style: TextStyle(color: Colors.red),
                                          ),
                                        ),
                                      ];
                                    },
                                    onSelected: (value) async {
                                      if (value == 2) {
                                        // 弹窗
                                        bool? isDelete =
                                            await showDeleteFeed_Dialog(
                                                context);
                                        // 弹窗返回true,删除当前Feed
                                        if (isDelete == true) {
                                          await Global.isar!.writeTxn(() async {
                                            // 从数据库中删除Feeds
                                            await Global.isar!.feeds
                                                .delete(e_feed.id);
                                            // 从数据库中删除Feeds
                                            await Global.isar!.posts
                                                .where()
                                                .filter()
                                                .feedIdEqualTo(e_feed.id)
                                                .deleteAll();
                                          });
                                          // 重新读取数据库
                                          ref
                                                  .read(feedList_Provider.notifier)
                                                  .state =
                                              Global.isar!.feeds
                                                  .where()
                                                  .findAllSync();
                                          ref
                                                  .read(postList_Provider.notifier)
                                                  .state =
                                              Global.isar!.posts
                                                  .where()
                                                  .findAllSync();
                                        }
                                      }
                                    },
                                  ),
                                ],
                              ),
                            ),
                          ),
                        )
                        .toList(),
              ),
            )
          ],
        ),
      ),
    );
  }
}

Future<bool?> showDeleteFeed_Dialog(BuildContext context) {
  return showDialog<bool>(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text("提示"),
        content: Text("确定要删除这个提要吗？"),
        actions: [
          TextButton(
            onPressed: () {
              // 退出弹窗
              Navigator.of(context).pop();
            },
            child: Text(
              "取消",
              style: TextStyle(color: Colors.black87),
            ),
          ),
          TextButton(
            onPressed: () {
              // 退出弹窗，并返回true
              Navigator.of(context).pop(true);
            },
            child: Text(
              "删除",
              style: TextStyle(color: Colors.red),
            ),
          ),
        ],
      );
    },
  );
}
