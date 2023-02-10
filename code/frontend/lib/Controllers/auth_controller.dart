import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import '../Routes/routes.dart';
import '../Utils/constant_widgets.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:http_parser/http_parser.dart';
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
      logInHelper();
    }
  }

  // validation for signup
  checkValidationForSignUpDetails() {
    bool emailValid = RegExp("@gmail.com").hasMatch(sEmailController.text);
    if (sFNameController.text.isEmpty) {
      errorSnackBar(message: "Enter your First Name");
    } else if (!emailValid) {
      errorSnackBar(message: "Enter Valid Email");
    } else if (sLNameController.text.isEmpty) {
      errorSnackBar(message: "Enter your Last Name");
    } else if (sEmailController.text.isEmpty) {
      errorSnackBar(message: "Enter your Email");
    } else if (sPasswordController.text.isEmpty) {
      errorSnackBar(message: "Enter your Password");
    } else if (sCPasswordController.text != sPasswordController.text) {
      errorSnackBar(message: "Enter Correct Password");
    } else if (sCPasswordController.text.isEmpty) {
      errorSnackBar(message: "Enter Confirm Password");
    } else if (sDobController.text.isEmpty) {
      errorSnackBar(message: "Enter your DOB");
    } else {
      signUpHelper();
    }
  }

  Future<void> signUpHelper() async {
    http.StreamedResponse response = await signUpHttp(
        sEmailController.text,
        sFNameController.text,
        sLNameController.text,
        sPasswordController.text,
        sDobController.text);

    //_isLoading = false;
    //if (response.statusCode == 200) {
    Map map = jsonDecode(await response.stream.bytesToString());

    //_imagePath=message;
    // _pickedFile = null;
    //await getUserInfo();
    //print(message);
    //} else {
    //print("error posting the image");
    //}
    await Preference.shared.setString("useremail", sEmailController.text);
    await Preference.shared.setString("userpass", sPasswordController.text);
    Get.toNamed(
        Routes.HOME_SCREEN); // having this here to transition to next page
  }

  Future<http.StreamedResponse> signUpHttp(
    String? email,
    String? fName,
    String? lName,
    String? pass,
    String? dOB,
  ) async {
    http.MultipartRequest request = http.MultipartRequest(
        'POST', Uri.parse('http://127.0.0.1:5000/signUp'));

    //request.headers.addAll(<String,String>{'Authorization': 'Bearer $token'});
    //Check if Uint8List populated, it will or will not have an image, this image
    request.fields['email'] = email!;
    request.fields['fName'] = fName!;
    request.fields['lName'] = lName!;
    request.fields['pass'] = pass!;
    request.fields['dOB'] = dOB!;
    http.StreamedResponse response = await request.send();
    return response;
  }

  Future<void> logInHelper() async {
    http.StreamedResponse response = await logInHttp(
      lEmailController.text,
      lPasswordController.text,
    );

    //_isLoading = false;
    //if (response.statusCode == 200) {
    Map map = jsonDecode(await response.stream.bytesToString());
    bool result = map["Result"];
    if (result == true) {
    await Preference.shared.setString("useremail", lEmailController.text);
    await Preference.shared.setString("userpass", lPasswordController.text);
      Get.toNamed(
          Routes.HOME_SCREEN); // having this here to transition to next page

    } else {
      errorSnackBar(
          message: "Your Email or Password is Wrong, please try again");
    }

    //_imagePath=message;
    // _pickedFile = null;
    //await getUserInfo();
    //print(message);
    //} else {
    //print("error posting the image");
    //}
  }

  Future<http.StreamedResponse> logInHttp(
    String? email,
    String? pass,
  ) async {
    http.MultipartRequest request =
        http.MultipartRequest('POST', Uri.parse('http://127.0.0.1:5000/logIn'));

    //request.headers.addAll(<String,String>{'Authorization': 'Bearer $token'});
    //Check if Uint8List populated, it will or will not have an image, this image
    request.fields['email'] = email!;
    request.fields['pass'] = pass!;

    http.StreamedResponse response = await request.send();
    return response;
  }
}
