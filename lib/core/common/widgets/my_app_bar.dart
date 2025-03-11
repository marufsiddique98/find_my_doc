import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../config/constants/app_colors.dart';

class MyAppBar extends StatelessWidget implements PreferredSizeWidget {
  const MyAppBar({super.key, required this.title, this.back = true});
  final String title;
  final bool back;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(
        title,
        style: GoogleFonts.poppins(
          color: AppColors.grayColor1E,
          fontWeight: FontWeight.w500,
          fontSize: 16.sp,
        ),
      ),
      centerTitle: true,
      leading: back
          ? IconButton(
              onPressed: () => Navigator.pop(context),
              icon: Icon(Icons.keyboard_arrow_left),
            )
          : SizedBox.shrink(),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}
