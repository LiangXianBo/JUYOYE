// ignore_for_file: unused_local_variable

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:isar/isar.dart';
import 'package:juyoye/Global/global.dart';
import 'package:juyoye/Modle/feed.dart';

import '../Modle/post.dart';
import '../utils/parse_feed_utils.dart';
import '../utils/parse_post_utils.dart';

// 文章HTML状态
final postList_Provider = StateProvider((ref) {
  final List<Post> postList = Global.isar!.posts.where().findAllSync();
  return postList;
});

// 订阅源列表状态
final feedList_Provider = StateProvider<List<Feed>>((ref) {
  final feed_list = Global.isar!.feeds.where().findAllSync();
  return feed_list;
});
// feed信息卡片显示状态
final isShowfeedCard_Provider = StateProvider<bool>((ref) {
  final bool isShowfeedCard = false;
  return isShowfeedCard;
});

//===== 解析订阅源获取 Post 值的状态 =====

final postNotifier_provider =
    StateNotifierProvider<PostNotifier_provider, Post>(
        (ref) => PostNotifier_provider());

class PostNotifier_provider extends StateNotifier<Post> {
  PostNotifier_provider()
      : super(Post(
            feedId: null,
            title: "",
            feedName: "",
            link: "",
            description: "",
            pubDate: "",
            isRead: false,
            isFavorite: false,
            isFullText: false,
            isFullTextCache: false,
            openType: 0));
  Future postfeed(Feed feed) async {
    Post post;
    try {
      post = await parse_post(feed); // https://sspai.com/feed
    } catch (e) {
      return null;
    }
    state = Post(
      feedId: post.feedId,
      title: post.title,
      feedName: post.feedName,
      link: post.link,
      description: post.description,
      pubDate: post.pubDate,
      isRead: post.isRead,
      isFavorite: post.isFavorite,
      isFullText: post.isFullText,
      isFullTextCache: post.isFullTextCache,
      openType: post.openType,
    );
  }
}

//===== 解析订阅源获取Feed值的状态 =====
final feedNotifier_provider =
    StateNotifierProvider<FeedNotifier_provider, Feed>(
        (ref) => FeedNotifier_provider());

class FeedNotifier_provider extends StateNotifier<Feed> {
  FeedNotifier_provider()
      : super(Feed(
            feedName: "",
            feedUrl: "",
            description: "",
            category: null,
            fullText: null,
            openType: null));
  void getfeed(String url) async {
    Feed feed;
    try {
      feed = (await parse_Feed(url))!; // https://sspai.com/feed
    } catch (e) {
      return null;
    }
    state = Feed(
        feedName: feed.feedName,
        feedUrl: feed.feedUrl,
        description: feed.description,
        category: feed.category,
        fullText: feed.fullText,
        openType: feed.openType);
  }
}
