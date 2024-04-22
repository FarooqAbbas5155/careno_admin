import 'dart:developer';

import 'package:careno_admin/constant/helpers.dart';
import 'package:careno_admin/models/booking.dart';
import 'package:careno_admin/models/user.dart';
import 'package:careno_admin/view/layouts/layout_completed_booking.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../constant/colors.dart';
import '../../widgets/custom_button.dart';
import '../screens/screen_vehicle_booked_details.dart';
import 'layout_active_booking.dart';

class LayoutCustomerBooking extends StatelessWidget {
 User user;
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
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
         TabBar(
             unselectedLabelColor: Colors.black,
             labelColor: AppColors.appPrimaryColor,
             tabs: [
           Tab(text: "Active Booking",),
           Tab(text: "Completed Booking",),
         ]),
              Expanded(child: StreamBuilder<QuerySnapshot>(
                stream: bookingsRef.snapshots(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState==ConnectionState.waiting) {
                    return Center(child: CircularProgressIndicator.adaptive(backgroundColor: AppColors.appPrimaryColor,),);

                  }
                  var bookings=snapshot.data!.docs.map((e) => Booking.fromMap(e.data() as Map<String,dynamic>)).toList();
                  log("main${bookings.first.userId.toString()}");
                  log("main${bookings.first.hostId.toString()}");
                  log("main${user.uid.toString()}")
;                  if (user.userType=="host") {
                    bookings=bookings.where((element) => element.hostId==user.uid).toList();
                    log(bookings.toString());
                  }
                  if (user.userType=="user") {
                    bookings=bookings.where((element) => element.userId==user.uid).toList();
                    log(bookings.toString());

                  }
                  return TabBarView(
                    children: [
                      LayoutActiveBooking(activeBooking: bookings,),
                      LayoutCompletedBooking(completedBooking: bookings,),
                    ],
                  );
                }
              )),
            ],
          ),
        ),
      ),
    );
  }

 LayoutCustomerBooking({
    required this.user,
  });
}
