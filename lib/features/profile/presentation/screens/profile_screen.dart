import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../config/constants/app_colors.dart';
import '../../../../core/common/widgets/my_app_bar.dart';
import '../states/profile_provider.dart';
import '../widget/avatar_widget.dart';

import '../../../../generated/assets.dart';

class ProfileScreen extends ConsumerWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final profile = ref.watch(profileProvider);
    return Scaffold(
      appBar: MyAppBar(title: 'Your Profile'),
      body: ListView(
        padding: EdgeInsets.symmetric(vertical: 20, horizontal: 14),
        children: [
          AvatarWidget(),
          Gap(30),
          ProfileDataWidget(
            title: 'Name',
            value: profile.value?.name ?? '',
            onEdit: () {
              showDialog(
                  context: context,
                  builder: (ctx) => AlertDialog(
                        title: Text('Edit your name'),
                        content: TextFormField(
                          decoration: InputDecoration(
                            hintText: 'Enter your name',
                          ),
                        ),
                        actions: [
                          TextButton(
                            onPressed: () {
                              Navigator.pop(ctx);
                            },
                            child: Text('Cancel'),
                          ),
                          TextButton(
                            onPressed: () {
                              Navigator.pop(ctx);
                            },
                            child: Text('Update'),
                          ),
                        ],
                      ));
            },
          ),
          ProfileDataWidget(
            title: 'Rating',
            value: '${profile.value?.ratings ?? 0}',
            canEdit: false,
          ),
          if (profile.value?.speciality != null)
            ProfileDataWidget(
              title: 'Speciality',
              value: profile.value?.speciality ?? '',
              canEdit: false,
            )
          // ProfileDataWidget(
          //   canEdit: false,
          //   title: 'Mobile Number',
          //   value: '01848188117',
          //   onEdit: () {},
          // ),
          // ProfileDataWidget(
          //   title: 'Email',
          //   value: 'hoqueway@gmail.com',
          //   onEdit: () {
          //     showDialog(
          //         context: context,
          //         builder: (ctx) => AlertDialog(
          //               title: Text('Edit your email'),
          //               content: TextFormField(
          //                 decoration: InputDecoration(
          //                   hintText: 'Enter your email',
          //                 ),
          //               ),
          //               actions: [
          //                 TextButton(
          //                   onPressed: () {
          //                     Navigator.pop(ctx);
          //                   },
          //                   child: Text('Cancel'),
          //                 ),
          //                 TextButton(
          //                   onPressed: () {
          //                     Navigator.pop(ctx);
          //                   },
          //                   child: Text('Update'),
          //                 ),
          //               ],
          //             ));
          //   },
          // ),
          // ProfileDataWidget(
          //   title: 'Gender',
          //   value: 'Male',
          //   onEdit: () async {},
          // ),
          // ProfileDataWidget(
          //   title: 'Date of Birth',
          //   value: '2001-1-07-02',
          //   onEdit: () {
          //     showDatePicker(
          //       context: context,
          //       firstDate: DateTime(1900),
          //       lastDate: DateTime.now(),
          //       initialEntryMode: DatePickerEntryMode.calendarOnly,
          //       confirmText: 'Update',
          //       helpText: '',
          //       builder: (BuildContext context, Widget? child) {
          //         return Theme(
          //           data: ThemeData.light().copyWith(
          //             primaryColor: Colors.green,
          //             colorScheme: ColorScheme.light(primary: Colors.green),
          //             dialogTheme: DialogTheme(
          //               shape: RoundedRectangleBorder(
          //                 borderRadius: BorderRadius.circular(8),
          //               ),
          //             ),
          //             textButtonTheme: TextButtonThemeData(
          //               style: ButtonStyle(
          //                 backgroundColor: WidgetStateProperty.all(AppColors.purpleColor),
          //                 foregroundColor: WidgetStateProperty.all(Colors.white),
          //                 padding: WidgetStateProperty.all(EdgeInsets.symmetric(horizontal: 24, vertical: 12)),
          //                 shape: WidgetStateProperty.all(RoundedRectangleBorder(borderRadius: BorderRadius.circular(8))),
          //               ),
          //             ),
          //           ),
          //           child: child!,
          //         );
          //       },
          //     );
          //   },
          // ),
        ],
      ),
    );
  }
}

class ProfileDataWidget extends StatelessWidget {
  const ProfileDataWidget({super.key, this.canEdit = true, this.onEdit, required this.title, required this.value});
  final bool canEdit;
  final VoidCallback? onEdit;
  final String title, value;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 12, horizontal: 18),
      margin: EdgeInsets.symmetric(vertical: 10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: AppColors.grayColorD0, width: 1.5),
      ),
      child: Row(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: GoogleFonts.poppins(
                  fontWeight: FontWeight.w500,
                  fontSize: 12,
                  color: AppColors.grayColorA7,
                ),
              ),
              Text(
                value,
                style: GoogleFonts.poppins(
                  fontWeight: FontWeight.w500,
                  fontSize: 14,
                  color: AppColors.grayColor1E,
                ),
              ),
            ],
          ),
          Spacer(),
          if (canEdit)
            IconButton(
              onPressed: onEdit,
              icon: SvgPicture.asset(Assets.iconsPen),
            ),
        ],
      ),
    );
  }
}
