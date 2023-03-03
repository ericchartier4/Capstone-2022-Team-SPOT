import 'dart:convert';

import 'package:demo/Utils/api_manager.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import '../Routes/routes.dart';
import '../Utils/constant_widgets.dart';
import '../Utils/preference.dart';

class AuthController extends GetxController {
  TextEditingController lEmailController = TextEditingController();
  TextEditingController lPasswordController = TextEditingController();
  TextEditingController sFNameController = TextEditingController();
  TextEditingController sLNameController = TextEditingController();
  TextEditingController sEmailController = TextEditingController();
  TextEditingController sPasswordController = TextEditingController();
  TextEditingController sCPasswordController = TextEditingController();
  TextEditingController sDobController = TextEditingController();
  var isObsecureText = true.obs;
  HttpService httpService = HttpService();

  // change obsecure value of password
  toggleObsecureValue() {
    isObsecureText.value = !isObsecureText.value;
  }

  // Email validation
  checkEmailLoginValidation(String email) {
    bool emailValid = GetUtils.isEmail(
      email.trim(),
    );
    return emailValid;
  }

  // validation for login
  checkValidationForLoginDetails() async {
    bool emailValid = RegExp("@gmail.com").hasMatch(lEmailController.text);
    if (lEmailController.text.isEmpty) {
      errorSnackBar(message: "Enter your Email");
    } else if (!emailValid) {
      errorSnackBar(message: "Enter Valid Email");
    } else if (lPasswordController.text.isEmpty) {
      errorSnackBar(message: "Enter your Password");
    } else {
      await Preference.shared.setString("useremail", lEmailController.text);
      await Preference.shared.setString("userpass", lPasswordController.text);
      Get.toNamed(Routes.HOME_SCREEN);
    }
  }

  // validation for signup
  Future<void> checkValidationForSignUpDetails() async {
    bool emailValid = RegExp("@gmail.com").hasMatch(sEmailController.text);
    if (sFNameController.text.isEmpty) {
      errorSnackBar(message: "Enter your First Name");
    } else if (!emailValid) {
      errorSnackBar(message: "Enter Valid Email");
      // } else if (sLNameController.text.isEmpty) {
      //   errorSnackBar(message: "Enter your Last Name");
      // } else if (sEmailController.text.isEmpty) {
      //   errorSnackBar(message: "Enter your Email");
      // } else if (sPasswordController.text.isEmpty) {
      //   errorSnackBar(message: "Enter your Password");
      // } else if (sCPasswordController.text != sPasswordController.text) {
      //   errorSnackBar(message: "Enter Correct Password");
      // } else if (sCPasswordController.text.isEmpty) {
      //   errorSnackBar(message: "Enter Confirm Password");
      // } else if (sDobController.text.isEmpty) {
      //   errorSnackBar(message: "Enter your DOB");
    } else {
      Map<String, String> postData = {
        "username": sFNameController.text,
        "email": sEmailController.text,
        "password": sPasswordController.text,
        "dob": sDobController.text,
      };

      var databody = json.encode(postData);

      print("postData = $postData");
      print("response = $databody");

      var responce = httpService.register(databody);
      print(responce);
      // Get.toNamed(Routes.HOME_SCREEN);
    }
  }
}
