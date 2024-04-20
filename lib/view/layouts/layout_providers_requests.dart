import 'package:careno_admin/constant/helpers.dart';
import 'package:careno_admin/controllers/home_controller.dart';
import 'package:careno_admin/view/screens/screen_provider_details.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../constant/CustomDialog.dart';
import '../../constant/colors.dart';
import '../../widgets/custom_button.dart';
class LayoutProvidersRequests extends StatelessWidget {
HomeController controller = Get.put(HomeController());
  @override
  Widget build(BuildContext context) {
    print(controller.hostRequest.value.length);

    return controller.hostRequest.value.isNotEmpty?Container(
      padding: EdgeInsets.symmetric(horizontal: 30.w),
      color: AppColors.backGroundColor,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Provider Requests",
            style: AppColors.headingStyle,
          ).marginSymmetric(vertical: 10.h),
          Expanded(
            child: Container(
              padding: EdgeInsets.symmetric(vertical: 15.h, horizontal: 20.w),
              margin: EdgeInsets.symmetric(
                vertical: 15.h,
              ),
              decoration: BoxDecoration(
                color: Colors.white,
              ),
              child: Align(
                alignment: Alignment.topLeft,
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: SingleChildScrollView(
                    scrollDirection: Axis.vertical,
                    child: Column(
                      children: [
                        DataTable(
                            columnSpacing: 40.h,
                            decoration: BoxDecoration(
                              border: Border.all(
                                  color: Colors
                                      .grey), // Border for the entire DataTable
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
                                    "Name",
                                    style: TextStyle(color: Colors.white),
                                  ).paddingSymmetric(horizontal: 20.w)),
                              DataColumn(
                                  label: Text(
                                    "Phone",
                                    style: TextStyle(color: Colors.white),
                                  ).paddingSymmetric(horizontal: 20.w)),
                              DataColumn(
                                  label: Text(
                                    "Email",
                                    style: TextStyle(color: Colors.white),
                                  ).paddingSymmetric(horizontal: 20.w)),

                              DataColumn(
                                  label: Text(
                                    "Action",
                                    style: TextStyle(color: Colors.white),
                                  ).paddingSymmetric(horizontal: 20.w)),
                            ],
                            rows: List.generate(controller.hostRequest.value.length, (index) {
                              var host = controller.hostRequest.value[index];
                              return DataRow(cells: [
                                DataCell(
                                  CircleAvatar(
                                      radius: 45.r,
                                      backgroundImage:NetworkImage(host.imageUrl.isEmpty?image_url:host.imageUrl)
                                      // AssetImage(
                                      //     "assets/images/car.png")
                                  )
                                      .paddingSymmetric(horizontal: 20.w),
                                ),
                                DataCell(Text(host.name)
                                    .paddingSymmetric(horizontal: 20.w)),
                                DataCell(Text(host.phoneNumber)
                                    .paddingSymmetric(horizontal: 20.w)),
                                DataCell(Text(host.email)
                                    .paddingSymmetric(horizontal: 20.w)),
                                DataCell(
                                  Row(
                                    children: <Widget>[
                                      CustomButton(
                                        title: "View",
                                        onPressed: () {
                                          Get.to(ScreenProviderDetails(host: host,));

                                        },
                                        height: 41.h,
                                        width: 100.w,
                                        textStyle: TextStyle(
                                            color: Colors.white,
                                            fontSize: 18.sp,
                                            fontWeight: FontWeight.w500),
                                      ),
                                      CustomButton(
                                        title: "Approve",
                                        color:Color(0xFf0F9D58),

                                        height: 41.h,
                                        width: 120.w,
                                        textStyle: TextStyle(
                                            color: Colors.white,
                                            fontSize: 18.sp,
                                            fontWeight: FontWeight.w500), onPressed: () async{
                                        await usersRef.doc(host.uid).update({"isVerified": true}).then((value) {
                                          Get.snackbar("Alert", "Successfully Account Approved",backgroundColor: AppColors.appPrimaryColor,colorText: Colors.white);
                                        });
                                      },

                                      ).marginSymmetric(horizontal: 10.w),
                                      CustomButton(
                                        title: "Decline",
                                        color:Color(0xFfEB141B),

                                        height: 41.h,
                                        width: 100.w,
                                        textStyle: TextStyle(
                                            color: Colors.white,
                                            fontSize: 18.sp,
                                            fontWeight: FontWeight.w500), onPressed: () {  },

                                      ),
                                    ],
                                  ),
                                )

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
    ):Center(
      child: Text("No Request Found yet",style: TextStyle(fontSize: 20.sp,fontWeight: FontWeight.w600,fontFamily: "Nunito"),),
    );
  }
}
