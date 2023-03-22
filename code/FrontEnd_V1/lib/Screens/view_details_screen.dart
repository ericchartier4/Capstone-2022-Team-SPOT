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
import '../Utils/preference.dart';
import 'package:pie_chart/pie_chart.dart';

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
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
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
            Container(
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
          SizedBox(height: 0.5.h),
           Text(
                    "Predictions of your scan: ",
                    style: GoogleFonts.poppins(
                      fontSize: isDesktop(context) ? 16 : 12.sp,
                      fontWeight: FontWeight.w600,
                      color: AppColor.textBlackColor,
                    ),
                  ),
            SizedBox(height: 2.h),
            Container(
               height: isDesktop(context) ? 20.w : 10.h,
               width: isDesktop(context) ? 30.w :  15.w,
              child: PieChart(dataMap: {"Melanocytic Nevi (Heathy Skin)":double.parse(homeController.melResultViewDetails ?? '0'),
               "Benign Keratosis-Like Lesions":double.parse(homeController.bKLResultViewDetails ?? '0'),
               "Basal Cell Carcinoma":double.parse(homeController.bCCResultViewDetails ?? '0'),
               "Actinic Keratose":double.parse(homeController.akiecResultViewDetails ?? '0'),
                "Vascular Lesions":double.parse(homeController.vascResultViewDetails ?? '0'),
                "Dermatofibroma":double.parse(homeController.dFResultViewDetails ?? '0'),
                 "Melanoma":double.parse(homeController.dFResultViewDetails ?? '0'),
               
                }),

            ),
          SizedBox(height: 0.5.h),
           Text(
                    "expanded view of Melanoma Predictions ",
                    style: GoogleFonts.poppins(
                      fontSize: isDesktop(context) ? 16 : 12.sp,
                      fontWeight: FontWeight.w600,
                      color: AppColor.textBlackColor,
                    ),
                  ),
            SizedBox(height: 2.h),
            Container(
               height: isDesktop(context) ? 20.w : 10.h,
               width: isDesktop(context) ? 30.w : 15.w,
              child: PieChart(dataMap: {"Benign":double.parse(homeController.melBenResultViewDetails ?? '0'), "Mlignent":double.parse(homeController.melMaligResultViewDetails?? '0' )}),

            ),
          

          




          SizedBox(height: 2.h), 
            Text.rich(
              TextSpan(
                text: 'Melanocytic Nevi (Heathy Skin) prediction:: ',
                style: GoogleFonts.poppins(
                  fontSize: isDesktop(context) ? 16 : 12.sp,
                  fontWeight: FontWeight.normal,
                  color: AppColor.textBlackColor,
                ),
                children: [
                  TextSpan(
                    text: homeController.bKLResultViewDetails,
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
                text: 'Benign Keratosis-Like Lesions prediction: ',
                style: GoogleFonts.poppins(
                  fontSize: isDesktop(context) ? 16 : 12.sp,
                  fontWeight: FontWeight.normal,
                  color: AppColor.textBlackColor,
                ),
                children: [
                  TextSpan(
                    text: homeController.bKLResultViewDetails,
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
                text: 'Basal Cell Carcinoma prediction: ',
                style: GoogleFonts.poppins(
                  fontSize: isDesktop(context) ? 16 : 12.sp,
                  fontWeight: FontWeight.normal,
                  color: AppColor.textBlackColor,
                ),
                children: [
                  TextSpan(
                    text: homeController.bCCResultViewDetails,
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
                text: 'Actinic Keratose prediction: ',
                style: GoogleFonts.poppins(
                  fontSize: isDesktop(context) ? 16 : 12.sp,
                  fontWeight: FontWeight.normal,
                  color: AppColor.textBlackColor,
                ),
                children: [
                  TextSpan(
                    text: homeController.akiecResultViewDetails,
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
                text: 'Vascular Lesions prediction: ',
                style: GoogleFonts.poppins(
                  fontSize: isDesktop(context) ? 16 : 12.sp,
                  fontWeight: FontWeight.normal,
                  color: AppColor.textBlackColor,
                ),
                children: [
                  TextSpan(
                    text: homeController.vascResultViewDetails,
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
                text: 'Dermatofibroma prediction: ',
                style: GoogleFonts.poppins(
                  fontSize: isDesktop(context) ? 16 : 12.sp,
                  fontWeight: FontWeight.normal,
                  color: AppColor.textBlackColor,
                ),
                children: [
                  TextSpan(
                    text: homeController.dFResultViewDetails,
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
                text: 'Melanoma prediction: ',
                style: GoogleFonts.poppins(
                  fontSize: isDesktop(context) ? 16 : 12.sp,
                  fontWeight: FontWeight.normal,
                  color: AppColor.textBlackColor,
                ),
                children: [
                  TextSpan(
                    text: homeController.melResultViewDetails,
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
                text: 'Benign Melanoma prediction : ',
                style: GoogleFonts.poppins(
                  fontSize: isDesktop(context) ? 16 : 12.sp,
                  fontWeight: FontWeight.normal,
                  color: AppColor.textBlackColor,
                ),
                children: [
                  TextSpan(
                    text: homeController.melBenResultViewDetails,
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
                text: 'Malignent Melanoma prediction: ',
                style: GoogleFonts.poppins(
                  fontSize: isDesktop(context) ? 16 : 12.sp,
                  fontWeight: FontWeight.normal,
                  color: AppColor.textBlackColor,
                ),
                children: [
                  TextSpan(
                    text: homeController.melMaligResultViewDetails,
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
                if (Preference.shared.getString('useremail')! ==
                    'nullnullnull') {
                  Get.offAllNamed(Routes.LOGIN_SCREEN);
                } else {
                  Get.offNamedUntil(Routes.HOME_SCREEN, ((route) => false));
                }
              },
            ),
            SizedBox(height: 2.h),
          ],
        ),
      ),
    );
  }
}
