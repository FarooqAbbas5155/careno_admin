import 'package:careno_admin/constant/colors.dart';
import 'package:careno_admin/controllers/auth_controller.dart';
import 'package:careno_admin/view/authentication/screen_forgot_password.dart';
import 'package:careno_admin/view/authentication/screen_sign_up.dart';
import 'package:careno_admin/widgets/custom_button.dart';
import 'package:careno_admin/widgets/custom_textfiled.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:get/get_utils/get_utils.dart';

class ScreenLogin extends StatelessWidget {
  AuthController authController = Get.put(AuthController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xfff5f6fa),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              "Careno Web Admin",
              style: TextStyle(
                  color: AppColors.appPrimaryColor,
                  fontSize: 60.sp,
                  fontWeight: FontWeight.w700,
                  fontFamily: "Urbanist"),
            ).marginOnly(bottom: 102.h),
            Container(
              height: 512.h,
              width: 689.w,
              color: Colors.white,
              child: Column(
                children: [
                  Text(
                    "Sign in to Start your session",
                    style: TextStyle(
                        color: AppColors.signTextColor,
                        fontWeight: FontWeight.w600,
                        fontSize: 28.sp,
                        fontFamily: "Nunito"),
                  ).marginOnly(top: 60.h,bottom: 30.h),
                  CustomTextField(
                    controller: authController.emailController.value,
                    hint: "Enter Email",
                    suffix: Padding(
                      padding:  EdgeInsets.only(top: 6.h),
                      child: Icon(Icons.mail),
                    ),
                    padding: EdgeInsets.only(bottom: 10.h,left: 16.w),
                    width: 534.w,
                  ),
                  CustomTextField(
                    controller: authController.passwordController.value,
                    hint: "Password",
                    suffix: Padding(
                      padding:  EdgeInsets.only(top: 6.h),
                      child: Icon(Icons.lock),

                    ),
                    width: 534.w,
                    padding: EdgeInsets.only(bottom: 10.h,left: 16.w),
                  ).marginSymmetric(vertical: 30.h),
                  GestureDetector(
                    onTap: (){
                      Get.to(ScreenForgotPassword());
                    },
                    child: SizedBox(
                      width: 534.w,
                      child: Align(
                        alignment: Alignment.bottomRight,
                        child: Text(
                          "Forgot Password",
                          style: TextStyle(
                              color: Colors.red,
                              fontWeight: FontWeight.w500,
                              fontSize: 17.sp,
                              fontFamily: "DmSansItalic",
                            decoration:TextDecoration.underline
                          ),
                        ),
                      ),
                    ),
                  ),
                  CustomButton(title: "Sign In", onPressed: ()async{
                    var response=  await authController.LoginIn();
                    // if (response == "success") {
                    //   ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Login")));
                    // }
                    // else{
                    //   ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(response.toString())));
                    // print(response.toString());
                    // }
                  }).marginSymmetric(vertical: 30.h),
                  GestureDetector(
                      onTap: () async{
                        Get.to(ScreenSignUp());
                      },
                      child: Text(
                        "Don’t have account? Register",
                        style: TextStyle(
                            color: AppColors.appPrimaryColor,
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w700,
                            fontFamily: "Urbanist"),
                      )),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
