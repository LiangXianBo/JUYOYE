import 'package:flutter/material.dart';

import '../Modle/feed.dart';
import '../utils/parse_feed_utils.dart';

class AddFeedPage extends StatefulWidget {
  const AddFeedPage({super.key});

  @override
  State<AddFeedPage> createState() => AddFeedPageState();
}

class AddFeedPageState extends State<AddFeedPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("添加订阅"),
      ),
      body: ElevatedButton(
          onPressed: () async {
            Feed? feed = await parse_Feed(
                'https://sspai.com/feed'); //'https://sspai.com/feed'
            await feed!.insertFeed_toDB();
          },
          child: Text("添加")),
    );
  }
}
