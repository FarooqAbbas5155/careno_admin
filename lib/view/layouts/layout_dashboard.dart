import 'package:careno_admin/constant/colors.dart';
import 'package:careno_admin/controllers/home_controller.dart';
import 'package:careno_admin/view/screens/screeb_block_customer_list.dart';
import 'package:careno_admin/view/screens/screen_block_provider_list.dart';
import 'package:careno_admin/view/screens/table.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class LayoutDashboard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    HomeController controller = Get.put(HomeController());

    return Scaffold(
      backgroundColor: Color(0xfff5f6fa),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Dashborad",
            style: TextStyle(
                color: AppColors.appPrimaryColor,
                fontFamily: "Nunito",
                fontSize: 50.sp,
                fontWeight: FontWeight.w800),
          ).marginSymmetric(vertical: 20.h),
          Wrap(
            spacing: 20,
            runSpacing: 20,

            children: [
              CustomContainer(Color(0xff0085cc), controller.categories.value.length.toString(), "Total Categories",
                  "category.png", () {
                Get.to(CustomTable());
                  }),
              CustomContainer(Color(0xff27b097), controller.user.value.length.toString(), "Total Users",
                  "user.png", () {}),
              CustomContainer(Color(0xffff5252), controller.Blockuser.value.length.toString(), "Blocked Users",
                  "block_user.png", () {
                Get.to(ScreebBlockCustomerList());
                  }),
              CustomContainer(Color(0xffafc23b), controller.host.value.length.toString(), "Total Providers",
                  "provider.png", () {}),
              CustomContainer(Color(0xff0a9bb0), controller.Blockhost.value.length.toString(), "Blocked Providers",
                  "block_provider.png", () {
                Get.to(ScreenBlockProviderList());
                  }),
              CustomContainer(Color(0xff7f3bc2), controller.hostRequest.value.length.toString(), "Providers Requests",
                  "provider_request.png", () {
                // Get.to(Screen)
                  }),
              CustomContainer(Color(0xff3f51b5), controller.vehiclesRequest.value.length.toString(), "Vehicles Requests",
                  "vehicle_request.png", () {}),
              CustomContainer(AppColors.appPrimaryColor.withOpacity(.8),  controller.message.value.length.toString().isEmpty?"0":controller.message.value.length.toString(), "Messages",
                  "message.png", () {}),
            ],
          ),
        ],
      ).marginSymmetric(horizontal: 30.w, vertical: 20.h),
    );
  }
}

Widget CustomContainer(Color color, String itemLength, title, imagepath,
    VoidCallback voidCallback) {
  return Container(
    height: 160.h,
    width: 313.w,
    decoration:
        BoxDecoration(color: color, borderRadius: BorderRadius.circular(5.r)),
    child: Column(
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                itemLength,
                style: TextStyle(
                    color: Colors.white,
                    fontFamily: "Nunito",
                    fontSize: 30.sp,
                    fontWeight: FontWeight.w700),
              ).marginOnly(top: 15.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w700,
                        fontSize: 20.sp,
                        fontFamily: "Nunito"),
                  ),
                  Padding(
                    padding:  EdgeInsets.only(bottom: 15.h),
                    child: Image.asset(
                      "assets/images/${imagepath}",
                      height: 55.h,
                      width: 60.w,
                      color: Colors.white,
                    ),
                  )
                ],
              ),
            ],
          ),
        ),
        Expanded(
          child: GestureDetector(
            onTap: voidCallback,
            child: Container(
              color: Colors.transparent.withOpacity(.2),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "More Info",
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w700,
                        fontSize: 13.sp,
                        fontFamily: "Nunito"),
                  ).marginSymmetric(horizontal: 10.w),
                  Container(
                    padding: EdgeInsets.all(2.r),
                    decoration: BoxDecoration(
                        color: Colors.white, shape: BoxShape.circle),
                    child: Icon(
                      Icons.arrow_forward_outlined,
                      color: color,
                      size: 10.sp,
                    ),
                  )
                ],
              ),
            ),
          ),
        )
      ],
    ),
  );
}
