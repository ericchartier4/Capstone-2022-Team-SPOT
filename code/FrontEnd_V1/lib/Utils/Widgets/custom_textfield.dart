

import 'package:flutter/material.dart';
import '../app_colors.dart';

class CustomTextField extends StatelessWidget {
  final String hint;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final EdgeInsetsGeometry? padding;
  final bool? obscureText;
  final Color? colorBorder;
  final Color? colorDisableBorder;
  final int? maxLength;
  
  final validation;
  TextInputType? textInputType;

  TextInputAction? textInputAction;
  final TextEditingController controller;
  Function()? onTapSuffix;

  CustomTextField({
    Key? key,
    required this.hint,
    required this.controller,
    this.padding,
    this.obscureText,
    this.prefixIcon,
    this.suffixIcon,
    this.colorBorder,
    this.colorDisableBorder,
    this.maxLength,
    this.onTapSuffix,
    this.validation,
    this.textInputType,
    this.textInputAction,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      validator: validation,
      obscureText: obscureText ?? false,
      cursorColor: colorBorder ?? AppColor.greenColor,
      keyboardType: textInputType ?? TextInputType.text,
      textInputAction: textInputAction,
      style: TextStyle(
        color: colorBorder == null ? AppColor.blackColor : AppColor.whiteColor,
      ),
      maxLength: maxLength,
      decoration: InputDecoration(
  
          prefixIcon: prefixIcon,
          suffixIcon: suffixIcon,
          enabledBorder: UnderlineInputBorder(
            borderSide: BorderSide(
              width: 1.5,
              color: colorDisableBorder ?? const Color(0xffFEDBD0),
            ),
            borderRadius: BorderRadius.circular(4),
          ),
          focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(
              width: 1.5,
              color: colorDisableBorder ?? AppColor.greyColor,
            ),
            borderRadius: BorderRadius.circular(4),
          ),
          labelText: hint,
          labelStyle: const TextStyle(color: AppColor.blackColor)),
    );
  }
}
