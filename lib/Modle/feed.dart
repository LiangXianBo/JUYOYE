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
// 通过FeedUrl来判断数据库中该Feed是否已经存在
  static bool feedIsNotExist_inDB(String feedUrl) {
    List<Feed> feedList = Global.isar!.feeds
        .where()
        .filter()
        .feedUrlEqualTo(feedUrl)
        .findAllSync();

    return feedList.isEmpty;
  }

// 将数据插入到Isar数据库
  Future insertFeed_toDB() async {
    await Global.isar!.writeTxn(() async {
      if (this.feedName != "") {
        await Global.isar!.feeds.put(this); // 将数据插入到 Isar
      }
    });
  }

  // 从数据库读取所有Feed,以列表的形式返回
  static List getFeed_fromDB() {
    List feedlist = Global.isar!.feeds.where().findAllSync();
    return feedlist;
  }
}
