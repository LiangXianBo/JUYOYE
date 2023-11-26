// ignore_for_file: non_constant_identifier_names

import 'package:isar/isar.dart';

import '../Global/global.dart';

part 'post.g.dart';

@collection
class Post {
  Id? id = Isar.autoIncrement;
  int? feedId; //订阅源ID
  String? feedName; //订阅名称
  String? title; //item标题
  String? link; //链接
  String? description; //item描述
  String? pubDate; //发布时间
  bool isRead; // 是否已读
  bool isFavorite; // item是否已收藏
  bool isFullText; // item是否全文
  bool isFullTextCache; // item是否已经有全文缓存
  int openType; // item打开方式：0阅读器 1内置标签页 2系统浏览器

  Post({
    this.id,
    required this.feedId,
    required this.title,
    required this.feedName,
    required this.link,
    required this.description,
    required this.pubDate,
    required this.isRead,
    required this.isFavorite,
    required this.isFullText,
    required this.isFullTextCache,
    required this.openType,
  });
  // 通过FeedUrl来判断数据库中该Feed是否已经存在
  static bool postIsNotExist_inDB(post_link) {
    List<Post> postList = Global.isar!.posts
        .where()
        .filter()
        .linkEqualTo(post_link)
        .findAllSync();

    return postList.isEmpty;
  }

  Future insertPostdata_toDB() async {
    await Global.isar!.writeTxn(() async {
      if (this.feedId != null) {
        await Global.isar!.posts.put(this); // 将新用户数据写入到 Isar
      }
    });
  }
}
