import 'package:careno_admin/constant/colors.dart';
import 'package:careno_admin/constant/helpers.dart';
import 'package:careno_admin/constant/web_utils.dart';
import 'package:careno_admin/widgets/custom_button.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../models/categories.dart';
import '../../widgets/custom_textfiled.dart';

class ScreenAddCategories extends StatefulWidget {
 String status;
  @override
  State<ScreenAddCategories> createState() => _ScreenAddCategoriesState();

 ScreenAddCategories({
    required this.status,
  });
}

class _ScreenAddCategoriesState extends State<ScreenAddCategories> {
  PickedImageData? _pickedImageData;
TextEditingController categoryText = TextEditingController();
TextEditingController categoryImage = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        backgroundColor: AppColors.backGroundColor,
        elevation: 0,
        title: Text("Category",style: AppColors.headingStyle)
      ),
      backgroundColor: AppColors.backGroundColor,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [

         Container(
           width: Get.width*.5,
           decoration: BoxDecoration(
           borderRadius: BorderRadius.circular(5.r),
           color: Colors.white
         ),
         child: Column(
           crossAxisAlignment: CrossAxisAlignment.start,
           children: [
           Container(
             padding: EdgeInsets.symmetric(horizontal: 20.w,vertical: 15.h),
             width: Get.width,
             decoration: BoxDecoration(
               color: AppColors.appPrimaryColor,
               borderRadius: BorderRadius.circular(5.r),
             ),

             child: Align(
                 alignment: Alignment.centerLeft,
                 child: Text("Add New Category",style: AppColors.headingStyle.copyWith(color: Colors.white,fontWeight: FontWeight.w700,fontSize: 24.sp),)),
           ),
           Column(
             crossAxisAlignment: CrossAxisAlignment.start,
             children: [
             Text("Category Title",style: TextStyle(color: Colors.black,fontWeight: FontWeight.w700,fontFamily: "Nunito",fontSize: 22.sp),).marginOnly(top: 25.h,bottom: 5.h),
             CustomTextField(
               controller: categoryText,
               hint: "Enter Category Name",
             ),
             Text("Category Image",style: TextStyle(color: Colors.black,fontWeight: FontWeight.w700,fontFamily: "Nunito",fontSize: 22.sp),).marginOnly(top: 25.h,bottom: 5.h),

               CustomTextField(
                 readOnly: true,
                 onTap: () async {
                   final pickedImage = await FileUtilsWeb.pickImage(FileType.image);
                   if (pickedImage != null) {
                     setState(() {
                       _pickedImageData = pickedImage;
                       categoryImage.text=_pickedImageData!.name;
                     });
                   }
                 },
                 padding: EdgeInsets.only(top: 20.h,left: 20.w),
                 hint: "No File Chosen",
                 controller: categoryImage,
                 prefix: Container(
                   padding: EdgeInsets.all(5),
                   margin: EdgeInsets.only(top: 10.h,left: 10.w,right: 5.w),
                   decoration: BoxDecoration(
                     color: Color(0xFf767676).withOpacity(.76),
                     border: Border.all(color: Color(0xFF767676).withOpacity(.76)),
                   ),
                   child: Text("Choose File",style: TextStyle(color: Colors.black,fontFamily: "Nunito",fontWeight: FontWeight.w500,fontSize: 22.sp),),
                 ),
               ),
               if(_pickedImageData!=null)Container(
                 decoration: BoxDecoration(
                   borderRadius: BorderRadius.circular(5.r),
                   color: Colors.white
                 ),
                 margin: EdgeInsets.symmetric(vertical: 20.h),
                 padding: EdgeInsets.all( 10.h),
                 height: 150,
                 width: 150,
                 child: Image.memory(_pickedImageData!.data),
               ),
             CustomButton(title: widget.status, onPressed: ()async{
               String name = categoryText.text;
               int id = DateTime.now().millisecondsSinceEpoch;
               String  imageUrl = await FileUtilsWeb.uploadSingleImageToFirebase(_pickedImageData!.data, "catgories/images/${id.toString()}");

               Category category = Category(
                   id: id.toString(), name: name,image: imageUrl);
               await categoryRef.doc(id.toString()).set(category.toMap()).then((value) {
                 Get.snackbar("Category", "Add category ${category.toString()}",backgroundColor: AppColors.appPrimaryColor,colorText: Colors.white);
                 categoryText.clear();
               }).catchError((onError){
                 print(onError.toString());});
             }).marginSymmetric(vertical: 30.h)
           ],).marginSymmetric(horizontal: 15.w)
         ],),
         )
        ],
      ).marginSymmetric(horizontal: 30.w,vertical: 20.h),
    );
  }
}
