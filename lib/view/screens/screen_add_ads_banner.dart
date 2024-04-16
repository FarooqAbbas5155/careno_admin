import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../constant/colors.dart';
import '../../constant/web_utils.dart';
import '../../widgets/custom_button.dart';
import '../../widgets/custom_textfiled.dart';

class ScreenAddAdsBanner extends StatefulWidget {
 String status;
  @override
  State<ScreenAddAdsBanner> createState() => _ScreenAddAdsBannerState();

 ScreenAddAdsBanner({
    required this.status,
  });
}

class _ScreenAddAdsBannerState extends State<ScreenAddAdsBanner> {
  PickedImageData? _pickedImageData;
  TextEditingController bannerUrlController = TextEditingController();
  TextEditingController bannerImageController = TextEditingController();
  TextEditingController DateImageController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          centerTitle: false,
          backgroundColor: AppColors.backGroundColor,
          elevation: 0,
          title: Text("Promotional Banner",style: AppColors.headingStyle)
      ),
      backgroundColor: AppColors.backGroundColor,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [

          Container(
            width: Get.width*.5,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5.r),
                color: Colors.white
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 20.w,vertical: 15.h),
                  width: Get.width,
                  decoration: BoxDecoration(
                    color: AppColors.appPrimaryColor,
                    borderRadius: BorderRadius.circular(5.r),
                  ),

                  child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text("Add New Banner",style: AppColors.headingStyle.copyWith(color: Colors.white,fontWeight: FontWeight.w700,fontSize: 24.sp),)),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Banner URL",style: TextStyle(color: Colors.black,fontWeight: FontWeight.w700,fontFamily: "Nunito",fontSize: 22.sp),).marginOnly(top: 25.h,bottom: 5.h),
                    CustomTextField(
                      controller: bannerUrlController,
                      hint: "Add Url",
                    ),
                    Text("Banner Expire Date",style: TextStyle(color: Colors.black,fontWeight: FontWeight.w700,fontFamily: "Nunito",fontSize: 22.sp),).marginOnly(top: 25.h,bottom: 5.h),
                    CustomTextField(
                      controller: bannerUrlController,
                      hint: "20/04/2000",
                    ),
                    Text("Banner Image",style: TextStyle(color: Colors.black,fontWeight: FontWeight.w700,fontFamily: "Nunito",fontSize: 22.sp),).marginOnly(top: 25.h,bottom: 5.h),

                    CustomTextField(
                      readOnly: true,
                      onTap: () async {
                        final pickedImage = await FileUtilsWeb.pickImage(FileType.image);
                        if (pickedImage != null) {
                          setState(() {
                            _pickedImageData = pickedImage;
                            bannerImageController.text=_pickedImageData!.name;
                          });
                        }
                      },
                      padding: EdgeInsets.only(top: 20.h,left: 20.w),
                      hint: "No File Chosen",
                      controller: bannerImageController,
                      prefix: Container(
                        padding: EdgeInsets.all(5),
                        margin: EdgeInsets.only(top: 10.h,left: 10.w,right: 5.w),
                        decoration: BoxDecoration(
                          color: Color(0xFf767676).withOpacity(.76),
                          border: Border.all(color: Color(0xFF767676).withOpacity(.76)),
                        ),
                        child: Text("Choose File",style: TextStyle(color: Colors.black,fontFamily: "Nunito",fontWeight: FontWeight.w500,fontSize: 22.sp),),
                      ),
                    ),
                    if(_pickedImageData!=null)Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5.r),
                          color: Colors.white
                      ),
                      margin: EdgeInsets.symmetric(vertical: 20.h),
                      padding: EdgeInsets.all( 10.h),
                      height: 150,
                      width: 150,
                      child: Image.memory(_pickedImageData!.data),
                    ),
                    CustomButton(title: widget.status, onPressed: ()async{ }).marginSymmetric(vertical: 30.h)
                  ],).marginSymmetric(horizontal: 15.w)
              ],),
          )
        ],
      ).marginSymmetric(horizontal: 30.w,vertical: 20.h),
    );
  }
}
