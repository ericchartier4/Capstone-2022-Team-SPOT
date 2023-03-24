// ignore_for_file: library_private_types_in_public_api
import 'package:demo/Routes/routes.dart';
import 'package:demo/Utils/legal.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import '../../Controllers/auth_controller.dart';
import '../../Utils/Widgets/custom_button.dart';
import '../../Utils/Widgets/custom_textfield.dart';
import '../../Utils/app_colors.dart';
import '../../Utils/constant_widgets.dart';
import '../Utils/preference.dart';
import '../main.dart';

class SignUpScreen extends StatefulWidget{
  SignUpScreen({Key? key}) : super(key: key);
  @override
  State<StatefulWidget> createState() => SignUpScreenState();

}



class SignUpScreenState extends State<SignUpScreen> {
  
  final AuthController authController = Get.put(AuthController());
  bool isLoading = false; 

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
        child: isLoading
        ? const Center(child: CircularProgressIndicator(),) 
        :
        Column(
          children: [
            Container(
              height: isDesktop(context) ? 30.h : 25.h,
              width: isDesktop(context) ? 55.w : 100.w,
              decoration: BoxDecoration(
                // color: const Color(0xffFEEAE6),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Container(
                    //padding: const EdgeInsets.only(top: 20),
                    alignment: Alignment.center,
                    child: Image.asset(
                      'assets/images/bot.png',
                      fit: BoxFit.cover,
                    ),
                  )
              
              //child: const Text('Image'),
            ),
            SizedBox(height: 2.h),
            Padding(
              padding: isDesktop(context)
                  ? EdgeInsets.symmetric(horizontal: 32.w)
                  : EdgeInsets.zero,
              child: Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15.0),
                ),
                shadowColor: const Color(0xffFEEAE6),
                elevation: 8,
                child: Padding(
                  padding: const EdgeInsets.all(15),
                  child: Column(
                    children: [
                      CustomTextField(
                        hint: 'First Name',
                        controller: authController.sFNameController,
                        textInputType: TextInputType.name,
                        textInputAction: TextInputAction.next,
                      ),
                      SizedBox(height: .5.h),
                      CustomTextField(
                        hint: 'Last Name',
                        controller: authController.sLNameController,
                        textInputType: TextInputType.name,
                        textInputAction: TextInputAction.next,
                      ),
                      SizedBox(height: .5.h),
                      CustomTextField(
                        hint: 'Email',
                        controller: authController.sEmailController,
                        textInputType: TextInputType.emailAddress,
                        textInputAction: TextInputAction.next,
                      ),
                      SizedBox(height: .5.h),
                      CustomTextField(
                        hint: 'Password',
                        controller: authController.sPasswordController,
                        textInputType: TextInputType.text,
                        textInputAction: TextInputAction.next,
                        obscureText: true,
                      ),
                      SizedBox(height: .5.h),
                      CustomTextField(
                        hint: 'Confirm Password',
                        controller: authController.sCPasswordController,
                        textInputType: TextInputType.text,
                        textInputAction: TextInputAction.next,
                        obscureText: true,
                      ),
                      SizedBox(height: .5.h),
                      
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(height: 5.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                CustomButton(
                  height: isDesktop(context) ? 7.h : 6.5.h,
                  width: isDesktop(context) ? 12.w : 40.w,
                  text: 'Quick Scan',
                  onTap: () async {
                     showDialog(context: context,
                                    barrierDismissible: false,
                                     builder: (BuildContext context) {
                                      return getLegal(context,0, authController);
                                     }
                    );
                  },
                ),
                CustomButton(
                  height: isDesktop(context) ? 7.h : 6.5.h,
                  width: isDesktop(context) ? 12.w : 40.w,
                  text: 'Sign Up',
                  onTap: () {
                    setState(() {
                      isLoading = true;
                    });
                    showDialog(context: context,
                                    barrierDismissible: false,
                                     builder: (BuildContext context) {
                                      return getLegal(context,1, authController);
                                     }
                    );
                      setState(() {
                      isLoading = true;
                    });
                  },
                ),
              ],
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
            SizedBox(height: 2.h),
            SizedBox(height: 10.h),
          ],
        ),
      ),
    );
  }
}
