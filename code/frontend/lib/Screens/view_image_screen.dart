import 'dart:io';
import 'dart:typed_data';

import 'package:demo/Controllers/home_controller.dart';
import 'package:demo/Routes/routes.dart';
import 'package:demo/Utils/constant_widgets.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sizer/sizer.dart';
import '../Utils/app_colors.dart';
import '../main.dart';

class ViewImageScreen extends StatelessWidget {
  ViewImageScreen({Key? key}) : super(key: key);
  final HomeController homeController = Get.find();
  final ImageSource source = Get.arguments;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar(
        isShowBackIcon: true,
        isShowMenuIcon: false,
        title: 'Image',
      ),
      body: SizedBox(
        height: 100.h,
        width: 100.w,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Obx(
              // ignore: unrelated_type_equality_checks
              () => homeController.selectedImageBytes!.value == ''
                  ? Image.asset(
                      'assets/images/placeholder.png',
                      height: isDesktop(context) ? 30.w : 50.h,
                      width: isDesktop(context) ? 30.w : 80.w,
                    )
                  : Image.memory(
                      homeController.selectedImageBytes!.value!,
                      height: isDesktop(context) ? 30.w : 50.h,
                      width: isDesktop(context) ? 30.w : 80.w,
                    ),
            ),
            // Container(
            //   height: 200,
            //   width: 200,
            //   color: Colors.blue,
            // ),
            SizedBox(height: 5.h),
            GestureDetector(
              onTap: () {
                if (homeController.selectedImageBytes!.value != null) {
                  Get.toNamed(Routes.ADD_DETAILS_SCREEN);
                }
              },
              child: Container(
                padding: EdgeInsets.symmetric(
                    horizontal: isDesktop(context) ? 20 : 5.w, vertical: 1.5.h),
                decoration: BoxDecoration(
                  border: Border.all(
                    color: AppColor.greyColor,
                    width: 2,
                  ),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Text(
                  'CHOOSE PHOTO',
                  style: GoogleFonts.poppins(
                    fontSize: isDesktop(context) ? 20 : 14.sp,
                    color: AppColor.textBlackColor,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ),
            SizedBox(height: 2.h),
            GestureDetector(
              onTap: () async {
                await homeController.getImage(source: source);
                if (homeController.selectedImageBytes!.value != null) {}
              },
              child: Container(
                padding: EdgeInsets.symmetric(
                    horizontal: isDesktop(context) ? 20 : 5.w, vertical: 1.5.h),
                decoration: BoxDecoration(
                  border: Border.all(
                    color: AppColor.greyColor,
                    width: 2,
                  ),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Text(
                  'PICK ANOTHER',
                  style: GoogleFonts.poppins(
                    fontSize: isDesktop(context) ? 20 : 14.sp,
                    color: AppColor.textBlackColor,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
