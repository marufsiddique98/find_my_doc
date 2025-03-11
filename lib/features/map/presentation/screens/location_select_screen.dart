import 'package:find_my_doc/features/map/presentation/screens/current_location_screen.dart';
import 'package:find_my_doc/features/map/presentation/screens/map_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../config/constants/app_colors.dart';
import '../../../../core/common/widgets/my_app_bar.dart';
import '../../../../core/common/widgets/primary_button.dart';
import '../../../../generated/assets.dart';

class LocationSelectScreen extends StatelessWidget {
  const LocationSelectScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(title: 'Your Location'),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextFormField(
              decoration: InputDecoration(
                prefixIcon: Padding(
                  padding: const EdgeInsets.only(left: 8.0, right: 20),
                  child: Icon(Icons.pin_drop_outlined),
                ),
                hintText: 'Enter Address',
                hintStyle: GoogleFonts.poppins(fontSize: 14, fontWeight: FontWeight.w400),
                prefixIconConstraints: BoxConstraints(minWidth: 0, minHeight: 0),
              ),
            ),
            Gap(20),
            Row(
              children: [
                Expanded(
                  child: PrimaryButton(
                    context,
                    text: 'Current Location',
                    fontSize: 14.sp,
                    icon: Icons.send,
                    iconColor: Colors.white,
                    iconLeft: true,
                    iconSize: 15.sp,
                    onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => CurrentLocationScreen())),
                  ),
                ),
                Gap(7),
                Expanded(
                  child: PrimaryButton(
                    context,
                    isOutlined: true,
                    text: 'Choose On Map',
                    fontSize: 14.sp,
                    icon: Icons.map_outlined,
                    iconColor: AppColors.purpleColor,
                    iconLeft: true,
                    iconSize: 15.sp,
                    onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => MapScreen())),
                  ),
                ),
              ],
            ),
            Gap(20),
            Text(
              'Recent Search',
              style: GoogleFonts.poppins(
                fontWeight: FontWeight.w600,
                fontSize: 14,
                color: AppColors.grayColor1E,
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(vertical: 16, horizontal: 20),
              margin: EdgeInsets.symmetric(vertical: 20),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                border: Border.all(
                  width: 1.5,
                  color: AppColors.grayColorD0,
                ),
              ),
              child: Row(
                children: [
                  SvgPicture.asset(Assets.iconsSmallLocation),
                  Gap(10.w),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'N-35 Karakoram Hwy',
                        style: GoogleFonts.poppins(
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w400,
                          color: AppColors.grayColor1E,
                        ),
                      ),
                      Text(
                        'Mirpur-1, Dhaka',
                        style: GoogleFonts.poppins(
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w400,
                          color: AppColors.grayColor63,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Text(
              'Saved Address',
              style: GoogleFonts.poppins(
                fontWeight: FontWeight.w600,
                fontSize: 14.sp,
                color: AppColors.grayColor1E,
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(vertical: 16, horizontal: 20),
              margin: EdgeInsets.symmetric(vertical: 10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                border: Border.all(
                  width: 1.5.w,
                  color: AppColors.purpleColor,
                ),
              ),
              child: Row(
                children: [
                  SvgPicture.asset(Assets.iconsSmallMarker),
                  Gap(10),
                  Expanded(
                    child: Text(
                      'House 57, Road 25, Block A, Banani, Dhaka Banani, Dhaka ',
                      style: GoogleFonts.poppins(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w400,
                        color: AppColors.grayColor1E,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            PrimaryButton(
              context,
              isOutlined: true,
              text: 'Add New Address',
              onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => MapScreen())),
            ),
          ],
        ),
      ),
    );
  }
}
