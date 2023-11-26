// ignore_for_file: non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';

import '../Riverpod/providers.dart';

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
    return Scaffold(
      appBar: AppBar(
        title: Text("阅读页面"),
      ),
      body: SizedBox(
        // width: 500,
        child: SingleChildScrollView(
          child: HtmlWidget(
              // HTML页面格式
              "${getArticleHTML}"),
        ),
      ),
    );
  }
}
// <body>
//   <h3>Heading</h3>
//   <p>

//     A paragraph with <strong>strong</strong>, <em>emphasized</em>
//     and <span style="color: red">colored</span> text.
//   </p>
// </body>