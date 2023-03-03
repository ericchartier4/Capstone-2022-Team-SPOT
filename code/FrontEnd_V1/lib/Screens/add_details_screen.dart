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
                Padding(
                  padding:
                      EdgeInsets.symmetric(horizontal: 10.w, vertical: 3.h),
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
                        backgroundColor: Colors.grey,
                        child: Text(
                          "2",
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
                        child: Icon(
                          Icons.flag_outlined,
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 1.h),
                // Selected Image
                Container(
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
                SizedBox(height: 2.h),
                // Bottom Part
                Container(
                  margin: const EdgeInsets.all(10),
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
                                color: const Color(0xffFEEAE6),
                                border: Border.all(
                                  color: const Color(0xff442C2E),
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
                        child: Container(
                          decoration: BoxDecoration(
                            color: const Color(0xffFEEAE6),
                            borderRadius: BorderRadius.circular(15),
                          ),
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
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              contentPadding:
                                  const EdgeInsets.only(left: 10, top: 10),
                              hintText: 'Your text here...',
                              // enabledBorder: OutlineInputBorder(
                              //   borderSide: const BorderSide(
                              //     width: 1.5,
                              //     color: AppColor.greyColor,
                              //   ),
                              //   borderRadius: BorderRadius.circular(10),
                              // ),
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
                    homeController.addEntryHelper();
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
