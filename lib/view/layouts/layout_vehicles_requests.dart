import 'package:careno_admin/constant/helpers.dart';
import 'package:careno_admin/controllers/home_controller.dart';
import 'package:careno_admin/models/user.dart';
import 'package:careno_admin/view/screens/screen_vehicle_details.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../constant/colors.dart';
import '../../constant/fcm.dart';
import '../../widgets/custom_button.dart';

class LayoutVehiclesRequests extends StatelessWidget {
  HomeController _controller = Get.put(HomeController());
  User? host;

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeController>(
        init: _controller,
        builder: (controller) {
          return Obx(() {
            return Container(
              padding: EdgeInsets.symmetric(horizontal: 30.w),
              color: AppColors.backGroundColor,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Vehicle Requests",
                    style: AppColors.headingStyle,
                  ).marginSymmetric(vertical: 10.h),
                  controller.vehiclesRequest.value.isNotEmpty ? Expanded(
                    child: Container(
                      padding: EdgeInsets.symmetric(
                          vertical: 15.h, horizontal: 20.w),
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
                                    headingRowColor: MaterialStateProperty
                                        .resolveWith(
                                            (states) =>
                                        AppColors.appPrimaryColor),
                                    columns: [
                                      DataColumn(
                                          label: Text(
                                            "Image",
                                            style: TextStyle(
                                                color: Colors.white),
                                          ).paddingSymmetric(horizontal: 20.w)),
                                      DataColumn(
                                          label: Text(
                                            "Make & Model",
                                            style: TextStyle(
                                                color: Colors.white),
                                          ).paddingSymmetric(horizontal: 20.w)),
                                      DataColumn(
                                          label: Text(
                                            "Vehicle Location",
                                            style: TextStyle(
                                                color: Colors.white),
                                          ).paddingSymmetric(horizontal: 20.w)),
                                      DataColumn(
                                          label: Text(
                                            "Rate Per Day",
                                            style: TextStyle(
                                                color: Colors.white),
                                          ).paddingSymmetric(horizontal: 20.w)),
                                      DataColumn(
                                          label: Text(
                                            "Rate Per Hour",
                                            style: TextStyle(
                                                color: Colors.white),
                                          ).paddingSymmetric(horizontal: 20.w)),

                                      DataColumn(
                                          label: Text(
                                            "Action",
                                            style: TextStyle(
                                                color: Colors.white),
                                          ).paddingSymmetric(horizontal: 20.w)),
                                    ],
                                    rows: List.generate(
                                        controller.vehiclesRequest.value
                                            .length, (index) {
                                      var vehicle = controller.vehiclesRequest
                                          .value[index];
                                      return DataRow(cells: [
                                        DataCell(
                                          CircleAvatar(
                                              radius: 45.r,
                                              backgroundImage: NetworkImage(
                                                  vehicle.vehicleImageComplete)
                                            // AssetImage("assets/images/car.png")
                                          )
                                              .paddingSymmetric(
                                              horizontal: 20.w),
                                        ),
                                        DataCell(Text(vehicle.vehicleModel)
                                            .paddingSymmetric(
                                            horizontal: 20.w)),
                                        DataCell(Text(vehicle.address)
                                            .paddingSymmetric(
                                            horizontal: 20.w)),
                                        DataCell(
                                            Text("\$ ${vehicle
                                                .vehiclePerDayRent}")
                                                .paddingSymmetric(
                                                horizontal: 20.w)),
                                        DataCell(
                                            Text("\$ ${vehicle
                                                .vehiclePerHourRent}")
                                                .paddingSymmetric(
                                                horizontal: 20.w)),
                                        DataCell(
                                          Row(
                                            children: <Widget>[
                                              CustomButton(
                                                title: "View",
                                                onPressed: () {
                                                  Get.to(ScreenVehicleDetails(
                                                    status: 'Pending',
                                                    vehicle: vehicle,));
                                                },
                                                height: 41.h,
                                                width: 100.w,
                                                textStyle: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 18.sp,
                                                    fontWeight: FontWeight
                                                        .w500),
                                              ),
                                              FutureBuilder<User>(
                                                  future: getUser(
                                                      vehicle!.hostId),
                                                  builder: (context, snapshot) {
                                                    if (snapshot
                                                        .connectionState ==
                                                        ConnectionState
                                                            .waiting) {
                                                      return Center(
                                                        child: CircularProgressIndicator
                                                            .adaptive(
                                                          backgroundColor: Colors
                                                              .green,),);
                                                    }
                                                    host = snapshot.data!;
                                                    return CustomButton(
                                                      title: "Approve",
                                                      color: Color(0xFf0F9D58),

                                                      height: 41.h,
                                                      width: 120.w,
                                                      textStyle: TextStyle(
                                                          color: Colors.white,
                                                          fontSize: 18.sp,
                                                          fontWeight: FontWeight
                                                              .w500),
                                                      onPressed: () async {
                                                        await addVehicleRef.doc(
                                                            vehicle.vehicleId)
                                                            .update({
                                                          "isVerified": true,
                                                          "status": "Active"
                                                        })
                                                            .then((value) async{
                                                              if (host!.notification == true) {
                                                                await FCM.sendMessageSingle(
                                                                    "Congrutulation",
                                                                    "${vehicle!
                                                                        .vehicleModel} is Approved",
                                                                    host!
                                                                        .notificationToken
                                                                        .toString(),
                                                                    {});


                                                              }
                                                          Get.snackbar("Alert",
                                                              "Successfully Aproved vehicel",
                                                              backgroundColor: Colors
                                                                  .red,
                                                              colorText: Colors
                                                                  .white);
                                                        });
                                                      },

                                                    ).marginSymmetric(
                                                        horizontal: 10.w);
                                                  }
                                              ),
                                              CustomButton(
                                                title: "Decline",
                                                color: Color(0xFfEB141B),

                                                height: 41.h,
                                                width: 100.w,
                                                textStyle: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 18.sp,
                                                    fontWeight: FontWeight
                                                        .w500),
                                                onPressed: () async {
                                                  await addVehicleRef.doc(
                                                      vehicle.vehicleId).update(
                                                      {
                                                        "isVerified": false,
                                                        "status": "Reject"
                                                      }).then((value) {
                                                    FCM.sendMessageSingle(
                                                        "Congrutulation",
                                                        "${vehicle!
                                                            .vehicleModel} is Rejected",
                                                        host!.notificationToken
                                                            .toString(),
                                                        {});
                                                    Get.snackbar("Alert",
                                                        "Your Vehicle Request Reject",
                                                        backgroundColor: Colors
                                                            .red,
                                                        colorText: Colors
                                                            .white);
                                                  });
                                                },

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
                  ) : Center(
                      child: Text(
                          "No Vehicle Request Found yet", style: TextStyle(
                          fontSize: 20.sp,
                          fontWeight: FontWeight.w800,
                          fontFamily: "Nunito")

                      ))
                ],
              ),
            );
          });
        });
  }
}
