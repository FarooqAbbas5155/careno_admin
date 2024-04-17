import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../constant/colors.dart';
import '../../widgets/custom_button.dart';
import '../screens/screen_vehicle_booked_details.dart';

class LayoutCustomerBooking extends StatelessWidget {
  const LayoutCustomerBooking({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 30.w),
        color: AppColors.backGroundColor,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Booked Vehicles",
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
                                      "Make & Model",
                                      style: TextStyle(color: Colors.white),
                                    ).paddingSymmetric(horizontal: 20.w)),
                                DataColumn(
                                    label: Text(
                                      "Vehicle Location",
                                      style: TextStyle(color: Colors.white),
                                    ).paddingSymmetric(horizontal: 20.w)),
                                DataColumn(
                                    label: Text(
                                      "Booking Type",
                                      style: TextStyle(color: Colors.white),
                                    ).paddingSymmetric(horizontal: 20.w)),
                                DataColumn(
                                    label: Text(
                                      "Rent",
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
                                        backgroundImage: AssetImage(
                                            "assets/images/car.png"))
                                        .paddingSymmetric(horizontal: 20.w),
                                  ),
                                  DataCell(Text("Tesla Model 3")
                                      .paddingSymmetric(horizontal: 20.w)),
                                  DataCell(Text("Street 2, House No, City, New York, United State")
                                      .paddingSymmetric(horizontal: 20.w)),
                                  DataCell(Text("Per day")
                                      .paddingSymmetric(horizontal: 20.w)),
                                  DataCell(Text("\$ 15")
                                      .paddingSymmetric(horizontal: 20.w)),
                                  DataCell(
                                    CustomButton(
                                      title: "View",
                                      onPressed: () {
                                        Get.to(ScreenVehicleBookedDetails());

                                      },
                                      height: 41.h,
                                      width: 100.w,
                                      textStyle: TextStyle(
                                          color: Colors.white,
                                          fontSize: 18.sp,
                                          fontWeight: FontWeight.w500),
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
      ),
    );
  }
}
