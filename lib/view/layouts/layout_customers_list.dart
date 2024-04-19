import 'package:careno_admin/constant/helpers.dart';
import 'package:careno_admin/widgets/custom_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../constant/CustomDialog.dart';
import '../../constant/colors.dart';
import '../../controllers/home_controller.dart';
import '../screens/screen_chat.dart';
import '../screens/screen_user_details.dart';

class LayoutCustomersList extends StatelessWidget {
  HomeController controller = Get.put(HomeController());

  List<String> list=["Block User"];
  @override
  Widget build(BuildContext context) {
    return controller.user.value.isNotEmpty? Container(
      padding: EdgeInsets.symmetric(horizontal: 30.w),
      color: AppColors.backGroundColor,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Customers List",
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
                                "Gender",
                                style: TextStyle(color: Colors.white),
                              ).paddingSymmetric(horizontal: 20.w)),

                              DataColumn(
                                  label: Text(
                                "Action",
                                style: TextStyle(color: Colors.white),
                              ).paddingSymmetric(horizontal: 20.w)),
                              DataColumn(
                                  label: Text(
                                    "Details",
                                    style: TextStyle(color: Colors.white),
                                  ).paddingSymmetric(horizontal: 20.w)),

                            ],
                            rows: List.generate(controller.user.value.length, (index) {
                              var user = controller.user.value[index];
                              return DataRow(cells: [
                                DataCell(
                                  CircleAvatar(
                                          radius: 45.r,
                                          backgroundImage:NetworkImage(user.imageUrl.isEmpty?image_url:user.imageUrl)
                                          // AssetImage(
                                          //     "assets/images/car.png")
                                  )
                                      .paddingSymmetric(horizontal: 20.w),
                                ),
                                DataCell(Text(user.name)
                                    .paddingSymmetric(horizontal: 20.w)),
                                DataCell(Text(user.phoneNumber)
                                    .paddingSymmetric(horizontal: 20.w)),
                                DataCell(Text(user.email)
                                    .paddingSymmetric(horizontal: 20.w)),
                                DataCell(Text(user.gender)
                                    .paddingSymmetric(horizontal: 20.w)),


                                DataCell(
                                  PopupMenuButton<String>(
                                    icon: Icon(Icons.more_vert),
                                    color: Colors.white,
                                    // constraints: BoxConstraints(
                                    //   maxHeight: 40.h
                                    // ),
                                    itemBuilder: (BuildContext context) {
                                      return list
                                          .map((choice) {
                                        return PopupMenuItem<String>(
                                          value: choice,
                                          height: 40.h,
                                          padding: EdgeInsets.symmetric(horizontal: 10),
                                          child: Text(
                                            choice,
                                            style: TextStyle(
                                                color: Colors.black,
                                                fontFamily: "Urbanist"),
                                          ),
                                        );
                                      }).toList();
                                    },
                                    onSelected: (String choice) {
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
                                                Text("Are you sure you want to block this Customer account?",style: TextStyle(
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
                                ),
                                DataCell(CustomButton(
                                  width: 130.w,
                                  height: 45.h,
                                  title: 'View', onPressed: () {
                                  Get.to(ScreenUserDetails(userType: 'user', user: user,));
                                },)
                                    .paddingSymmetric(horizontal: 20.w)),
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
    ):
    Center(
      child: Text("No User Found yet",style: TextStyle(fontSize: 20.sp,fontWeight: FontWeight.w600,fontFamily: "Nunito"),));

  }
}
