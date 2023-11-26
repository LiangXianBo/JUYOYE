// ignore_for_file: non_constant_identifier_names, invalid_use_of_visible_for_testing_member, invalid_use_of_protected_member

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart';
import 'package:isar/isar.dart';
import 'package:juyoye/Global/global.dart';
import 'package:juyoye/Routes/HomePage.dart';

import '../Modle/feed.dart';
import '../Riverpod/providers.dart';
import '../utils/parse_feed_utils.dart';

class AddFeedPage extends ConsumerStatefulWidget {
  const AddFeedPage({super.key});

  @override
  ConsumerState<AddFeedPage> createState() => AddFeedPageState();
}

class AddFeedPageState extends ConsumerState<AddFeedPage> {
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
          height: 380,
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
                            // 解析订阅源获取Feed值的状态
                            ref
                                .read(feedNotifier_provider.notifier)
                                .getfeed(addFeedUrlController.text);
                            // feed信息卡片显示状态
                            ref.read(isShowfeedCard_Provider.notifier).state =
                                true;
                          } catch (e) {
                            // feed信息卡片显示状态
                            ref.read(isShowfeedCard_Provider.notifier).state =
                                false;
                            return null;
                          }
                        },
                      ),
                    ],
                  )),
              Consumer(builder: (context, ref, child) {
                final bool isShowfeedCard = ref.watch(isShowfeedCard_Provider);

                return isShowfeedCard
                    ? Padding(
                        padding: EdgeInsets.only(top: 10),
                        child: Card(
                          color: Colors.white70,
                          // elevation: 1,
                          child: InkWell(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10)),
                              onTap: () {
                                ScaffoldMessenger.of(context)
                                    .showSnackBar(const SnackBar(
                                  content: Text('Tap'),
                                ));

                                try {
                                  ref
                                      .read(feedNotifier_provider.notifier)
                                      .state
                                      .insertFeed_toDB()
                                      .then((value) {
                                    ref.read(feedList_Provider.notifier).state =
                                        Global.isar!.feeds
                                            .where()
                                            .findAllSync();
                                  });
                                } catch (e) {
                                  return null;
                                }
                              },
                              child: Padding(
                                padding: EdgeInsets.all(10),
                                child: Column(
                                  children: [
                                    Text(
                                      "${ref.watch(feedNotifier_provider).feedName}",
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                        // color: Global.elevatedbuttonTextColor,
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.only(top: 10),
                                      child: Text(
                                        "${ref.watch(feedNotifier_provider).description}",
                                        style: TextStyle(
                                          fontSize: 14,
                                          // color: Global.elevatedbuttonTextColor,
                                        ),
                                      ),
                                    ),
                                    // Container(
                                    //     padding: EdgeInsets.only(top: 10),
                                    //     alignment: Alignment.centerRight,
                                    //     child: SizedBox(
                                    //       width: 100,
                                    //       child: ElevatedButton(
                                    //         style: ButtonStyle(
                                    //           backgroundColor:
                                    //               MaterialStatePropertyAll(
                                    //                   Global.elevatedbuttonColor),
                                    //         ),
                                    //         onPressed: () {},
                                    //         child: Text(
                                    //           "保存",
                                    //           style: TextStyle(
                                    //             color:
                                    //                 Global.elevatedbuttonTextColor,
                                    //             fontSize: 16,
                                    //           ),
                                    //         ),
                                    //       ),
                                    //     ))
                                  ],
                                ),
                              )),
                        ),
                      )
                    : Container();
              }),
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
