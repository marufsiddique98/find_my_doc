import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sized_context/sized_context.dart';

import '../../../config/constants/app_colors.dart';

ElevatedButton PrimaryButton(
  BuildContext context, {
  bool isOutlined = false,
  required String text,
  required VoidCallback onTap,
  bool fullWidth = true,
  bool outlineBorder = true,
  bool iconLeft = false,
  IconData? icon,
  double? fontSize,
  Color? iconColor,
  double? iconSize,
}) {
  return ElevatedButton(
    onPressed: onTap,
    child: icon == null
        ? Text(
            text,
            style: GoogleFonts.poppins(
              fontWeight: FontWeight.w500,
              fontSize: fontSize?.sp ?? 14.sp,
              color: isOutlined ? AppColors.purpleColor : Colors.white,
            ),
          )
        : iconLeft
            ? Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    icon,
                    color: iconColor ?? AppColors.purpleColor,
                    size: iconSize?.sp ?? 20.sp,
                  ),
                  Gap(5),
                  Text(
                    text,
                    style: GoogleFonts.poppins(
                      fontWeight: FontWeight.w500,
                      fontSize: fontSize?.sp ?? 14.sp,
                      color: isOutlined ? AppColors.purpleColor : Colors.white,
                    ),
                  ),
                ],
              )
            : Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    text,
                    style: GoogleFonts.poppins(
                      fontWeight: FontWeight.w500,
                      fontSize: fontSize?.sp ?? 14.sp,
                      color: isOutlined ? AppColors.purpleColor : Colors.white,
                    ),
                  ),
                  Gap(5),
                  Icon(
                    icon,
                    color: iconColor ?? AppColors.purpleColor,
                    size: iconSize?.sp ?? 20.sp,
                  ),
                ],
              ),
    style: fullWidth
        ? ElevatedButton.styleFrom(
            padding: EdgeInsets.symmetric(vertical: 8, horizontal: 14),
            elevation: isOutlined ? 0 : 1,
            fixedSize: Size.fromWidth(context.widthPx),
            backgroundColor: isOutlined ? Colors.white : AppColors.purpleColor,
            shape: RoundedRectangleBorder(
              side: BorderSide(
                width: isOutlined && outlineBorder ? 1.5 : 0,
                color: isOutlined ? AppColors.purpleColor : Colors.transparent,
              ),
              borderRadius: BorderRadius.circular(8),
            ),
          )
        : ElevatedButton.styleFrom(
            padding: EdgeInsets.symmetric(vertical: 8, horizontal: 14),
            elevation: isOutlined ? 0 : 1,
            backgroundColor: isOutlined ? Colors.white : AppColors.purpleColor,
            shape: RoundedRectangleBorder(
              side: BorderSide(
                width: isOutlined && outlineBorder ? 1 : 0,
                color: isOutlined ? AppColors.purpleColor : Colors.transparent,
              ),
              borderRadius: BorderRadius.circular(8),
            ),
          ),
  );
}
