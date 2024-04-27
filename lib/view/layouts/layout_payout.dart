import 'package:careno_admin/controllers/payment_controller.dart';
import 'package:careno_admin/view/screens/screen_provider_details.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../constant/colors.dart';
import 'package:get/get.dart';

import '../../constant/helpers.dart';
import '../../widgets/custom_button.dart';

class LayoutPayout extends StatelessWidget {
PaymentController controller = Get.put(PaymentController());
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 30.w),
      color: AppColors.backGroundColor,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Payment Request",
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
                                    "Payment",
                                    style: TextStyle(color: Colors.white),
                                  ).paddingSymmetric(horizontal: 20.w)),

                              DataColumn(
                                  label: Text(
                                    "Details",
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
                                    backgroundImage: NetworkImage(image_url),// AssetImage(
                                    //     "assets/images/car.png")
                                  )
                                      .paddingSymmetric(horizontal: 20.w),
                                ),
                                DataCell(Text("Leon")
                                    .paddingSymmetric(horizontal: 20.w)),
                                DataCell(Text("+18778787")
                                    .paddingSymmetric(horizontal: 20.w)),
                                DataCell(Text("eon@gmail.com")
                                    .paddingSymmetric(horizontal: 20.w)),
                                DataCell(
                                Text("70\$")
                                ),
                                DataCell(
                                  CustomButton(
                                    width: 130.w,
                                    height: 45.h,
                                    title: 'View', onPressed: () {
                                      // Get.to(ScreenProviderDetails(host: ));
                                  },).paddingSymmetric(horizontal: 20.w),

                                ),
                                // DataCell(Text("Test")),
                                DataCell(Row(
                                  children: [
                                    CustomButton(
                                      width: 130.w,
                                      height: 45.h,
                                      title: 'Approve', onPressed: () async {
                                      String hostAccountId = "acct_1NqD7LHjefWyyt1Q";
                                      int amountInCents = 50; // Example: $50.00 (5000 cents)

                                      await controller.createTransferToTestAccount(hostAccountId, amountInCents);

                                    },).paddingSymmetric(horizontal: 20.w),
                                    CustomButton(
                                      width: 130.w,
                                      height: 45.h,
                                      title: 'Cancel', onPressed: () {
                                    },).paddingSymmetric(horizontal: 20.w),
                                  ],
                                )),
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
