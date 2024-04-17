import 'package:flutter/material.dart';

import '../../widgets/bubble_special_three.dart';

class ItemChat extends StatelessWidget {
  const ItemChat({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  Column(
      children: [
        BubbleSpecialThree(
          text: "How are you dear",
          tail: false,//message.sender_id == uid ?true:false,
          sent: false,//message.sender_id == uid ?true:false,
          isSender:false,
          seen: false,
          delivered: false,
          time: "17/03/2024 10:11 AM",
        ),
        BubbleSpecialThree(
          text: "Im fine dear i hope you will be fine",
          tail: false,//message.sender_id == uid ?true:false,
          sent: false,//message.sender_id == uid ?true:false,
          isSender:true,
          seen: false,
          delivered: false,
          time: "17/03/2024 12:11 AM",
        ),
      ],
    );
  }
}
