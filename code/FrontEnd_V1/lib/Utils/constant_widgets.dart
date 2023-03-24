import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'app_colors.dart';

// Snack bar for showing success message
successSnackBar({String? title, String? message}) {
  Get.log("[$title] $message", isError: true);
  return Get.showSnackbar(
    GetSnackBar(
      titleText: Text(
        title ?? 'Success',
        textAlign: TextAlign.left,
        style: const TextStyle(
            color: Colors.white,
            fontSize: 15,
            height: 1.0,
            fontWeight: FontWeight.bold),
      ),
      messageText: Text(
        message!,
        style: const TextStyle(
            color: Colors.white,
            fontSize: 12,
            height: 1.0,
            fontWeight: FontWeight.w700),
        textAlign: TextAlign.left,
      ),
      isDismissible: true,
      snackPosition: SnackPosition.TOP,
      margin: const EdgeInsets.all(20),
      backgroundColor: Colors.green.withOpacity(0.80),
      icon:
          const Icon(Icons.task_alt_outlined, size: 30.0, color: Colors.white),
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
      borderRadius: 8,
      duration: const Duration(seconds: 3),
    ),
  );
}

// Snack bar for showing error message
errorSnackBar({String? title, String? message}) {
  Get.log("[$title] $message", isError: true);
  return Get.showSnackbar(
    GetSnackBar(
      titleText: Text(
        title ?? 'Error',
        style: const TextStyle(
            color: Colors.white,
            fontSize: 15,
            height: 1.0,
            fontWeight: FontWeight.bold),
        textAlign: TextAlign.left,
      ),
      messageText: Text(
        message!,
        style: const TextStyle(
            color: Colors.white,
            fontSize: 12,
            height: 1.0,
            fontWeight: FontWeight.w700),
        textAlign: TextAlign.left,
      ),
      snackPosition: SnackPosition.TOP,
      shouldIconPulse: true,
      margin: const EdgeInsets.all(20),
      backgroundColor: Colors.red.withOpacity(0.80),
      icon: const Icon(Icons.gpp_bad_outlined, size: 30.0, color: Colors.white),
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
      borderRadius: 8,
      duration: const Duration(
        seconds: 30,
      ),
    ),
  );
}

// Show progress indicator when API call Or any other async method call
showProgressIndicator() {
  return EasyLoading.show(
    maskType: EasyLoadingMaskType.black,
    status: 'Loading',
    dismissOnTap: false,
  );
}

// Dismiss progress indicator after API calling Or any other async method calling
dismissProgressIndicator() {
  return EasyLoading.dismiss();
}

// Custom Appbar
customAppBar(
    {required String title,
    List<Widget>? actions,
    bool? isShowBackIcon = false,
    bool? isShowMenuIcon = true}) {
  return AppBar(
    backgroundColor: const Color(0xffFEDBD0),
    leading: Builder(
      builder: (BuildContext context) {
        return isShowBackIcon! == true
            ? GestureDetector(
                onTap: () {
                  Get.back();
                },
                child: const Icon(
                  Icons.arrow_back_ios_new_outlined,
                  color: AppColor.whiteColor,
                ),
              )
            : isShowMenuIcon! == true
                ? GestureDetector(
                    onTap: () {},
                    child: const Icon(Icons.menu),
                  )
                : Container();
      },
    ),
    title: Text(
      title,
      style: const TextStyle(
          fontWeight: FontWeight.w500,
          fontSize: 22.0,
          color: AppColor.blackColor),
    ),
    centerTitle: true,
    actions: actions ?? [],
    elevation: 0,
    // flexibleSpace: Container(
    //   decoration: const BoxDecoration(
    //     gradient: LinearGradient(
    //       begin: Alignment.centerLeft,
    //       end: Alignment.centerRight,
    //       colors: <Color>[
    //         AppColor.topLightBlueColor,
    //         AppColor.bottomPurpleColor,
    //       ],
    //     ),
    //   ),
    // ),
  );
}
