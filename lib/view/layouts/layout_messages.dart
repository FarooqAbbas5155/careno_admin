import 'package:flutter/material.dart';

import '../../constant/colors.dart';
import 'item_layout_message.dart';

class LayoutMessages extends StatelessWidget {
  const LayoutMessages({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          centerTitle: false,
          backgroundColor: AppColors.backGroundColor,
          elevation: 0,
          title: Text("Messages",style: AppColors.headingStyle)
      ),
      body: ListView.builder(
        shrinkWrap: true,
        itemCount: 20,
        scrollDirection: Axis.vertical,
        itemBuilder: (BuildContext context, int index) {
          return ItemLayoutMessage();
        },),
    );
  }
}
