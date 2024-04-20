import 'package:careno_admin/view/screens/screen_add_ads_banner.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../constant/CustomDialog.dart';
import '../../constant/colors.dart';
import '../../widgets/custom_button.dart';

class LayoutPromotionalBanner extends StatelessWidget {
  const LayoutPromotionalBanner({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 30.w),
      color: AppColors.backGroundColor,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Promotional Banner",
            style: AppColors.headingStyle,
          ).marginSymmetric(vertical: 10.h),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 15.h),
            width: Get.width,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(5.r),
            ),
            child:

            Align(
              alignment: Alignment.topLeft,
              child: TextButton.icon(
                style: ButtonStyle(
                  backgroundColor: MaterialStateColor.resolveWith((states) => AppColors.appPrimaryColor),
                ),

                icon: Text("Add New Banner",
                    style: TextStyle(color: Colors.white, fontSize: 20.sp,fontWeight: FontWeight.w700,fontFamily: "Nunito")),
                onPressed: () {
                  Get.to(ScreenAddAdsBanner(status: 'Submit',));
                },
                label: Icon(Icons.add,color: Colors.white,),
              ),
            ),
          ),
          Expanded(
            child: Container(
              padding: EdgeInsets.symmetric(vertical: 15.h, horizontal: 20.w),
              margin: EdgeInsets.symmetric(vertical: 15.h,),
              decoration: BoxDecoration(
                color: Colors.white,
              ),
              child: Align(
                alignment: Alignment.centerLeft,
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: SingleChildScrollView(
                    scrollDirection: Axis.vertical,
                    child: Column(
                      children: [
                        DataTable(
                            columnSpacing: 40.h,
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.grey), // Border for the entire DataTable
                            ),
                            headingRowHeight: 60.h,
                            // horizontalMargin: 100.w,
                            dataRowHeight: 120.h,
                            headingRowColor: MaterialStateProperty.resolveWith(
                                    (states) => AppColors.appPrimaryColor),
                            columns: [
                              DataColumn(
                                  label: Text(
                                    "Image",
                                    style: TextStyle(color: Colors.white),
                                  ).paddingSymmetric(horizontal: 20.w)),
                              DataColumn(
                                  label: Text(
                                    "Banner URL",
                                    style: TextStyle(color: Colors.white),
                                  ).paddingSymmetric(horizontal: 40.w)),
                              DataColumn(
                                  label: Text(
                                    "Status",
                                    style: TextStyle(color: Colors.white),
                                  ).paddingSymmetric(horizontal: 20.w)),
                              DataColumn(
                                  label: Text(
                                    "Action",
                                    style: TextStyle(color: Colors.white),
                                  ).paddingSymmetric(horizontal: 20.w)),
                            ],
                            rows: List.generate(20, (index) {
                              return DataRow(cells: [
                                DataCell(
                                  CircleAvatar(
                                      radius: 45.r,
                                      backgroundImage:
                                      AssetImage("assets/images/car.png")).paddingSymmetric(horizontal: 20.w),
                                ),
                                DataCell(Text("https//:dfhgdiufyikrhwiouasrwabniku").paddingSymmetric(horizontal: 40.w)),
                                DataCell(Text("Expired").paddingSymmetric(horizontal: 40.w)),
                                DataCell(
                                  Row(
                                    children: <Widget>[
                                      CustomButton(
                                        title: "Edit",
                                        color: Color(0xFf0F9D58),
                                        height: 41.h,
                                        width: 120.w,
                                        textStyle: TextStyle(
                                            color: Colors.white,
                                            fontSize: 18.sp,
                                            fontWeight: FontWeight.w500),
                                        onPressed: () {
                                          Get.to(ScreenAddAdsBanner(status: "Update"));
                                        },
                                      ).marginOnly(right: 10.w),
                                      CustomButton(
                                        title: "Delete",
                                        color: Color(0xFfEB141B),
                                        height: 41.h,
                                        width: 100.w,
                                        textStyle: TextStyle(
                                            color: Colors.white,
                                            fontSize: 18.sp,
                                            fontWeight: FontWeight.w500),
                                        onPressed: () {
                                          CustomDialog.showCustomDialog(context,
                                              SizedBox(
                                                width: Get.width*.35,
                                                child: Column(
                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                  mainAxisSize: MainAxisSize.min,
                                                  children: <Widget>[
                                                    Text("carenoapp.example.com says",style: TextStyle(
                                                        fontSize: 20.sp,
                                                        fontFamily: "Nunito",
                                                        fontWeight: FontWeight.w500
                                                    ),),
                                                    Text("Are you sure you want to delete this Banner Ad?",style: TextStyle(
                                                        fontSize: 20.sp,
                                                        fontFamily: "Nunito",
                                                        fontWeight: FontWeight.w500
                                                    ),),
                                                    Row(
                                                        mainAxisAlignment: MainAxisAlignment.end,
                                                        children: <Widget>[
                                                          OutlinedButton(
                                                              style: OutlinedButton.styleFrom(
                                                                backgroundColor: AppColors.appPrimaryColor,
                                                              ),
                                                              onPressed: (){}, child: Text("Ok",style: TextStyle(
                                                              color: Colors.white,
                                                              fontSize: 18.sp,
                                                              fontWeight: FontWeight.w500
                                                          ),)).marginOnly(right: 20.w
                                                          ),

                                                          OutlinedButton(onPressed: (){}, child: Text("Cancel")),
                                                        ]
                                                    ),
                                                  ],
                                                ),
                                              ), 10.0.r);

                                        },
                                      ),
                                    ],
                                  ),
                                ),

                                // DataCell(Text("Test")),
                              ]);
                            })),

                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
