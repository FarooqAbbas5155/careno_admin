import 'package:careno_admin/constant/helpers.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../constant/colors.dart';
import '../../models/add_host_vehicle.dart';
import '../../models/booking.dart';
import '../../widgets/custom_button.dart';
import '../screens/screen_vehicle_booked_details.dart';

class LayoutActiveBooking extends StatelessWidget {
  List<Booking> activeBooking;
  Rx<AddHostVehicle?> vehicle = Rx<AddHostVehicle?>(null);

  @override
  Widget build(BuildContext context) {
    activeBooking = activeBooking
        .where((element) => element.bookingStatus == "Request Pending")
        .toList();
    return Container(
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
                          color:
                              Colors.grey), // Border for the entire DataTable
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
                    rows: List.generate(activeBooking.length, (index) {
                      var booking = activeBooking[index];
                      return DataRow(cells: [
                        DataCell(
                          FutureBuilder<DocumentSnapshot>(
                              future:
                                  addVehicleRef.doc(booking.vehicleId).get(),
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
                                return (vehicle.value == null)
                                    ? Text("Loading")
                                    : CircleAvatar(
                                            radius: 45.r,
                                            backgroundImage: NetworkImage(
                                                vehicle.value!
                                                    .vehicleImageComplete))
                                        .paddingSymmetric(horizontal: 20.w);
                              }),
                        ),
                        DataCell(FutureBuilder<DocumentSnapshot>(
                          future: addVehicleRef.doc(booking.vehicleId).get(),
                          builder: (BuildContext context,
                              AsyncSnapshot<DocumentSnapshot> snapshot) {
                            if (snapshot.connectionState ==
                                ConnectionState.waiting) {
                              return Text("Loading");
                            }
                            AddHostVehicle? vehicleData =
                                AddHostVehicle.fromMap(snapshot.data!.data()
                                    as Map<String, dynamic>);
                            return Text(vehicleData!.vehicleModel)
                                .paddingSymmetric(horizontal: 20.w);
                          },
                        ).paddingSymmetric(horizontal: 20.w)),
                        DataCell(FutureBuilder<DocumentSnapshot>(
                          future: addVehicleRef.doc(booking.vehicleId).get(),
                          builder: (BuildContext context,
                              AsyncSnapshot<DocumentSnapshot> snapshot) {
                            if (snapshot.connectionState ==
                                ConnectionState.waiting) {
                              return Text("Loading");
                            }
                            AddHostVehicle? vehicleData =
                                AddHostVehicle.fromMap(snapshot.data!.data()
                                    as Map<String, dynamic>);
                            return Text(vehicleData!.address)
                                .paddingSymmetric(horizontal: 20.w);
                          },
                        ).paddingSymmetric(horizontal: 20.w)),
                        DataCell(Text(booking.bookingType)
                            .paddingSymmetric(horizontal: 20.w)),
                        DataCell(Text("\$ ${booking.price}")
                            .paddingSymmetric(horizontal: 20.w)),
                        DataCell(Text(booking.bookingStatus)
                            .paddingSymmetric(horizontal: 20.w)),
                        DataCell(
                          FutureBuilder<DocumentSnapshot>(
                            future: addVehicleRef.doc(booking.vehicleId).get(),
                            builder: (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
                              if (snapshot.connectionState == ConnectionState.waiting) {
                                return Text("Loading");
                              }
                              AddHostVehicle? vehicleData = AddHostVehicle.fromMap(snapshot.data!.data()
                              as Map<String, dynamic>);
                              return CustomButton(
                                title: "View",
                                onPressed: () {
                                  Get.to(ScreenVehicleBookedDetails(
                                    booking: booking,
                                    vehicle: vehicle.value!,
                                  ));
                                },
                                height: 41.h,
                                width: 100.w,
                                textStyle: TextStyle(
                                    color: Colors.white,
                                    fontSize: 18.sp,
                                    fontWeight: FontWeight.w500),
                              );
                            },
                          ),)

                        // DataCell(Text("Test")),
                      ]);
                    })),
              ],
            ),
          ),
        ),
      ),
    );
  }

  LayoutActiveBooking({
    required this.activeBooking,
  });
}
