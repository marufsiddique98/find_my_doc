import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import '../../../../core/common/widgets/my_app_bar.dart';
import '../../../../core/common/widgets/primary_button.dart';
import '../widgets/current_location_form.dart';
import '../widgets/current_location_map_widget.dart';

class CurrentLocationScreen extends StatelessWidget {
  const CurrentLocationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(title: 'Your Location'),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(12),
        child: Column(
          children: [
            CurrentLocationMapWidget(),
            CurrentLocationForm(),
            Gap(90.h),
          ],
        ),
      ),
      bottomSheet: Container(
        padding: EdgeInsets.only(left: 20.w, right: 20.w, bottom: 15.h),
        child: PrimaryButton(
          context,
          text: 'Continue',
          onTap: () {},
        ),
      ),
    );
  }
}
