// ignore_for_file: library_private_types_in_public_api, avoid_print

import 'dart:developer';
import 'dart:typed_data';
import 'dart:io';
import 'package:demo/Routes/routes.dart';
import 'package:demo/Screens/view_image_screen.dart';
import 'package:demo/Utils/app_colors.dart';
import 'package:demo/main.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sizer/sizer.dart';
import '../Controllers/home_controller.dart';
import '../Utils/Widgets/permission_handler.dart';
import '../Utils/constant_widgets.dart';

class NewScanScreen extends StatefulWidget {
  NewScanScreen({Key? key}) : super(key: key);

  @override
  State<NewScanScreen> createState() => _NewScanScreenState();
}

class _NewScanScreenState extends State<NewScanScreen> {
  final HomeController homeController = Get.put(HomeController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar(
        isShowBackIcon: true,
        isShowMenuIcon: false,
        title: 'New Scan',
      ),
      body: Column(
        children: [
          // Container(
          //   height: 200,
          //   width: 200,
          //   color: Colors.blue,
          //   child: Obx(
          //     () => homeController.selectedImageBytes != null
          //         ? Image.memory(homeController.selectedImageBytes!.value!)
          //         : const Center(
          //             child: Text("Not Selected"),
          //           ),
          //   ),
          // ),
          const SizedBox(
            height: 50,
          ),
          Center(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 5.w),
              child: isDesktop(context)
                  ? chooseFromGallery(context)
                  : Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        // Choose from gallery
                        chooseFromGallery(context),
                        SizedBox(height: 5.h),
                        // Take new photo
                        GestureDetector(
                          onTap: () async {
                            var res = await PermissionHandlerPermissionService
                                .handleCameraPermission(context);
                            if (res == true) {
                              await homeController.getImage(
                                  source: ImageSource.camera);
                              if (homeController.selectedImageBytes != null) {
                                Get.toNamed(
                                  Routes.IMAGE_VIEW_SCREEN,
                                  arguments: ImageSource.camera,
                                );
                              }
                            }
                          },
                          child: Container(
                            padding: EdgeInsets.symmetric(
                              horizontal: isDesktop(context) ? 20 : 3.w,
                              vertical: 1.5.h,
                            ),
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: AppColor.greyColor,
                                width: 2,
                              ),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Icon(
                                  Icons.photo_camera,
                                  size: isDesktop(context) ? 40 : 35.sp,
                                ),
                                SizedBox(width: isDesktop(context) ? 10 : 4.w),
                                Text(
                                  'TAKE NEW PHOTO',
                                  style: GoogleFonts.poppins(
                                    fontSize: isDesktop(context) ? 20 : 14.sp,
                                    color: AppColor.textBlackColor,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
            ),
          ),
        ],
      ),
    );
  }

  /// Choose From Gallery
  GestureDetector chooseFromGallery(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        // if (Platform.isAndroid || Platform.isIOS) {
        //   var res =
        //       await PermissionHandlerPermissionService.handleStoragePermission(
        //           context);
        //   if (res == true) {
        await homeController.getImage(source: ImageSource.gallery);
        if (homeController.selectedImageBytes!.value != null) {
          Get.toNamed(
            Routes.IMAGE_VIEW_SCREEN,
            arguments: ImageSource.gallery,
          );
        }
        // }
        // }
        // pickedFile();
      },
      child: Container(
        padding: EdgeInsets.symmetric(
            horizontal: isDesktop(context) ? 20 : 3.w, vertical: 1.5.h),
        decoration: BoxDecoration(
          border: Border.all(
            color: AppColor.greyColor,
            width: 2,
          ),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.photo,
              size: isDesktop(context) ? 40 : 35.sp,
            ),
            SizedBox(width: isDesktop(context) ? 10 : 4.w),
            Text(
              'CHOOSE FROM GALLERY',
              style: GoogleFonts.poppins(
                fontSize: isDesktop(context) ? 20 : 14.sp,
                color: AppColor.textBlackColor,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Pick File
  void pickedFile() async {}
}
