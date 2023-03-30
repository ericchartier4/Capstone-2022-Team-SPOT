
import 'package:demo/Routes/routes.dart';
import 'package:demo/Utils/app_colors.dart';
import 'package:demo/main.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sizer/sizer.dart';
import '../Controllers/home_controller.dart';
import '../Utils/Widgets/permission_handler.dart';
import '../Utils/constant_widgets.dart';

class NewScanScreen extends StatefulWidget {
  const NewScanScreen({Key? key}) : super(key: key);

  @override
  State<NewScanScreen> createState() => _NewScanScreenState();
}

class _NewScanScreenState extends State<NewScanScreen> {
  final HomeController homeController = Get.put(HomeController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar(
        isShowBackIcon: true,
        isShowMenuIcon: false,
        title: 'New Scan',
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
       
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 5.w),
              child:  chooseFromGallery(context)
            ),
          ],
        ),
      ),
    );
  }

 
  GestureDetector chooseFromGallery(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        
        showDialog(context: context,
                                    barrierDismissible: false,
                                     builder: (BuildContext context) {
                                      return getExampleImage(context,homeController);
                                     }
                    );
      },
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.0),
        ),
        elevation: 5,
        shadowColor: const Color(0xffFEDBD0),
        child: Container(
          width: isDesktop(context) ? 350 : 80.w,
          padding: EdgeInsets.symmetric(
              horizontal: isDesktop(context) ? 5 : 3.w, vertical: 1.5.h),
          decoration: BoxDecoration(
            color: const Color(0xffFEDBD0),
       
            borderRadius: BorderRadius.circular(15),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Icon(
                Icons.upload,
                size: isDesktop(context) ? 40 : 35.sp,
              ),
              SizedBox(width: isDesktop(context) ? 10 : 4.w),
              Text(
                'UPLOAD NEW PHOTO',
                style: GoogleFonts.poppins(
                  fontSize: isDesktop(context) ? 20 : 14.sp,
                  color: AppColor.textBlackColor,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  
  void pickedFile() async {}
}






