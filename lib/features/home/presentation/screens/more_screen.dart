import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import '../../../../config/constants/app_colors.dart';
import '../../../../core/common/widgets/my_app_bar.dart';
import '../../../../generated/assets.dart';
import '../../../profile/presentation/widget/avatar_widget.dart';
import '../widgets/more_screen_list_widget.dart';

class MoreScreen extends StatelessWidget {
  const MoreScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(
        title: 'More',
        back: false,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(vertical: 20, horizontal: 14),
        child: Column(
          children: [
            AvatarWidget(),
            Gap(40),
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: AppColors.grayColorD0, width: 1),
              ),
              child: MoreScreenListWidget(),
            ),
            Gap(30),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SvgPicture.asset(
                  Assets.iconsX,
                  width: 32.w,
                ),
                Gap(20),
                SvgPicture.asset(
                  Assets.iconsInstagram,
                  width: 32.w,
                ),
                Gap(20),
                SvgPicture.asset(
                  Assets.iconsYoutube,
                  width: 32.w,
                ),
                Gap(20),
                SvgPicture.asset(
                  Assets.iconsFacebook,
                  width: 32.w,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
