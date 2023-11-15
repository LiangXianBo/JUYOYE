// ignore_for_file: unused_local_variable

import 'dart:io';

import 'package:http/io_client.dart';
import 'package:webfeed_revised/webfeed_revised.dart';

import '../Modle/feed.dart';

Future<Feed?> parse_Feed(url) async {
  final client = IOClient(
    HttpClient()..badCertificateCallback = ((cert, host, port) => true),
  );

  var response = await client.get(
    Uri.parse(url), //'https://www.theverge.com/rss/index.xml'
  );
  try {
    // RSS feed
    final rssFeed = RssFeed.parse(response.body);
    print(rssFeed);
    return Feed(
      feedName: rssFeed.title,
      feedUrl: url,
      description: rssFeed.description,
      category: null,
      fullText: false,
      openType: 0,
    );
  } catch (e) {
    try {
      // Atom feed

      final atomFeed = AtomFeed.parse(response.body);

      return Feed(
        feedName: atomFeed.title,
        feedUrl: url,
        description: atomFeed.subtitle,
        category: null,
        fullText: false,
        openType: 0,
      );
    } catch (e) {
      return null;
    }
  }
}
// var i = 0;
// Future<Feed?> parse_Feed(url) async {
//   final client = IOClient(
//     HttpClient()..badCertificateCallback = ((cert, host, port) => true),
//   );

//   // RSS feed
//   try {
//     var response = await client.get(
//       Uri.parse(url), //'https://www.theverge.com/rss/index.xml'
//     );
//     final rssFeed = RssFeed.parse(response.body);
//     // log(rssFeed.toString());
//     List rssFeed_list = [];
//     for (var list in rssFeed.items!) {
//       rssFeed_list.add(list.title);
//       // print(list.title);
//     }

//     // print(rssFeed.items!.length);
//     // print(rssFeed.title); //网站名称
//     // print(rssFeed.items?[i].title); //文章标题
//     // print(rssFeed.items?[i].link); //文章链接
//     // print(rssFeed.items![i].author); //文章作者
//     // print(rssFeed.items?[i].content);
//     // print(rssFeed.items![i].categories);
//     // print(rssFeed.items![i].comments);

//     // var response_content = await client.get(
//     //   Uri.parse(rssFeed.items![i].link
//     //       .toString()), //'https://www.theverge.com/rss/index.xml'
//     // );
//     // print(response_content.headers);

//     // print(response_content.body);
//     // var document = parse(response_content.body);
//     // print(document.outerHtml);
//     print(rssFeed_list);
//     return Feed(
//       feedName: rssFeed.title,
//       feedUrl: url,
//       description: rssFeed.description,
//       category: null,
//       fullText: false,
//       openType: 0,
//     );
//   } catch (e) {
//     // Atom feed
//     var response = await client.get(
//       Uri.parse(
//           url), // 'https://developer.apple.com/news/releases/rss/releases.rss'
//     );
//     final atomFeed = AtomFeed.parse(response.body);
//     // var atomFeed_list = atomFeed.items!.map((e) => e).toList();
//     // print(list);
//     print(atomFeed.title); //网站名称
//     // print(atomFeed.items!.length);
//     // print(atomFeed.items![i].title); //文章标题
//     // print(atomFeed.items![i].links); //文章链接
//     // // print(atomFeed.items![i].content);
//     // print(atomFeed.items![i].authors); //文章作者
//     // print(atomFeed.items![i].updated);
//     // print(atomFeed.items![i].contributors);
//     // print(atomFeed.items![i].id);
//     print(atomFeed.links);
//     // var response_content = await client.get(
//     //   Uri.parse(atomFeed.items![i].links
//     //       .toString()), //'https://www.theverge.com/rss/index.xml'
//     // );
//     // print(response_content.headers);

//     // print(response_content.body);
//     // var document = parse(response_content.body);
//     // print(document.outerHtml);
//     List atomFeed_list = [];
//     for (var list in atomFeed.items!) {
//       atomFeed_list.add(list.title);
//       // print(list.title);
//     }
//     // print(atomFeed_list[0]);
//     return Feed(
//       feedName: atomFeed.title,
//       feedUrl: .links,
//       description: atomFeed.subtitle,
//       category: null,
//       fullText: false,
//       openType: 0,
//     );
//   }
// }