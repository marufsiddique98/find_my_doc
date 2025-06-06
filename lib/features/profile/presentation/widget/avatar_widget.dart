import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../config/constants/app_colors.dart';
import '../../../../generated/assets.dart';
import '../states/profile_provider.dart';

class AvatarWidget extends ConsumerWidget {
  const AvatarWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final profile = ref.watch(profileProvider);
    return Row(
      children: [
        Stack(
          children: [
            CircleAvatar(
              radius: 42.5.w,
              backgroundColor: Colors.black,
            ),
            Positioned(
              right: 0,
              bottom: 0,
              child: GestureDetector(
                onTap: () {},
                child: Container(
                  padding: EdgeInsets.symmetric(vertical: 3, horizontal: 4),
                  decoration: BoxDecoration(
                    color: AppColors.purpleColor,
                    border: Border.all(color: Colors.white, width: 1),
                    borderRadius: BorderRadius.circular(7),
                  ),
                  child: SvgPicture.asset(
                    Assets.iconsEdit,
                    width: 15.w,
                  ),
                ),
              ),
            ),
          ],
        ),
        Gap(15),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                profile.value?.name ?? '',
                style: GoogleFonts.poppins(
                  fontSize: 18.sp,
                  fontWeight: FontWeight.w500,
                ),
              ),
              Text(
                'User ID: ${profile.value?.id ?? 0}',
                style: GoogleFonts.poppins(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
