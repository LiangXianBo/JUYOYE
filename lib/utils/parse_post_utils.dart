import 'dart:io';

import 'package:http/io_client.dart';
import 'package:webfeed_revised/webfeed_revised.dart';

import '../Modle/feed.dart';
import '../Modle/post.dart';

Future parse_post(Feed feed) async {
  try {
    final client = IOClient(
      HttpClient()..badCertificateCallback = ((cert, host, port) => true),
    );
    var response = await client.get(
      Uri.parse(feed.feedUrl!), //'https://www.theverge.com/rss/index.xml'
    );

    try {
      final rssFeed = RssFeed.parse(response.body);

      List<Future> futures = [];
      for (RssItem item in rssFeed.items!) {
        // 将当前Post同时存入数据库
        if (Post.postIsNotExist_inDB(item.link)) {
          futures.add(parseRssFeed_posIitem(item, feed));
        }
      }
      Future.wait(futures);

      return true;
    } catch (e) {
      print(e);
      try {
        // Atom feed
        final atomFeed = AtomFeed.parse(response.body);

        List<Future> futures = [];
        for (AtomItem item in atomFeed.items!) {
          if (Post.postIsNotExist_inDB(item.links)) {
            // 将当前post同时存入数据库
            futures.add(parseAtomFeed_posIitem(item, feed));
          }
        }
        Future.wait(futures);
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
