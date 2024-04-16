import 'package:careno_admin/constant/colors.dart';
import 'package:careno_admin/widgets/custom_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class ScreenProviderDetails extends StatelessWidget {
  const ScreenProviderDetails({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
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
              title: "Decline Account", onPressed: (){},color: Color(0xFFFE0000),)),
           SizedBox(width: 20.w,), Expanded(child
                : CustomButton(
              height: 46.h,
              textStyle: TextStyle(
                color: Colors.white,
                fontSize: 15.sp,
                fontWeight: FontWeight.w700
              ),

              title: "Approve Account", onPressed: (){},color: Color(0xFF0F9D58),)),
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
                      image: AssetImage("assets/images/insurance.png"),
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
                      image: AssetImage("assets/images/insurance.png"),
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
                      image: AssetImage("assets/images/insurance.png"),
                    )
                ),
              ),
            ).marginAll(20),
            
          ],
        )
      ),
    );
  }
}
