// ignore_for_file: non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart';
import 'package:juyoye/Global/global.dart';

import '../Modle/feed.dart';
import '../utils/parse_feed_utils.dart';

class AddFeedPage extends StatefulWidget {
  const AddFeedPage({super.key});

  @override
  State<AddFeedPage> createState() => AddFeedPageState();
}

class AddFeedPageState extends State<AddFeedPage> {
  TextEditingController addFeedUrlController = TextEditingController();
  @override
  void dispose() {
    addFeedUrlController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: MediaQuery.of(context).viewInsets,
      child: Container(
          padding: const EdgeInsets.all(20),
          height: 300,
          child: Column(
            children: [
              const Padding(
                padding: EdgeInsets.only(bottom: 20),
                child: Text("添加订阅", style: TextStyle(fontSize: 20)),
              ),
              TextField(
                autofocus: true,
                controller: addFeedUrlController,
                decoration: InputDecoration(
                  labelText: "订阅源地址",
                  labelStyle: TextStyle(
                    color: Global.label_TextFieldTextColor,
                    fontSize: Global.label_TextFieldTextFontsize,
                  ),
                  floatingLabelStyle: const TextStyle(
                    color: Colors.black,
                    fontSize: 20,
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Global.elevatedbuttonColor,
                      width: 2,
                    ),
                    borderRadius: const BorderRadius.all(Radius.circular(10)),
                  ),
                  border: const OutlineInputBorder(
                    borderSide: BorderSide(width: 10),
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                  ),
                ),
              ),
              Container(
                  width: 250,
                  padding: const EdgeInsets.only(
                    top: 20,
                  ),
                  alignment: Alignment.center,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      //粘贴
                      addFeedPage_ElevatedButton(
                        buttontext: '粘贴',
                        onpressed: () {
                          Clipboard.getData(Clipboard.kTextPlain).then((value) {
                            addFeedUrlController.text = value!.text!;
                            addFeedUrlController.selection =
                                TextSelection.fromPosition(TextPosition(
                                    offset: addFeedUrlController.text.length));
                          });
                        },
                      ),
                      // 解析订阅地址
                      addFeedPage_ElevatedButton(
                        buttontext: '解析',
                        onpressed: () async {
                          try {
                            Feed? feed = await parse_Feed(addFeedUrlController
                                .text); //'https://sspai.com/feed'
                            await feed!.insertFeed_toDB();
                          } catch (e) {
                            return null;
                          }
                        },
                      ),
                    ],
                  )),
            ],
          )),
    );
  }

  // 按钮
  Widget addFeedPage_ElevatedButton({
    required String buttontext,
    required onpressed,
  }) {
    return Container(
      padding: const EdgeInsets.all(5),
      width: 120,
      // height: 45,
      child: ElevatedButton(
        style: ButtonStyle(
          backgroundColor: MaterialStatePropertyAll(Global.elevatedbuttonColor),
        ),
        onPressed: onpressed,
        child: Text(
          buttontext,
          style: TextStyle(
            color: Global.elevatedbuttonTextColor,
            fontSize: Global.elevatedbuttonFontsize,
          ),
        ),
      ),
    );
  }
}
