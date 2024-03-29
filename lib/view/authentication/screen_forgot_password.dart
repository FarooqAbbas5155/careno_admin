import 'package:careno_admin/constant/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_utils/get_utils.dart';

import '../../widgets/custom_button.dart';
import '../../widgets/custom_textfiled.dart';

class ScreenForgotPassword extends StatelessWidget {
  const ScreenForgotPassword({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xfff5f6fa),
      body: Center(
        child: Container(
          height: 512.h,
          width: 689.w,
          color: Colors.white,
          child: Column(
            children: [
              Text(
                "Forgot Password",
                style: TextStyle(
                    color: AppColors.appPrimaryColor,
                    fontFamily: "Nunito",
                    fontSize: 32.sp,
                    fontWeight: FontWeight.w700),
              ).marginOnly(top: 40.h, bottom: 20.h),
              Text(
                "Enter your valid email address",
                style: TextStyle(
                    color: AppColors.signTextColor,
                    fontWeight: FontWeight.w500,
                    fontSize: 28.sp,
                    fontFamily: "Nunito"),
              ),
              CustomTextField(
                hint: "Enter Email",
                suffix: Padding(
                  padding:  EdgeInsets.only(top: 6.h),
                  child: Icon(Icons.mail),
                ),
                padding: EdgeInsets.only(bottom: 10.h,left: 16.w),
              ).marginSymmetric(vertical: 80.h),
              CustomButton(title: "Submit", onPressed: (){

              }),


            ],
          ),
        ),
      ),
    );
  }
}
