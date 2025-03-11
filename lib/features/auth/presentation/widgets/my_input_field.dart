import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../config/constants/app_colors.dart';

final borderStyle = OutlineInputBorder(
  gapPadding: 0,
  borderRadius: BorderRadius.circular(8),
  borderSide: BorderSide(color: AppColors.grayColorD0, width: 1),
);

List<Widget> MyInputField(BuildContext context, {required String text, required TextEditingController controller}) {
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
    TextFormField(
      controller: controller,
      decoration: InputDecoration(
        border: borderStyle,
        enabledBorder: borderStyle,
        focusedBorder: borderStyle.copyWith(
          borderSide: BorderSide(width: 2, color: AppColors.purpleColor),
        ),
        errorBorder: borderStyle.copyWith(
          borderSide: BorderSide(width: 2, color: AppColors.redColor),
        ),
      ),
    ),
    SizeExtension(10).verticalSpace,
  ];
}
