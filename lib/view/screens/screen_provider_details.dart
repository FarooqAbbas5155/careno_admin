import 'package:careno_admin/constant/colors.dart';
import 'package:careno_admin/constant/helpers.dart';
import 'package:careno_admin/models/user.dart';
import 'package:careno_admin/widgets/custom_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../widgets/custom_svg.dart';

class ScreenProviderDetails extends StatelessWidget {
User host;
String DateOfBirth = "";
  @override
  Widget build(BuildContext context) {
    DateTime parsedDate = DateFormat("dd MMMM, yyyy").parse(host.dob.toString());

    // Format the DateTime object into the desired output format
     DateOfBirth = DateFormat("dd MMMM, yyyy").format(parsedDate);
    return Scaffold(
      appBar: AppBar(
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
                    backgroundImage:NetworkImage(host.imageUrl)

                    // AssetImage("assets/images/profile.png")
                ),
              ),

            ],
          ),
        ),
        title: Text(
          "Provider Details",
          style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.w700,
              fontSize: 24,
              fontFamily: "Quicksand"),
        ),
      ),
      body: LayoutBuilder(builder: (BuildContext context, BoxConstraints constraints) {
        if (constraints.maxWidth > 800) {
        return  Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                  flex: 1,
                  child: buildDetails()),
              SizedBox(width: 2,),
              Expanded(
                  flex: 1,
                  child:buildDocumnets()),
            ],
          ).marginSymmetric(horizontal: 50.w,vertical: 20);
        }
        else{
         return SingleChildScrollView(
           child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                buildDetails(),
                buildDocumnets(),
              ],
            ).marginSymmetric(horizontal: 50.w,vertical: 20),
         );
        }
      },)
    );
  }
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
          Text("Provider Details",style: TextStyle(
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
                    image:NetworkImage(host.imageUrl.isEmpty?image_url:host.imageUrl)
                    // AssetImage("assets/images/user-image.png")
                )
              ),).marginOnly(right: 15.w),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(host.name,style: TextStyle(
                    fontWeight: FontWeight.w700,
                    fontSize: 18.sp,
                    color: Colors.black
                  ),),
                  Text(host.address,style: TextStyle(
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
                  TextSpan(
                      text:  "${DateOfBirth}",style: TextStyle(
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
                  TextSpan(text: " ${host.gender}",style: TextStyle(
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
                  TextSpan(text: " ${host.email}",style: TextStyle(
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
                  TextSpan(text: "  ${host.phoneNumber}",style: TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 14.sp
              )
                  )]
              )),
            ),
          ],).marginSymmetric(vertical: 10.h),
          Text(host.profileDescription,style: TextStyle(
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
              title: "Decline Account", onPressed: (){

            },color: Color(0xFFFE0000),)),
           SizedBox(width: 20.w,), Expanded(child
                : CustomButton(
              height: 46.h,
              textStyle: TextStyle(
                color: Colors.white,
                fontSize: 15.sp,
                fontWeight: FontWeight.w700
              ),

              title: "Approve Account", onPressed: ()async{
                await usersRef.doc(host.uid).update({"isVerified": true}).then((value) {
                  Get.snackbar("Alert", "Account Approved",backgroundColor: AppColors.appPrimaryColor,colorText: Colors.white);
                });
            },color: Color(0xFF0F9D58),)),
          ],).marginSymmetric(vertical: 8.h)
        ],
      ),
    );
  }
  Widget buildDocumnets(){
    return Container(
      padding: EdgeInsets.symmetric(vertical: 20,horizontal: 50.w),
      decoration: BoxDecoration(
        color: Colors.white
      ),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text("Insurance Certificate",style: TextStyle(
                fontWeight: FontWeight.w700,
                fontSize: 24.sp,
                fontFamily: "Quicksand",
                color:  Colors.black
            ),),
            Align(
              alignment: Alignment.center,
              child: Container(
                height: 220.h,
                width: 306.w,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.white,
                    image: DecorationImage(
                      image: NetworkImage(host.hostIdentity!.insurancePath)
                      // AssetImage("assets/images/insurance.png"),
                    )
                ),
              ),
            ).marginAll(20),
            RichText(text: TextSpan(
                text: "National ID ",
                style: TextStyle(
                    fontWeight: FontWeight.w700,
                    fontSize: 24.sp,
                    fontFamily: "Quicksand",
                    color:  Colors.black
                ),
                children: [
                  TextSpan(text:"(Front)" ,
                    style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 20.sp,
                        fontFamily: "Quicksand",
                        color:  Colors.black.withOpacity(.5
                        )
                    ),)
                ]
            )),
            Align(
              alignment: Alignment.center,
              child: Container(
                height: 220.h,
                width: 306.w,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.white,
                    image: DecorationImage(
                      image: NetworkImage(host.hostIdentity!.idFrontPath)
                      // AssetImage("assets/images/insurance.png"),
                    )
                ),
              ),
            ).marginAll(20),
            RichText(text: TextSpan(
                text: "National ID ",
                style: TextStyle(
                    fontWeight: FontWeight.w700,
                    fontSize: 24.sp,
                    fontFamily: "Quicksand",
                    color:  Colors.black
                ),
                children: [
                  TextSpan(text:"(Back)" ,
                    style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 20.sp,
                        fontFamily: "Quicksand",
                        color:  Colors.black.withOpacity(.5
                        )
                    ),)
                ]
            )),
            Align(
              alignment: Alignment.center,
              child: Container(
                height: 220.h,
                width: 306.w,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.white,
                    image: DecorationImage(
                      image: NetworkImage(host.hostIdentity!.idBackPath),
                      // AssetImage("assets/images/insurance.png"),
                    )
                ),
              ),
            ).marginAll(20),
            
          ],
        )
      ),
    );
  }

ScreenProviderDetails({
    required this.host,
  });
}
