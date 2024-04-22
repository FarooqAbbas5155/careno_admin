import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../constant/colors.dart';
import '../../constant/helpers.dart';
import '../../models/add_host_vehicle.dart';
import '../../models/booking.dart';
import '../../widgets/custom_button.dart';
import '../screens/screen_vehicle_booked_details.dart';

class LayoutCompletedBooking extends StatelessWidget {
List<Booking> completedBooking;
Rx<AddHostVehicle?> vehicle = Rx<AddHostVehicle?>(null);

  @override
  Widget build(BuildContext context) {
    completedBooking=completedBooking.where((element) => element.bookingStatus=="Completed").toList();
    return completedBooking.isNotEmpty? Container(
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
                            "Status",
                            style: TextStyle(color: Colors.white),
                          ).paddingSymmetric(horizontal: 20.w)),

                      DataColumn(
                          label: Text(
                            "Action",
                            style: TextStyle(color: Colors.white),
                          ).paddingSymmetric(horizontal: 20.w)),
                    ],
                    rows: List.generate(completedBooking.length, (index) {
                      var booking = completedBooking[index];
                      return DataRow(cells: [
                        DataCell(
                          StreamBuilder<DocumentSnapshot>(
                              stream: addVehicleRef
                                  .doc(booking.vehicleId)
                                  .snapshots(),
                              builder: (BuildContext context, snapshot) {
                                if (snapshot.connectionState ==
                                    ConnectionState.waiting) {
                                  return Center(
                                    child: CircularProgressIndicator(),
                                  );
                                }
                                vehicle.value = AddHostVehicle.fromMap(
                                    snapshot.data!.data()
                                    as Map<String, dynamic>);
                                return Obx(() {
                                  return (vehicle.value==null)?Text("Loading"):CircleAvatar(
                                      radius: 45.r,
                                      backgroundImage:
                                      NetworkImage(
                                          vehicle.value!.vehicleImageComplete));
                                })
                                    .paddingSymmetric(horizontal: 20.w);
                              }),
                        ),
                        DataCell((vehicle.value==null)?Text("Loading"):Text(vehicle.value!.vehicleModel)
                            .paddingSymmetric(horizontal: 20.w)),
                        DataCell((vehicle.value==null)?Text("Loading"):Text(
                            vehicle.value!.address)
                            .paddingSymmetric(horizontal: 20.w)),
                        DataCell(
                            Text(booking.bookingType).paddingSymmetric(horizontal: 20.w)),
                        DataCell(
                            Text("\$ ${booking.price}").paddingSymmetric(horizontal: 20.w)),
                        DataCell(
                            Text(booking.bookingStatus).paddingSymmetric(horizontal: 20.w)),
                        DataCell(
                          (vehicle.value==null)?Text("Loading"):CustomButton(
                            title: "View",
                            onPressed: () {
                              Get.to(ScreenVehicleBookedDetails(booking: booking, vehicle: vehicle.value!,));
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
    ):Center(child: Text("No Completed Booking yet",style: TextStyle(color: AppColors.appPrimaryColor,fontFamily: "Nunito",fontSize: 20.sp),),);
  }

LayoutCompletedBooking({
    required this.completedBooking,
  });
}
