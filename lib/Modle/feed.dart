// ignore_for_file: non_constant_identifier_names

import 'package:isar/isar.dart';

import '../Global/global.dart';

part 'feed.g.dart';

@collection
class Feed {
  Id id = Isar.autoIncrement;
  String? feedName; //订阅源名称
  String? feedUrl; //订阅源地址
  String? description; //订阅源描述
  String? category; //订阅源分类
  bool? fullText; //是否全文
  int? openType; // 打开方式：0-阅读器 1-内置标签页 2-系统浏览器

  Feed({
    required this.feedName,
    required this.feedUrl,
    required this.description,
    required this.category,
    required this.fullText,
    required this.openType,
  });
// 将数据插入到Isar数据库
  Future insertFeed_toDB() async {
    await Global.isar!.writeTxn(() async {
      await Global.isar!.feeds.put(this); // 将数据插入到 Isar
    });
  }

  List getFeed_fromDB() {
    List feedlist = Global.isar!.feeds.where().findAllSync();
    return feedlist;
  }
}
