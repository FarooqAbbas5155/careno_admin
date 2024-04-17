import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../constant/colors.dart';
import '../../widgets/custom_svg.dart';
import '../layouts/item_chat.dart';

class ScreenChat extends StatelessWidget {
  const ScreenChat({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xfff5f6fa),
      appBar: AppBar(
        elevation: 1,
        leadingWidth: 75.w,
        leading: GestureDetector(
          onTap: (){
            Get.back();
          },
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(width: 10.w,),
              CustomSvg(name: "arrow",),

              Expanded(
                child: CircleAvatar(
                    radius: 35.r,
                    backgroundImage:AssetImage("assets/images/profile.png")
                ),
              ),

            ],
          ),
        ),
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text("Leon",style: TextStyle(
                fontWeight: FontWeight.w700,
                fontSize: 25.sp
            ),),
            Text("Last Seen 9 hour ago",style: TextStyle(
                fontSize: 18.sp,
                fontWeight: FontWeight.w500,
                color: Colors.black.withOpacity(.4)
            ),),
          ],
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: List.generate(
                  18,
                      (index) => ItemChat(), // Replace with your chat item widget
                ),
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
            color: Colors.white,
            child: Row(
              children: <Widget>[
                Expanded(
                  child: TextField(
                    maxLines: 6,
                    minLines: 1,
                    decoration: InputDecoration(
                      hintText: "Write something...",
                      hintStyle: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 16.sp,
                        color: Color(0xFFC6C4CC),
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(40.r),
                        borderSide: BorderSide.none,
                      ),
                      filled: true,
                      fillColor: Color(0xFFF2F2F2),
                    ),
                  ),
                ),
                SizedBox(width: 10.w),
                InkWell(
                  onTap: () {
                    // Handle send button tap
                  },
                  child: Container(
                    height: 48.h,
                    width: 48.w,
                    decoration: BoxDecoration(
                      color: AppColors.appPrimaryColor,
                      borderRadius: BorderRadius.circular(8.r),
                    ),
                    child: Icon(
                      Icons.send,
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
