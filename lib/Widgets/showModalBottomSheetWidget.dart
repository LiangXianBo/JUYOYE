import 'package:flutter/material.dart';

import '../Routes/AddFeedPage.dart';

class ShowModalBottomSheetWidget extends StatefulWidget {
  const ShowModalBottomSheetWidget({super.key});

  @override
  State<ShowModalBottomSheetWidget> createState() =>
      ShowModalBottomSheetWidgetState();
}

class ShowModalBottomSheetWidgetState
    extends State<ShowModalBottomSheetWidget> {
  @override
  Widget build(BuildContext context) {
    return AddFeedPage();
  }
}
