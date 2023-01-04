import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sizer/sizer.dart';
import '../Controllers/home_controller.dart';
import '../Routes/routes.dart';
import '../Utils/Widgets/custom_button.dart';
import '../Utils/app_colors.dart';
import '../Utils/constant_widgets.dart';
import '../main.dart';

class AddDetailsScreen extends StatelessWidget {
  AddDetailsScreen({Key? key}) : super(key: key);
  final HomeController homeController = Get.find();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).requestFocus(FocusNode());
      },
      child: Scaffold(
        appBar: customAppBar(
          isShowBackIcon: true,
          isShowMenuIcon: false,
          title: 'Add Details',
        ),
        body: SizedBox(
          height: 100.h,
          width: 100.w,
          child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(height: 1.h),
                // Selected Image
                Obx(
                  () => Image.memory(
                    homeController.selectedImageBytes!.value!,
                    height: isDesktop(context) ? 30.w : 35.h,
                    width: isDesktop(context) ? 30.w : 80.w,
                  ),
                ),
                SizedBox(height: 2.h),
                // Bottom Part
                Container(
                  constraints: BoxConstraints(
                    maxHeight: 35.h,
                    maxWidth: 100.w,
                  ),
                  padding: EdgeInsets.only(
                      left: 4.w, top: 2.h, right: 4.w, bottom: 2.h),
                  decoration: BoxDecoration(
                    color: AppColor.greyColor.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Column(
                    children: <Widget>[
                      Row(
                        children: <Widget>[
                          // Area affected text
                          Text(
                            'Area affected:',
                            style: GoogleFonts.poppins(
                              fontSize: isDesktop(context) ? 15 : 11.sp,
                              color: AppColor.textBlackColor,
                            ),
                          ),
                          SizedBox(width: 3.w),
                          // Dropdown for select area
                          Expanded(
                            child: Container(
                              padding: EdgeInsets.symmetric(
                                  horizontal: isDesktop(context) ? 20 : 3.w),
                              decoration: BoxDecoration(
                                border: Border.all(
                                  color: AppColor.greyColor,
                                  width: 1.5,
                                ),
                                borderRadius: BorderRadius.circular(6),
                              ),
                              child: Obx(
                                () => DropdownButtonFormField(
                                  items: homeController.dropdownItems,
                                  value: homeController.selectedArea.value,
                                  onChanged: (value) {
                                    homeController.selectedArea.value =
                                        value.toString();
                                  },
                                  decoration: const InputDecoration(
                                    border: InputBorder.none,
                                    enabledBorder: InputBorder.none,
                                  ),
                                  iconEnabledColor: AppColor.textBlackColor,
                                  style: GoogleFonts.poppins(
                                    fontSize: isDesktop(context) ? 16 : 12.sp,
                                    color: AppColor.textBlackColor,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 3.h),
                      Text(
                        'How would you describe the area affected (Colour, Shape, is there pain when you touch it)? :',
                        style: GoogleFonts.poppins(
                          fontSize: isDesktop(context) ? 15 : 11.sp,
                          color: AppColor.textBlackColor,
                        ),
                      ),
                      SizedBox(height: 1.h),
                      Expanded(
                        child: TextFormField(
                          controller: homeController.detailsController,
                          cursorColor: AppColor.greenColor,
                          keyboardType: TextInputType.multiline,
                          textInputAction: TextInputAction.newline,
                          minLines: null,
                          maxLines: null,
                          style: const TextStyle(
                            fontSize: 16.0,
                            color: AppColor.blackColor,
                          ),
                          decoration: InputDecoration(
                            contentPadding:
                                const EdgeInsets.only(left: 10, top: 10),
                            hintText: 'Your text here...',
                            enabledBorder: OutlineInputBorder(
                              borderSide: const BorderSide(
                                width: 1.5,
                                color: AppColor.greyColor,
                              ),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: const BorderSide(
                                width: 1.5,
                                color: AppColor.greyColor,
                              ),
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 2.h),
                // Submit button
                CustomButton(
                  height: isDesktop(context) ? 6.h : 6.h,
                  width: isDesktop(context) ? 30.w : 90.w,
                  text: 'Submit',
                  onTap: () {
                    homeController.upload();
                    //Get.toNamed(Routes.VIEW_DETAILS_SCREEN);
                  },
                ),
                SizedBox(height: 2.h),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
