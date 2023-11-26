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
      print(atomFeed);
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
