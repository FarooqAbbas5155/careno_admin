import 'package:careno_admin/constant/helpers.dart';
import 'package:careno_admin/models/user.dart';
import 'package:careno_admin/view/layouts/layout_active_booking.dart';
import 'package:careno_admin/view/screens/screen_chat.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../constant/colors.dart';
import '../../widgets/custom_button.dart';
import '../layouts/layout_active_vehicles.dart';
import '../layouts/layout_customer_booking.dart';

class ScreenUserDetails extends StatelessWidget {
  User user;
String userType;

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(

      ),
      body: Center(child:buildDetails(),)
    );
  }

ScreenUserDetails({
    required this.userType,
    required this.user,
  });



Widget buildDetails() {
  DateTime dobDateTime = DateTime.fromMillisecondsSinceEpoch(user!.dob);
  String formattedDate = DateFormat('d MMMM yyyy ').format(dobDateTime);
  return Container(
    width: 800.w,
    padding: EdgeInsets.only(left: 30.w,bottom: 30,top: 30,right: 50),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(5.r),

    ),
    child: Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
    userType == "host"?    Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(userType == "host"?"Provider Details":"Customer Details",style: TextStyle(
                fontFamily: "Quicksand",
                fontSize: 24.sp,
                fontWeight: FontWeight.w700,
                color: Colors.black
            ),),
            Row(
              children: [
                Text("Balance:",style: TextStyle(
                    fontFamily: "Quicksand",
                    fontSize: 24.sp,
                    fontWeight: FontWeight.w700,
                    color: Colors.black
                ),),
                Text("\$${user.currentBalance}",style: TextStyle(
                    fontFamily: "Quicksand",
                    fontSize: 24.sp,
                    fontWeight: FontWeight.w700,
                    color: AppColors.appPrimaryColor
                ),),
              ],
            ),
          ],
        ):  Text(userType == "host"?"Provider Details":"Customer Details",style: TextStyle(
        fontFamily: "Quicksand",
        fontSize: 24.sp,
        fontWeight: FontWeight.w700,
        color: Colors.black
    ),),

        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              height: 75.h,
              width: 75.w,
              decoration: BoxDecoration(

                  image: DecorationImage(
                      image: NetworkImage(user.imageUrl.isEmpty?image_url:user.imageUrl)
                      // AssetImage("assets/images/user-image.png")
                  )
              ),).marginOnly(right: 15.w),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(user.name,style: TextStyle(
                    fontWeight: FontWeight.w700,
                    fontSize: 18.sp,
                    color: Colors.black
                ),),
                Text(user.address,style: TextStyle(
                    fontSize: 11.sp,
                    color: AppColors.appPrimaryColor,
                    fontWeight: FontWeight.w300,
                    decoration: TextDecoration.underline
                ),

                )
              ],
            ),
          ],
        ),
        Row(children: [
          Expanded(
            child: RichText(text: TextSpan(
                text: "Date of Birth:",
                style: TextStyle(
                    fontWeight: FontWeight.w700,
                    fontSize: 13.sp
                ),
                children: [
                  TextSpan(text: " ${formattedDate}",style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 14.sp
                  )
                  )]
            )),
          ),
          Expanded(
            child: RichText(text: TextSpan(
                text: "Gender:",
                style: TextStyle(
                    fontWeight: FontWeight.w700,
                    fontSize: 13.sp
                ),
                children: [
                  TextSpan(text: " ${user.gender}",style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 14.sp
                  )
                  )]
            )),
          ),
        ],).marginSymmetric(vertical: 10.h),
        Row(children: [
          Expanded(
            child: RichText(text: TextSpan(
                text: "Email:",
                style: TextStyle(
                    fontWeight: FontWeight.w700,
                    fontSize: 13.sp
                ),
                children: [
                  TextSpan(text: " ${user.email}",style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 14.sp
                  )
                  )]
            )),
          ),
          Expanded(
            child: RichText(text: TextSpan(
                text: "Phone No:",
                style: TextStyle(
                    fontWeight: FontWeight.w700,
                    fontSize: 13.sp
                ),
                children: [
                  TextSpan(text: "  ${user.email}",style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 14.sp
                  )
                  )]
            )),
          ),
        ],).marginSymmetric(vertical: 10.h),
        Text(user.profileDescription,style: TextStyle(
            fontSize: 11.sp,
            fontWeight: FontWeight.w500,
            color: Color(0xFF828282)
        ),
          textAlign: TextAlign.start,
        ).marginSymmetric(vertical: 8.h),
        Row(children: [
         if(userType == "host") Expanded(child: CustomButton(
            height: 46.h,
            textStyle: TextStyle(
                color: Colors.white,
                fontSize: 15.sp,
                fontWeight: FontWeight.w700
            ),
            title: "Vehicles" ,onPressed: (){
              if (userType == "host") {
                Get.to(LayoutActiveVehicles(userType:userType));
              }


          },color: Color(0xFFFE0000),).marginOnly(right: 20)),
          Expanded(child: CustomButton(
            height: 46.h,
            textStyle: TextStyle(
                color: Colors.white,
                fontSize: 15.sp,
                fontWeight: FontWeight.w700
            ),
            title:"Booking Details", onPressed: (){
            Get.to(LayoutCustomerBooking(user: user,));


          },color: Color(0xFFFE0000),)),
          SizedBox(width: 20.w,), Expanded(child
              : CustomButton(
            height: 46.h,
            textStyle: TextStyle(
                color: Colors.white,
                fontSize: 15.sp,
                fontWeight: FontWeight.w700
            ),

            title: "Send Message", onPressed: (){
              Get.to(ScreenChat(user: user,));
          },color: Color(0xFF0F9D58),)),
        ],).marginSymmetric(vertical: 8.h)
      ],
    ),
  );
}
}
