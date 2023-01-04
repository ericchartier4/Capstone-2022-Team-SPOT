import 'package:demo/Utils/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomDialog extends StatelessWidget {
  final String title;
  final String subtitle;
  final Function() onConfirm;

  const CustomDialog({
    Key? key,
    required this.onConfirm,
    required this.title,
    required this.subtitle,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(title),
      content: Text(subtitle),
      actions: [
        ElevatedButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: Text(
            'Cancel',
            style: GoogleFonts.poppins(
              color: AppColor.whiteColor,
            ),
          ),
        ),
        ElevatedButton(
          onPressed: onConfirm,
          child: Text(
            'Confirm',
            style: GoogleFonts.poppins(
              color: AppColor.whiteColor,
            ),
          ),
        ),
      ],
    );
  }
}
