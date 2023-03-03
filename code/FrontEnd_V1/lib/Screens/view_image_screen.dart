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

class ViewImageScreen extends StatefulWidget {
  const ViewImageScreen({Key? key}) : super(key: key);

  @override
  State<ViewImageScreen> createState() => _ViewImageScreenState();
}

class _ViewImageScreenState extends State<ViewImageScreen> {
  final HomeController homeController = Get.find();

  final ImageSource source = Get.arguments;

  int activeStepIndex = 0;

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
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 3.w),
              child: Row(
                children: [
                  const CircleAvatar(
                    backgroundColor: Colors.grey,
                    child: Text(
                      "1",
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                  ),
                  Container(
                    height: 0.7.h,
                    width: 8.w,
                    color: const Color(0xffFEEAE6),
                  ),
                  const CircleAvatar(
                    backgroundColor: Color(0xffFEEAE6),
                    child: Text(
                      "2",
                      style: TextStyle(
                        color: Colors.black,
                      ),
                    ),
                  ),
                  Container(
                    height: 0.7.h,
                    width: 8.w,
                    color: const Color(0xffFEEAE6),
                  ),
                  const CircleAvatar(
                    backgroundColor: Color(0xffFEEAE6),
                    child: Icon(
                      Icons.flag_outlined,
                      color: Colors.black,
                    ),
                  ),
                ],
              ),
            ),
            Container(
              padding: const EdgeInsets.all(8),
              height: isDesktop(context) ? 30.h : 50.h,
              width: isDesktop(context) ? 30.w : 80.w,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(25),
                child: Obx(
                  // ignore: unrelated_type_equality_checks
                  () => homeController.selectedImageBytes!.value == ''
                      ? Image.asset(
                          'assets/images/placeholder.png',
                        )
                      : Image.memory(
                          homeController.selectedImageBytes!.value!,
                          // height: isDesktop(context) ? 30.w : 50.h,
                          // width: isDesktop(context) ? 30.w : 80.w,
                        ),
                ),
              ),
            ),
            // Container(
            //   height: 200,
            //   width: 200,
            //   color: Colors.blue,
            // ),
            SizedBox(height: 3.h),
            GestureDetector(
              onTap: () {
                if (homeController.selectedImageBytes!.value != null) {
                  Get.toNamed(Routes.ADD_DETAILS_SCREEN);
                }
              },
              child: Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(25.0),
                ),
                elevation: 5,
                shadowColor: const Color(0xffFEEAE6),
                child: Container(
                  padding: EdgeInsets.symmetric(
                      horizontal: isDesktop(context) ? 20 : 5.w,
                      vertical: 1.5.h),
                  decoration: BoxDecoration(
                    color: const Color(0xffFEDBD0),
                    // border: Border.all(
                    //   color: const Color(0xff442C2E),
                    //   width: 2,
                    // ),
                    borderRadius: BorderRadius.circular(25),
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
            ),
            SizedBox(height: 2.h),
            GestureDetector(
              onTap: () async {
                await homeController.getImage(source: source);
                if (homeController.selectedImageBytes!.value != null) {}
              },
              child: Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(25.0),
                ),
                elevation: 5,
                shadowColor: const Color(0xffFEEAE6),
                child: Container(
                  padding: EdgeInsets.symmetric(
                      horizontal: isDesktop(context) ? 20 : 5.w,
                      vertical: 1.5.h),
                  decoration: BoxDecoration(
                    color: const Color(0xffFEDBD0),
                    // border: Border.all(
                    //   color: const Color(0xff442C2E),
                    //   width: 2,
                    // ),
                    borderRadius: BorderRadius.circular(25),
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
            ),
          ],
        ),
      ),
    );
  }
}
