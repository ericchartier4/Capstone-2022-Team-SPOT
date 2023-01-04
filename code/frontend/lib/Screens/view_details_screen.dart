import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sizer/sizer.dart';
import '../Routes/routes.dart';
import '../Utils/Widgets/custom_button.dart';
import '../Utils/app_colors.dart';
import '../Utils/constant_widgets.dart';
import '../Controllers/home_controller.dart';
import '../main.dart';

class ViewDetailsScreen extends StatelessWidget {
  ViewDetailsScreen({Key? key}) : super(key: key);
  final HomeController homeController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar(
        isShowBackIcon: true,
        isShowMenuIcon: false,
        title: 'View Details',
      ),
      body: SizedBox(
        height: 100.h,
        width: 100.w,
        child: Column(
          children: [
            SizedBox(height: 1.h),
            // Selected Image
            Expanded(
              child: Obx(
                () => Image.memory(
                  homeController.selectedImageBytes!.value!,
                  height: isDesktop(context) ? 30.w : 35.h,
                  width: isDesktop(context) ? 30.w : 80.w,
                ),
              ),
            ),
            SizedBox(height: 2.h),
            // Bottom Part
            Container(
              padding:
                  EdgeInsets.only(left: 4.w, top: 2.h, right: 4.w, bottom: 2.h),
              decoration: BoxDecoration(
                color: AppColor.greyColor.withOpacity(0.2),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Column(
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      // Area affected text
                      Text.rich(
                        TextSpan(
                          text: 'Area affected: ',
                          style: GoogleFonts.poppins(
                            fontSize: isDesktop(context) ? 16 : 12.sp,
                            fontWeight: FontWeight.normal,
                            color: AppColor.textBlackColor,
                          ),
                          children: [
                            TextSpan(
                              text: homeController.selectedArea.value,
                              style: GoogleFonts.poppins(
                                fontSize: isDesktop(context) ? 16 : 12.sp,
                                fontWeight: FontWeight.w600,
                                color: AppColor.textBlackColor,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 0.5.h),
                  // About this scan text
                  Text(
                    'How would you describe the area affected (Colour, Shape, is there pain when you touch it)? :',
                    style: GoogleFonts.poppins(
                      fontSize: isDesktop(context) ? 14 : 10.sp,
                      fontWeight: FontWeight.normal,
                      color: AppColor.textBlackColor,
                    ),
                  ),
                  SizedBox(height: 1.h),
                  // About this scan discription
                  Container(
                    height: isDesktop(context) ? 15.h : 14.h,
                    width: isDesktop(context) ? 60.w : 100.w,
                    padding: EdgeInsets.only(
                      left: isDesktop(context) ? 0.7.w : 2.5.w,
                      top: 0.5.h,
                      right: isDesktop(context) ? 0.5.w : 1.5.w,
                      bottom: 0.5.h,
                    ),
                    decoration: BoxDecoration(
                      color: AppColor.greyColor.withOpacity(0.1),
                      border: Border.all(color: AppColor.greyColor),
                      borderRadius: BorderRadius.circular(0),
                    ),
                    child: Scrollbar(
                      controller: homeController.aboutController,
                      radius: const Radius.circular(15),
                      child: SingleChildScrollView(
                        physics: const BouncingScrollPhysics(),
                        controller: homeController.aboutController,
                        child: Text(
                          homeController.detailsController.text,
                          style: GoogleFonts.poppins(
                            color: AppColor.textBlackColor.withOpacity(0.7),
                            fontSize: isDesktop(context) ? 13 : 11.sp,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
                
              ),
            ),
            SizedBox(height: 0.5.h),
            Text(
              'Your photo has been submitted',
              style: GoogleFonts.poppins(
                fontSize: isDesktop(context) ? 16 : 12.sp,
                fontWeight: FontWeight.w500,
                color: AppColor.textBlackColor,
              ),
            ),
            SizedBox(height: 2.h),
            Text.rich(
                        TextSpan(
                          text: 'Benign: ',
                          style: GoogleFonts.poppins(
                            fontSize: isDesktop(context) ? 16 : 12.sp,
                            fontWeight: FontWeight.normal,
                            color: AppColor.textBlackColor,
                          ),
                          children: [
                            TextSpan(
                              text: homeController.bresult,
                              style: GoogleFonts.poppins(
                                fontSize: isDesktop(context) ? 16 : 12.sp,
                                fontWeight: FontWeight.w600,
                                color: AppColor.textBlackColor,
                              ),
                            ),
                          ],
                        ),
                      ),
             SizedBox(height: 2.h),
              Text.rich(
                        TextSpan(
                          text: 'Malignent: ',
                          style: GoogleFonts.poppins(
                            fontSize: isDesktop(context) ? 16 : 12.sp,
                            fontWeight: FontWeight.normal,
                            color: AppColor.textBlackColor,
                          ),
                          children: [
                            TextSpan(
                              text: homeController.mresult,
                              style: GoogleFonts.poppins(
                                fontSize: isDesktop(context) ? 16 : 12.sp,
                                fontWeight: FontWeight.w600,
                                color: AppColor.textBlackColor,
                              ),
                            ),
                          ],
                        ),
                      ),
            SizedBox(height: 1.h),
            // Submit button
            CustomButton(
              height: isDesktop(context) ? 6.h : 6.h,
              width: isDesktop(context) ? 30.w : 90.w,
              text: 'Done',
              onTap: () {
                Get.offNamedUntil(Routes.HOME_SCREEN, ((route) => false));
              },
            ),
            SizedBox(height: 2.h),
          ],
        ),
      ),
    );
  }
}
