import 'dart:developer';
import 'dart:typed_data';

import 'package:careno_admin/controllers/home_controller.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../constant/colors.dart';
import '../../constant/web_utils.dart';
import '../../widgets/custom_button.dart';
import '../../widgets/custom_textfiled.dart';
import '../layouts/layout_active_vehicles.dart';

class ScreenAddAdsBanner extends StatefulWidget {
  String status;

  @override
  State<ScreenAddAdsBanner> createState() => _ScreenAddAdsBannerState();

  ScreenAddAdsBanner({
    required this.status,
  });
}

class _ScreenAddAdsBannerState extends State<ScreenAddAdsBanner> {
  List<Uint8List>? _pickedImageData;
  TextEditingController bannerDescriptionController = TextEditingController();
  TextEditingController bannerImageController = TextEditingController();
  TextEditingController DateImageController = TextEditingController();
  HomeController controller = Get.put(HomeController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          centerTitle: false,
          backgroundColor: AppColors.backGroundColor,
          elevation: 0,
          title: Text("Promotional Banner", style: AppColors.headingStyle)
      ),
      backgroundColor: AppColors.backGroundColor,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [

          Container(
            width: Get.width * .5,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5.r),
                color: Colors.white
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: EdgeInsets.symmetric(
                      horizontal: 20.w, vertical: 15.h),
                  width: Get.width,
                  decoration: BoxDecoration(
                    color: AppColors.appPrimaryColor,
                    borderRadius: BorderRadius.circular(5.r),
                  ),

                  child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text("Add New Banner",
                        style: AppColors.headingStyle.copyWith(
                            color: Colors.white,
                            fontWeight: FontWeight.w700,
                            fontSize: 24.sp),)),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Banner Description", style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.w700,
                        fontFamily: "Nunito",
                        fontSize: 22.sp),).marginOnly(top: 25.h, bottom: 5.h),
                    CustomTextField(
                      controller: bannerDescriptionController,
                      hint: "Add Description",
                      minLines: 1,
                      maxLines: 3,
                      padding: EdgeInsets.only(top: 4.h,left: 4.w),
                    ),
                    Text("Selecct Vehicel", style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.w700,
                        fontFamily: "Nunito",
                        fontSize: 22.sp),).marginOnly(top: 25.h, bottom: 5.h),
                    GetBuilder(
                      init: Get.put(HomeController()),
                      builder: (HomeController logic) {
                        return CustomTextField(
                          controller: TextEditingController(
                              text: logic.bannerModel.value),
                          // controller: bannerUrlController,
                          text: logic.bannerModel.value.isEmpty
                              ? "Select Model Vehicle"
                              : logic.bannerModel.value,
                          readOnly: true,
                          onTap: () async {
                            var result = await Get.to(
                                LayoutActiveVehicles(bannerModel: "Banner",));
                            if (result != null) {
                              log(result);
                              logic.bannerModel.value = result.toString();
                              // logic.bannerVehicleId.value=result[1].toString();
                              logic.update();
                            }
                          },
                        );
                      },),
                    Text("Banner Images", style: TextStyle(color: Colors.black,
                        fontWeight: FontWeight.w700,
                        fontFamily: "Nunito",
                        fontSize: 22.sp),).marginOnly(top: 25.h, bottom: 5.h),

                    CustomTextField(
                      readOnly: true,
                      onTap: () async {
                        final pickedImage = await FileUtilsWeb
                            .pickMultipleFiles(FileType.image);
                        if (pickedImage != null) {
                          setState(() {
                            _pickedImageData = pickedImage;
                          });
                        }
                      },
                      padding: EdgeInsets.only(top: 20.h, left: 20.w),
                      hint: "No File Chosen",
                      controller: bannerImageController,
                      prefix: Container(
                        padding: EdgeInsets.all(5),
                        margin: EdgeInsets.only(top: 10.h, left: 10.w, right: 5
                            .w),
                        decoration: BoxDecoration(
                          color: Color(0xFf767676).withOpacity(.76),
                          border: Border.all(
                              color: Color(0xFF767676).withOpacity(.76)),
                        ),
                        child: Text("Choose File", style: TextStyle(
                            color: Colors.black,
                            fontFamily: "Nunito",
                            fontWeight: FontWeight.w500,
                            fontSize: 22.sp),),
                      ),
                    ),
                    if(_pickedImageData != null)
                      SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          mainAxisSize: MainAxisSize.max,
                          children: List.generate(_pickedImageData!.length, (
                              index) {
                            return Container(
                              height: 200.h,
                              width: 150.w,
                              margin: EdgeInsets.symmetric(
                                  horizontal: 20.w, vertical: 10.h),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5),
                                color: Colors
                                    .grey[200], // Placeholder background color
                              ),
                              child: Image.memory(
                                _pickedImageData![index],
                                // Display image based on index
                                fit: BoxFit.cover, // Image fitting options
                              ),
                            );
                          }),
                        ),
                      ),
                    Obx(() {
                      return CustomButton(
                          loading: controller.BannerLoding.value,
                          title: widget.status, onPressed: () async {
                        String des = bannerDescriptionController.text;
                        if (controller.bannerVehicleId.value.isEmpty || des.isEmpty || _pickedImageData == null) {
                          Get.snackbar(
                              "Alert", "Required All Fileds given below",
                              backgroundColor: Colors.red,
                              colorText: Colors.white);
                        }
                        else {
                          await controller.AddPromotionalBanner(
                              controller.bannerVehicleId.value, des,
                              _pickedImageData!);
                        }
                      });
                    })
                        .marginSymmetric(vertical: 30.h)
                  ],).marginSymmetric(horizontal: 15.w)
              ],),
          )
        ],
      ).marginSymmetric(horizontal: 30.w, vertical: 20.h),
    );
  }
}
