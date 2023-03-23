// ignore_for_file: library_private_types_in_public_api
import 'package:demo/Routes/routes.dart';
import 'package:demo/main.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import '../../Controllers/auth_controller.dart';
import '../../Utils/Widgets/custom_button.dart';
import '../../Utils/Widgets/custom_textfield.dart';
import '../../Utils/app_colors.dart';
import '../../Utils/constant_widgets.dart';


class LogInScreen extends StatefulWidget{
  LogInScreen({Key? key}) : super(key: key);
  @override
  State<StatefulWidget> createState() => LogInScreenState();

}

class LogInScreenState extends State<LogInScreen> {
  
  final AuthController authController = Get.put(AuthController());
  bool isLoading = false;   
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar(
        isShowBackIcon: false,
        isShowMenuIcon: false,
        title: 'Login',
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        padding: EdgeInsets.symmetric(horizontal: 6.w, vertical: 1.h),
        child:
        isLoading
        ?    const Center(child: CircularProgressIndicator(),) 
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
              child: Row(
                mainAxisAlignment: isDesktop(context)
                    ? MainAxisAlignment.spaceEvenly
                    : MainAxisAlignment.spaceAround,
                children: [
                  const Text(
                    ' Already\n have an\n Account ?',
                    style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.w500,
                        color: AppColor.blackColor),
                  ),
                  Container(
                    padding: const EdgeInsets.only(top: 20),
                    child: Image.asset(
                      'assets/images/bot.png',
                      fit: BoxFit.cover,
                    ),
                  )
                ],
              ),
            ),
            SizedBox(height: 5.h),
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
                        hint: 'Email',
                        controller: authController.lEmailController,
                        textInputType: TextInputType.emailAddress,
                        textInputAction: TextInputAction.next,
                      ),
                      SizedBox(height: 1.5.h),
                      Obx(
                        () => CustomTextField(
                          hint: 'Password',
                          controller: authController.lPasswordController,
                          textInputType: TextInputType.text,
                          textInputAction: TextInputAction.done,
                          obscureText: authController.isObsecureText.value,
                          suffixIcon: InkWell(
                            onTap: () {
                              authController.toggleObsecureValue();
                            },
                            child: Icon(
                              authController.isObsecureText.value
                                  ? Icons.visibility_off_outlined
                                  : Icons.visibility_outlined,
                              color: AppColor.iconColor,
                              size: isDesktop(context) ? 20 : 24,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(height: 3.h),
            CustomButton(
              height: isDesktop(context) ? 7.h : 6.5.h,
              width: isDesktop(context) ? 15.w : 50.w,
              text: 'Login',
              onTap: () {
                // login validation
                    setState(() {
                      isLoading = true;
                    });
                authController.checkValidationForLoginDetails(context);
<<<<<<< Updated upstream
                  setState(() {
                      isLoading = false;
                    });
=======
>>>>>>> Stashed changes
              },
            ),
            SizedBox(height: 2.h),
            Text.rich(
              TextSpan(
                text: 'Don\'t have an account? ',
                style: TextStyle(
                  fontSize: isDesktop(context) ? 12 : 12.sp,
                ),
                children: [
                  TextSpan(
                    text: 'Sign up',
                    style: TextStyle(
                      fontSize: isDesktop(context) ? 12 : 12.sp,
                      fontWeight: FontWeight.bold,
                      color: AppColor.greenColor,
                    ),
                    recognizer: TapGestureRecognizer()
                      ..onTap = () {
                        Get.toNamed(Routes.SIGN_UP_SCREEN);
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
