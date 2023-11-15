import 'dart:io';

import 'package:http/io_client.dart';
import 'package:webfeed_revised/domain/atom_feed.dart';
import 'package:webfeed_revised/domain/rss_feed.dart';
import 'package:webfeed_revised/webfeed_revised.dart';

import '../Modle/feed.dart';
import '../Modle/post.dart';

void main() {
  // parse_post("https://developer.apple.com/news/releases/rss/releases.rss");
}

Future parse_post(Feed feed) async {
  try {
    final client = IOClient(
      HttpClient()..badCertificateCallback = ((cert, host, port) => true),
    );
    var response = await client.get(
      Uri.parse(feed.feedUrl!), //'https://www.theverge.com/rss/index.xml'
    );
    // print(response.body);
    print("parse_post");
    // print(feed);
    // RSS feed
    try {
      final rssFeed = RssFeed.parse(response.body);
      print(rssFeed);
      List<Future> futures = [];
      for (RssItem item in rssFeed.items!) {
        print(item);
        futures.add(parseRssFeed_posIitem(item, feed));
        print("item");
      }
      Future.wait(futures);
      print(rssFeed);
      return true;
    } catch (e) {
      print(e);
      try {
        // Atom feed
        final atomFeed = AtomFeed.parse(response.body);
        print(atomFeed);
        List<Future> futures = [];
        for (AtomItem item in atomFeed.items!) {
          futures.add(parseAtomFeed_posIitem(item, feed));
        }
        Future.wait(futures);

        print(atomFeed);
      } catch (e) {
        print(e);
        return;
      }
      return true;
    }
  } catch (e) {}
}

// 使用Rss格式解析[Rss订阅源]，存入数据库
Future parseRssFeed_posIitem(RssItem rssItem, Feed feed) async {
  Post post = Post(
      feedId: feed.id,
      feedName: feed.feedName,
      title: rssItem.title,
      link: rssItem.link,
      description: rssItem.description,
      pubDate: rssItem.pubDate.toString(),
      isRead: false,
      isFavorite: false,
      isFullText: false,
      isFullTextCache: false,
      openType: 0);
  await post.insertPostdata_toDB(); // 将数据写入到 Isar
}

// 使用Atom格式解析[Rss订阅源]，存入数据库
Future parseAtomFeed_posIitem(AtomItem atomItem, Feed feed) async {
  Post post = Post(
      feedId: feed.id,
      feedName: feed.feedName,
      title: atomItem.title,
      link: atomItem.links![0].href,
      description: atomItem.content,
      pubDate: atomItem.updated.toString(),
      isRead: false,
      isFavorite: false,
      isFullText: false,
      isFullTextCache: false,
      openType: 0);
  await post.insertPostdata_toDB(); // 将数据写入到 Isar
}
