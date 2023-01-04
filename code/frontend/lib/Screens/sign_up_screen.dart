// ignore_for_file: library_private_types_in_public_api
import 'package:demo/Routes/routes.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import '../../Controllers/auth_controller.dart';
import '../../Utils/Widgets/custom_button.dart';
import '../../Utils/Widgets/custom_textfield.dart';
import '../../Utils/app_colors.dart';
import '../../Utils/constant_widgets.dart';
import '../main.dart';

class SignUpScreen extends StatelessWidget {
  SignUpScreen({Key? key}) : super(key: key);
  final AuthController authController = Get.put(AuthController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar(
        isShowBackIcon: true,
        title: 'Sign Up',
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 1.h),
        child: Column(
          children: [
            Container(
              height: isDesktop(context) ? 30.h : 25.h,
              width: isDesktop(context) ? 40.w : 100.w,
              decoration: BoxDecoration(
                color: Colors.lightBlue.withOpacity(0.2),
                borderRadius: BorderRadius.circular(20),
              ),
              alignment: Alignment.center,
              child: const Text('Image'),
            ),
            SizedBox(height: 2.h),
            Padding(
              padding: isDesktop(context)
                  ? EdgeInsets.symmetric(horizontal: 32.w)
                  : EdgeInsets.zero,
              child: CustomTextField(
                hint: 'First Name',
                controller: authController.sFNameController,
                textInputType: TextInputType.name,
                textInputAction: TextInputAction.next,
              ),
            ),
            SizedBox(height: 1.5.h),
            Padding(
              padding: isDesktop(context)
                  ? EdgeInsets.symmetric(horizontal: 32.w)
                  : EdgeInsets.zero,
              child: CustomTextField(
                hint: 'Last Name',
                controller: authController.sLNameController,
                textInputType: TextInputType.name,
                textInputAction: TextInputAction.next,
              ),
            ),
            SizedBox(height: 1.5.h),
            Padding(
              padding: isDesktop(context)
                  ? EdgeInsets.symmetric(horizontal: 32.w)
                  : EdgeInsets.zero,
              child: CustomTextField(
                hint: 'Email',
                controller: authController.sEmailController,
                textInputType: TextInputType.emailAddress,
                textInputAction: TextInputAction.next,
              ),
            ),
            SizedBox(height: 1.5.h),
            Padding(
              padding: isDesktop(context)
                  ? EdgeInsets.symmetric(horizontal: 32.w)
                  : EdgeInsets.zero,
              child: CustomTextField(
                hint: 'Password',
                controller: authController.sPasswordController,
                textInputType: TextInputType.text,
                textInputAction: TextInputAction.next,
                obscureText: true,
              ),
            ),
            SizedBox(height: 1.5.h),
            Padding(
              padding: isDesktop(context)
                  ? EdgeInsets.symmetric(horizontal: 32.w)
                  : EdgeInsets.zero,
              child: CustomTextField(
                hint: 'Confirm Password',
                controller: authController.sCPasswordController,
                textInputType: TextInputType.text,
                textInputAction: TextInputAction.next,
                obscureText: true,
              ),
            ),
            SizedBox(height: 1.5.h),
            Padding(
              padding: isDesktop(context)
                  ? EdgeInsets.symmetric(horizontal: 32.w)
                  : EdgeInsets.zero,
              child: CustomTextField(
                hint: 'Date of birth',
                controller: authController.sDobController,
                textInputType: TextInputType.datetime,
                textInputAction: TextInputAction.done,
              ),
            ),
            SizedBox(height: 2.h),
            CustomButton(
              height: isDesktop(context) ? 7.h : 6.5.h,
              width: isDesktop(context) ? 15.w : 50.w,
              text: 'Sign Up',
              onTap: () {
                // signup validation
                authController.checkValidationForSignUpDetails();
              },
            ),
            SizedBox(height: 2.h),
            Text.rich(
              TextSpan(
                text: 'Already have an account? ',
                style: TextStyle(
                  fontSize: isDesktop(context) ? 12 : 12.sp,
                ),
                children: [
                  TextSpan(
                    text: 'Login',
                    style: TextStyle(
                      fontSize: isDesktop(context) ? 12 : 12.sp,
                      fontWeight: FontWeight.bold,
                      color: AppColor.greenColor,
                    ),
                    recognizer: TapGestureRecognizer()
                      ..onTap = () {
                        Get.back();
                      },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
