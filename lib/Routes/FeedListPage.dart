import 'package:expansion_tile_card/expansion_tile_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:isar/isar.dart';
import 'package:juyoye/Modle/feed.dart';

import '../Global/global.dart';
import '../Riverpod/providers.dart';

class FeedListPage extends ConsumerStatefulWidget {
  const FeedListPage({super.key});

  @override
  ConsumerState<FeedListPage> createState() => FeedListPageState();
}

class FeedListPageState extends ConsumerState<FeedListPage> {
  final GlobalKey<ExpansionTileCardState> feeds_ExpansionCard_key = GlobalKey();
  open() {
    print("open");
  }

  @override
  Widget build(BuildContext context) {
    final feed_list = ref.watch(feedList_Provider);

    return Scrollbar(
      child: SingleChildScrollView(
        primary: true,
        scrollDirection: Axis.vertical,
        physics: BouncingScrollPhysics(),
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 50,
              child: TextButton(
                style: ButtonStyle(),
                onPressed: () {},
                child: Text(
                  "所有订阅",
                  style: TextStyle(fontSize: 25),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: 20),
              child: Column(
                children: feed_list
                    .map(
                      (e_feed) => InkWell(
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                        onLongPress: () {
                          print("object");
                        },
                        child: Container(
                          padding: EdgeInsets.all(10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "${e_feed.feedName}",
                                style: TextStyle(fontSize: Global.Fontsize),
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
                              }, onSelected: (value) async {
                                if (value == 2) {
                                  // 弹窗
                                  bool? isDelete =
                                      await showDeleteFeed_Dialog(context);
                                  // 弹窗返回true,删除当前Feed
                                  if (isDelete == true) {
                                    await Global.isar!.writeTxn(() async {
                                      var feed = await Global.isar!.feeds
                                          .delete(e_feed.id);
                                      print(feed);
                                    });
                                    ref.read(feedList_Provider.notifier).state =
                                        Global.isar!.feeds
                                            .where()
                                            .findAllSync();
                                  }
                                }
                              }),
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
              // 退出弹窗，并返回true
              Navigator.of(context).pop(true);
            },
            child: Text(
              "删除",
              style: TextStyle(color: Colors.red),
            ),
          ),
          TextButton(
            onPressed: () {
              // 退出弹窗
              Navigator.of(context).pop();
            },
            child: Text("取消"),
          ),
        ],
      );
    },
  );
}
