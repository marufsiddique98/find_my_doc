import 'package:find_my_doc/core/common/extensions/sized_box_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../config/constants/app_colors.dart';
import '../states/maps_provider.dart';

class CurrentLocationForm extends ConsumerWidget {
  const CurrentLocationForm({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Column(
      children: [
        Gap(20),
        Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(
                        'Flat No. ',
                        style: GoogleFonts.poppins(fontWeight: FontWeight.w400, fontSize: 14, color: AppColors.grayColor1E),
                      ),
                      Text(
                        '*',
                        style: TextStyle(
                          color: AppColors.redColor,
                        ),
                      ),
                    ],
                  ),
                  Gap(10),
                  TextFormField(
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                    ),
                  ),
                ],
              ),
            ),
            12.horizontalSpace,
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(
                        'House No. ',
                        style: GoogleFonts.poppins(fontWeight: FontWeight.w400, fontSize: 14, color: AppColors.grayColor1E),
                      ),
                      Text(
                        '*',
                        style: TextStyle(
                          color: AppColors.redColor,
                        ),
                      ),
                    ],
                  ),
                  Gap(10),
                  TextFormField(
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        Gap(20),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Text(
                  'Road ',
                  style: GoogleFonts.poppins(fontWeight: FontWeight.w400, fontSize: 14, color: AppColors.grayColor1E),
                ),
                Text(
                  '*',
                  style: TextStyle(
                    color: AppColors.redColor,
                  ),
                ),
              ],
            ),
            Gap(10),
            TextFormField(
              decoration: InputDecoration(
                border: OutlineInputBorder(),
              ),
            ),
          ],
        ),
        Gap(20),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Text(
                  'Area ',
                  style: GoogleFonts.poppins(fontWeight: FontWeight.w400, fontSize: 14, color: AppColors.grayColor1E),
                ),
                Text(
                  '*',
                  style: TextStyle(
                    color: AppColors.redColor,
                  ),
                ),
              ],
            ),
            Gap(10),
            TextFormField(
              decoration: InputDecoration(
                border: OutlineInputBorder(),
              ),
            ),
          ],
        ),
        Transform.translate(
          offset: Offset(-14, 0),
          child: Row(
            children: [
              Checkbox.adaptive(
                value: ref.watch(saveAddressProvider),
                onChanged: (value) {
                  ref.read(saveAddressProvider.notifier).state = value!;
                },
              ),
              Text(
                'Save This Address',
                style: TextStyle(
                  fontWeight: FontWeight.w400,
                  fontSize: 12,
                  color: AppColors.grayColor1E,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
