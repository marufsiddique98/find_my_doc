import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../states/more_screen_states.dart';

import '../../../../config/constants/app_colors.dart';

class MoreScreenListWidget extends ConsumerWidget {
  const MoreScreenListWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final screens = ref.read(moreScreenProvider);

    return ListView.separated(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      separatorBuilder: (_, index) => Divider(
        thickness: 0,
        height: 0,
      ),
      itemBuilder: (_, index) {
        final screen = screens[index];
        return ListTile(
          onTap: () {
            Navigator.push(context, MaterialPageRoute(builder: (_) => screen.route));
          },
          leading: Container(
            padding: EdgeInsets.all(3),
            decoration: BoxDecoration(
              color: AppColors.purpleColor.withAlpha(40),
              borderRadius: BorderRadius.circular(20),
            ),
            child: SvgPicture.asset(
              screen.image,
              color: AppColors.purpleColor,
            ),
          ),
          title: Text(screen.title, style: TextStyle(fontSize: 16.sp)),
          trailing: Icon(
            Icons.chevron_right,
            color: AppColors.grayColor91,
          ),
        );
      },
      itemCount: screens.length,
    );
  }
}
