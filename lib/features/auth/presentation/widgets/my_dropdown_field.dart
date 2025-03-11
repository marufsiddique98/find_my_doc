import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../config/constants/app_colors.dart';

List<Widget> MyDropdownField(BuildContext context, {required String text, required TextEditingController controller, required onChanged}) {
  return [
    Text(
      text,
      style: GoogleFonts.poppins(
        fontSize: 14.sp,
        fontWeight: FontWeight.w500,
        color: AppColors.grayColor22,
      ),
    ),
    SizeExtension(10).verticalSpace,
    Container(
      padding: EdgeInsets.symmetric(vertical: 15, horizontal: 10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        border: Border.all(width: 1, color: AppColors.grayColorD0),
      ),
      child: DropdownButtonFormField<String>(
        decoration: InputDecoration.collapsed(hintText: ''),
        style: GoogleFonts.poppins(
          fontSize: 14,
          fontWeight: FontWeight.w400,
          color: AppColors.grayColor8A,
        ),
        icon: Transform.rotate(angle: pi / 2, child: Icon(Icons.keyboard_arrow_right_sharp)),
        value: 'Male',
        items: [
          DropdownMenuItem(
            child: Text('Male'),
            value: 'Male',
          ),
          DropdownMenuItem(
            child: Text('Female'),
            value: 'Female',
          ),
        ],
        onChanged: onChanged,
      ),
    ),
    Gap(10.h),
  ];
}
