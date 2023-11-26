// ignore_for_file: unused_local_variable

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:isar/isar.dart';
import 'package:juyoye/Global/global.dart';
import 'package:juyoye/Modle/feed.dart';

import '../utils/parse_feed_utils.dart';

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
    Feed? feed;
    try {
      feed = await parse_Feed(url); // https://sspai.com/feed
    } catch (e) {
      return null;
    }
    state = Feed(
        feedName: feed!.feedName,
        feedUrl: feed.feedUrl,
        description: feed.description,
        category: feed.category,
        fullText: feed.fullText,
        openType: feed.openType);
  }
}
