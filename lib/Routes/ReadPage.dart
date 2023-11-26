// ignore_for_file: non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:juyoye/Riverpod/providers.dart';

class ReadPage extends ConsumerStatefulWidget {
  const ReadPage({
    super.key,
    // this.response_content,
  });
  // final response_content;
  @override
  ConsumerState<ReadPage> createState() => ReadPageState();
}

class ReadPageState extends ConsumerState<ReadPage> {
  @override
  Widget build(BuildContext context) {
    //获取路由参数
    var getArticleHTML = ModalRoute.of(context)!.settings.arguments;

    String ArticleHtml = '''         
          <body> 
            <h1>${ref.watch(ArticalTitle_Provider)}</h1>
            ${getArticleHTML}
          </body>
      ''';
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "${ref.watch(FeedTitle_Provider)}",
        ),
      ),
      body: SingleChildScrollView(
          child: Padding(
        padding: EdgeInsets.only(top: 16, bottom: 54, left: 16, right: 16),
        child: HtmlWidget(
          // HTML页面格式
          ArticleHtml,
          textStyle: TextStyle(fontSize: 16),
          customStylesBuilder: (element) {
            if (element.localName == 'h1') {
              return {
                'font-size': '1.8em',
                'line-height': '1.3em',
              };
            }
            return {};
          },
        ),
      )),
    );
  }
}
