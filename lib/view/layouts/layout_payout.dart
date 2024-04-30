import 'package:careno_admin/constant/my_helper_by_callofcoding.dart';
import 'package:careno_admin/controllers/payment_controller.dart';
import 'package:careno_admin/models/withdraw_request_model.dart';
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
      child: StreamBuilder(stream: getWithdrawStream(), builder: (context, snapshot) {
        if(snapshot.connectionState == ConnectionState.waiting){
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              CircularProgressIndicator(),
            ],
          );
        }

        if(snapshot.hasData && !snapshot.hasError){

          List<WithdrawRequestModel> withdrawByMpesa = snapshot.data!.docs.map((e) => WithdrawRequestModel.fromMap(e.data())).where((element) => element.paymentMethod == 'M-pesa').toList();
          List<WithdrawRequestModel> withdrawByBank = snapshot.data!.docs.map((e) => WithdrawRequestModel.fromMap(e.data())).where((element) => element.paymentMethod == 'Bank Transfer').toList();

          print('--------$withdrawByBank \n mpesa$withdrawByMpesa');
            return Column(
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
                                rows: withdrawByBank.asMap().entries.map((withdraw) => DataRow(cells: [
                                  DataCell(
                                    CircleAvatar(
                                      radius: 45.r,
                                      backgroundImage: NetworkImage(withdraw.value.profilePic!),// AssetImage(
                                      //     "assets/images/car.png")
                                    )
                                        .paddingSymmetric(horizontal: 20.w),
                                  ),
                                  DataCell(Text("${withdraw.value.hostName}")
                                      .paddingSymmetric(horizontal: 20.w)),
                                  DataCell(Text(withdraw.value.hostPhoneNumber!.isNotEmpty ? "${withdraw.value.hostPhoneNumber}":'N/A')
                                      .paddingSymmetric(horizontal: 20.w)),
                                  DataCell(Text("${withdraw.value.email}")
                                      .paddingSymmetric(horizontal: 20.w)),
                                  DataCell(
                                      Text("${withdraw.value.amount}\$")
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
                                        // String hostAccountId = "acct_1NqD7LHjefWyyt1Q";
                                        // int amountInCents = 50; // Example: $50.00 (5000 cents)
                                        // await controller.createTransferToTestAccount(hostAccountId, amountInCents);

                                        await approvePayment(withdraw.value);


                                      },).paddingSymmetric(horizontal: 20.w),
                                      CustomButton(
                                        width: 130.w,
                                        height: 45.h,
                                        title: 'Cancel', onPressed: () async {
                                          await rejectPayment(withdraw.value);
                                      },).paddingSymmetric(horizontal: 20.w),
                                    ],
                                  )),
                                ])).toList()
                            ),
                            ElevatedButton(onPressed: () async {
                              await sendMoneyFromMpesa();
                            }, child: Text('test api'))
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          );
        }


        if(snapshot.hasError){
          return Expanded(child: Text('Something went wrong.. ${snapshot.error}',style: AppColors.headingStyle,));
        }


        return Container(color: Colors.red,);

      },),
    );
  }
}
