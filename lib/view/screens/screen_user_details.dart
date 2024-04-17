import 'package:careno_admin/view/screens/screen_chat.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../constant/colors.dart';
import '../../widgets/custom_button.dart';
import '../layouts/layout_active_vehicles.dart';
import '../layouts/layout_customer_booking.dart';

class ScreenUserDetails extends StatelessWidget {
String userType;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(

      ),
      body: buildDetails(),
    );
  }

ScreenUserDetails({
    required this.userType,
  });



Widget buildDetails() {
  return Container(
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
                Text("\$300",style: TextStyle(
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

                  image: DecorationImage(image: AssetImage("assets/images/user-image.png"))
              ),).marginOnly(right: 15.w),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text("Kristin Watson",style: TextStyle(
                    fontWeight: FontWeight.w700,
                    fontSize: 18.sp,
                    color: Colors.black
                ),),
                Text("Street 2, House No, City, New York, United State",style: TextStyle(
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
                  TextSpan(text: " 21 January, 0020",style: TextStyle(
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
                  TextSpan(text: " Male",style: TextStyle(
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
                  TextSpan(text: " example45.@gmail.com",style: TextStyle(
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
                  TextSpan(text: "  +1 548 3435 547",style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 14.sp
                  )
                  )]
            )),
          ),
        ],).marginSymmetric(vertical: 10.h),
        Text("Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged.",style: TextStyle(
            fontSize: 11.sp,
            fontWeight: FontWeight.w500,
            color: Color(0xFF828282)
        ),
          textAlign: TextAlign.start,
        ).marginSymmetric(vertical: 8.h),
        Row(children: [
          Expanded(child: CustomButton(
            height: 46.h,
            textStyle: TextStyle(
                color: Colors.white,
                fontSize: 15.sp,
                fontWeight: FontWeight.w700
            ),
            title:userType == "host"? "Vehicles":"Booking Details", onPressed: (){
              if (userType == "host") {
                Get.to(LayoutActiveVehicles());
              }
              else{
                Get.to(LayoutCustomerBooking());
              }

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
              Get.to(ScreenChat());
          },color: Color(0xFF0F9D58),)),
        ],).marginSymmetric(vertical: 8.h)
      ],
    ),
  );
}
}
