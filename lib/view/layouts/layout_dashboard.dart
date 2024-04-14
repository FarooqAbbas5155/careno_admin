import 'package:careno_admin/constant/colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class LayoutDashboard extends StatelessWidget {
  const LayoutDashboard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
          GridView(
            shrinkWrap: true,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                childAspectRatio: 2.4,
                crossAxisSpacing: 80.w,
                mainAxisSpacing: 50.h,
                crossAxisCount: 3),
            children: [
              CustomContainer(Color(0xff0085cc), "50.k", "Total Categories",
                  "category.png", () {}),
              CustomContainer(Color(0xff27b097), "50.k", "Total Users",
                  "user.png", () {}),
              CustomContainer(Color(0xffff5252), "50.k", "Blocked Users",
                  "block_user.png", () {}),
              CustomContainer(Color(0xffafc23b), "50.k", "Total Providers",
                  "provider.png", () {}),
              CustomContainer(Color(0xff0a9bb0), "50.k", "Blocked Providers",
                  "block_provider.png", () {}),
              CustomContainer(Color(0xff7f3bc2), "50.k", "Providers Requests",
                  "provider_request.png", () {}),
              CustomContainer(Color(0xff3f51b5), "50.k", "Vehicles Requests",
                  "vehicle_request.png", () {}),
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
    height: 138.h,
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
