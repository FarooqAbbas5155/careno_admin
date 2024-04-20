import 'package:careno_admin/constant/CustomDialog.dart';
import 'package:careno_admin/constant/colors.dart';
import 'package:careno_admin/constant/helpers.dart';
import 'package:careno_admin/view/screens/screen_add_categories.dart';
import 'package:careno_admin/widgets/custom_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../controllers/home_controller.dart';

class LayoutCategoriesList extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    HomeController controller = Get.put(HomeController());
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 30.w),
      color: AppColors.backGroundColor,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Category",
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
              alignment: Alignment.centerLeft,
              child: TextButton.icon(
                style: ButtonStyle(
                  backgroundColor: MaterialStateColor.resolveWith((states) => AppColors.appPrimaryColor),
                ),

                icon: Text("Add Category",
                    style: TextStyle(color: Colors.white, fontSize: 20.sp,fontWeight: FontWeight.w700,fontFamily: "Nunito")),
                onPressed: () {
                  Get.to(ScreenAddCategories(status: 'Submit',));
                },
                label: Icon(Icons.add,color: Colors.white,),
              ),
            ),
          ),
      controller.categories.value.isNotEmpty? Expanded(
            child: Container(
              padding: EdgeInsets.symmetric(vertical: 15.h, horizontal: 20.w),
              margin: EdgeInsets.symmetric(vertical: 15.h,),
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
                                    "Category Image",
                                    style: TextStyle(color: Colors.white),
                                  ).paddingSymmetric(horizontal: 20.w)),
                                DataColumn(
                                  label: Text(
                                    "Category Name",
                                    style: TextStyle(color: Colors.white),
                                  ).paddingSymmetric(horizontal: 40.w)),
                                DataColumn(
                                  label: Text(
                                    "Edit",
                                    style: TextStyle(color: Colors.white),
                                  ).paddingSymmetric(horizontal: 20.w)),
                                DataColumn(
                                  label: Text(
                                    "Delete",
                                    style: TextStyle(color: Colors.white),
                                  ).paddingSymmetric(horizontal: 20.w)),
                              ],
                              rows: List.generate(controller.categories.value.length, (index) {
                                var category = controller.categories.value[index];
                                return DataRow(cells: [
                                  DataCell(
                                    CircleAvatar(
                                        radius: 45.r,
                                        backgroundImage:NetworkImage(category.image),
                                            // AssetImage("assets/images/car.png")
                                    ).paddingSymmetric(horizontal: 20.w),
                                  ),
                                  DataCell(Text(category.name).paddingSymmetric(horizontal: 40.w)),
                                  DataCell(
                                      CustomButton(
                                    title: "Edit",
                                    onPressed: () {
                                      Get.to(ScreenAddCategories(status: "Update", category: category,));
                                    },
                                    height: 38.h,
                                    width: 90.w,
                                    textStyle: TextStyle(
                                        color: Colors.white,
                                        fontSize: 18.sp,
                                        fontWeight: FontWeight.w500),
                                  ).paddingSymmetric(horizontal: 20.w)),
                                  DataCell(CustomButton(
                                    title: "Delete",
                                    color: Color(0xFFF90C24),
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
                                                Text("Are you sure you want to delete this category?",style: TextStyle(
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
                                                      onPressed: (){
                                                        categoryRef.doc(category.id).delete().then((value) {
                                                          Get.snackbar("Successfully", "Delete Category => ${category.name}",backgroundColor: AppColors.appPrimaryColor,colorText: Colors.white);

                                                          Get.back();
                                                        });
                                                      }, child: Text("Ok",style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 18.sp,
                                                    fontWeight: FontWeight.w500
                                                  ),)).marginOnly(right: 20.w
                                                  ),

                                                  OutlinedButton(onPressed: (){
                                                    Get.back();
                                                  }, child: Text("Cancel")),
                                                ]
                                              ),
                                            ],
                                            ),
                                          ), 10.0.r);
                                    },
                                    height: 38.h,
                                    width: 90.w,
                                    textStyle: TextStyle(
                                        color: Colors.white,
                                        fontSize: 18.sp,
                                        fontWeight: FontWeight.w500),
                                  ).paddingSymmetric(horizontal: 20.w)),

                                  // DataCell(Text("Test")),
                                ]);
                              })),

                      ],
                    ),
                  ),
                ),
              ),
            ),
          ):    Center(
          child: Text("No Category Found yet",style: TextStyle(fontSize: 20.sp,fontWeight: FontWeight.w600,fontFamily: "Nunito"),)
      )
        ],
      ),
    );
  }

  //row data

  List<String> headingTextCarers = [
    "Category Image",
    "Category Name",
    "Edit",
    "Delete"
  ];
}
