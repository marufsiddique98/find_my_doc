import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../config/constants/app_colors.dart';

InkWell SecondaryButton(
  BuildContext context, {
  bool isOutlined = false,
  IconData? icon,
  bool border = false,
  required String text,
  required VoidCallback onTap,
}) {
  return InkWell(
    splashColor: isOutlined ? AppColors.purpleColor : Colors.white,
    onTap: onTap,
    child: Container(
      padding: EdgeInsets.symmetric(vertical: 7, horizontal: 16),
      decoration: BoxDecoration(
        color: isOutlined ? Colors.white : AppColors.purpleColor,
        borderRadius: BorderRadius.circular(4),
        border: Border.all(width: border ? 1 : 0, color: border ? AppColors.purpleColor : Colors.transparent),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            text,
            style: GoogleFonts.poppins(
              color: isOutlined ? AppColors.purpleColor : Colors.white,
              fontSize: 13.sp,
              fontWeight: FontWeight.w500,
            ),
          ),
          if (icon != null) Gap(10.w),
          if (icon != null) Icon(icon, size: 16.sp, color: AppColors.purpleColor)
        ],
      ),
    ),
  );
}
