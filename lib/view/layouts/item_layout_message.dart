import 'package:careno_admin/constant/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../constant/helpers.dart';
import '../screens/screen_chat.dart';

class ItemLayoutMessage extends StatelessWidget {
  const ItemLayoutMessage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        Get.to(ScreenChat());
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Row(
            children: <Widget>[
              GestureDetector(
                onTap: (){
                  // showPopupImage(context, user.imageUrl);
                },
                child: Container(
                  height: 60.h,
                  width: 60.w,
                  decoration: BoxDecoration(
                    color: AppColors.appPrimaryColor,
                      shape: BoxShape.circle,
                      image: DecorationImage(
                          image:  AssetImage("assets/images/profile.png"),
                          fit: BoxFit.fill)
                  ),
                ),
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Leon   (Host)",style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 18.sp
                    ),),
                    Text("Online",style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 18.sp
                    ),),
                    Text("Hey Leon we are very happy and fully enjoy your services good brother",style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 15.sp,
                        color: Color(0xFF373132),
                        overflow: TextOverflow.ellipsis
                    ),),
                  ],).marginSymmetric(horizontal: 8.h),
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("17/03/2024",style: TextStyle(fontSize: 12.sp,fontWeight: FontWeight.w500),),
              Container(
                    padding: EdgeInsets.all(5.sp),
                    decoration: BoxDecoration(
                      color: Color(0xFFFF2021),
                      shape: BoxShape.circle,

                    ),
                    child: Text("10",style: TextStyle(
                        fontWeight: FontWeight.w500,
                        color: Colors.white,
                        fontSize: 14.sp
                    ),),
                  )
                ],),

            ],
          ).marginSymmetric(horizontal: 25.w
              ,vertical: 5.h),
          Divider(
            indent: 80.w,
            endIndent: 14,
            color: Color(0xFF787878).withOpacity(.35),)
        ],
      ).marginSymmetric(vertical: 5.h),
    );
  }
}
