

import 'package:demo/main.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import '../app_colors.dart';

class CustomButton extends StatelessWidget {
  String text;
  double? height;
  double? width;
  Function() onTap;

  CustomButton({
    Key? key,
    required this.text,
    required this.onTap,
    this.height = 30,
    this.width = 100,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(25.0),
        ),
        shadowColor: const Color(0xffFEEAE6),
        child: Container(
          height: height,
          width: width,
          decoration: BoxDecoration(
            color: const Color(0xffFEEAE6),
            borderRadius: BorderRadius.circular(25),
          ),
          child: Center(
            child: Text(
              text,
              style: TextStyle(
                fontSize: isDesktop(context) ? 18 : 14.sp,
                color: AppColor.blackColor,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
