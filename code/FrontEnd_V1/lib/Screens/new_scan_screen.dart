// ignore_for_file: library_private_types_in_public_api, avoid_print

import 'package:demo/Routes/routes.dart';
import 'package:demo/Utils/app_colors.dart';
import 'package:demo/main.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sizer/sizer.dart';
import '../Controllers/home_controller.dart';
import '../Utils/Widgets/permission_handler.dart';
import '../Utils/constant_widgets.dart';

class NewScanScreen extends StatefulWidget {
  const NewScanScreen({Key? key}) : super(key: key);

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
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
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
            // const SizedBox(
            //   height: 50,
            // ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 5.w),
              child:  chooseFromGallery(context)
            ),
          ],
        ),
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
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.0),
        ),
        elevation: 5,
        shadowColor: const Color(0xffFEDBD0),
        child: Container(
          width: isDesktop(context) ? 350 : 80.w,
          padding: EdgeInsets.symmetric(
              horizontal: isDesktop(context) ? 5 : 3.w, vertical: 1.5.h),
          decoration: BoxDecoration(
            color: const Color(0xffFEDBD0),
            // border: Border.all(
            //   color: const Color(0xff442C2E),
            //   width: 2,
            // ),
            borderRadius: BorderRadius.circular(15),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Icon(
                Icons.upload,
                size: isDesktop(context) ? 40 : 35.sp,
              ),
              SizedBox(width: isDesktop(context) ? 10 : 4.w),
              Text(
                'UPLOAD NEW PHOTO',
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
    );
  }

  // Pick File
  void pickedFile() async {}
}
