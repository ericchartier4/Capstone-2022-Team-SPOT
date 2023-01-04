// ignore_for_file: must_be_immutable

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
      child: Container(
        height: height,
        width: width,
        decoration: BoxDecoration(
          color: AppColor.greenColor,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Center(
          child: Text(
            text,
            style: TextStyle(
              fontSize: isDesktop(context) ? 18 : 14.sp,
              color: AppColor.whiteColor,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ),
    );
  }
}
