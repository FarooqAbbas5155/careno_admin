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
  const ScreenAddCategories({Key? key}) : super(key: key);

  @override
  State<ScreenAddCategories> createState() => _ScreenAddCategoriesState();
}

class _ScreenAddCategoriesState extends State<ScreenAddCategories> {
  PickedImageData? _pickedImageData;
TextEditingController categoryText = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            CustomTextField(
              controller: categoryText,
              hint: "Enter Category Name",
            ),
            SizedBox(height: 40.h,),
            GestureDetector(
              onTap: () async{
                final pickedImage = await FileUtilsWeb.pickImage(FileType.image);
                if (pickedImage != null) {
                  setState(() {
                    _pickedImageData = pickedImage;
                  });
                }              },
              child: _pickedImageData != null
                  ? Container(
                margin: EdgeInsets.symmetric(vertical: 40),
                height: 80,
                width: 80,
                child: Image.memory(_pickedImageData!.data),
              )
                  : Text("Pick image",style: TextStyle(color: AppColors.appPrimaryColor,fontSize: 22.sp),),
            ).marginSymmetric(vertical: 20.h),
            CustomButton(title: "Submit", onPressed: ()async{
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
            })
          ],
        ),
      ),
    );
  }
}
