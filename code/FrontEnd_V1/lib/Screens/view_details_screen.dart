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
      resizeToAvoidBottomInset: false,
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
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 3.h),
              child: Row(
                children: [
                  const CircleAvatar(
                    backgroundColor: Colors.green,
                    child: Icon(
                      Icons.check,
                      color: Colors.white,
                    ),
                  ),
                  Container(
                    height: 0.7.h,
                    width: 8.w,
                    color: Colors.green,
                  ),
                  const CircleAvatar(
                    backgroundColor: Colors.green,
                    child: Icon(
                      Icons.check,
                      color: Colors.white,
                    ),
                  ),
                  Container(
                    height: 0.7.h,
                    width: 8.w,
                    color: Colors.green,
                  ),
                  const CircleAvatar(
                    backgroundColor: Colors.grey,
                    child: Icon(
                      Icons.flag_outlined,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 1.h),
            // Selected Image
            Expanded(
              child: Container(
                padding: const EdgeInsets.all(8),
                height: isDesktop(context) ? 30.w : 35.h,
                width: isDesktop(context) ? 30.w : 80.w,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(5),
                  child: Obx(
                    () => Image.memory(
                      homeController.selectedImageBytes!.value!,
                      fit: BoxFit.cover,
                      // height: isDesktop(context) ? 30.w : 35.h,
                      // width: isDesktop(context) ? 30.w : 80.w,
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(height: 2.h),
            // Bottom Part
            Container(
              margin: const EdgeInsets.all(10),
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
                  // About this scan description
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
                        child: TextFormField(
                          controller: homeController.detailsController,
                          cursorColor: AppColor.greenColor,
                          keyboardType: TextInputType.multiline,
                          textInputAction: TextInputAction.newline,
                          minLines: 5,
                          maxLines: 7,
                          style: const TextStyle(
                            fontSize: 16.0,
                            color: AppColor.blackColor,
                          ),
                          decoration: const InputDecoration(
                            border: InputBorder.none,
                            contentPadding: EdgeInsets.only(left: 10, top: 10),
                            hintText: 'Your text here...',
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
            Text(
              'PLEASE KEEP AN EYE OUT ON YOUR EMAIL WE WILL INFORM YOU WHEN OUR AI HAS REVIEWED YOUR SUMISSION THANK YOU',
              textAlign: TextAlign.center,
              style: GoogleFonts.poppins(
                fontSize: isDesktop(context) ? 16 : 11.sp,
                fontWeight: FontWeight.w400,
                color: AppColor.textBlackColor,
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
