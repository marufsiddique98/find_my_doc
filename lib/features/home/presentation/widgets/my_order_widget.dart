import 'package:find_my_doc/core/common/widgets/primary_button.dart';
import 'package:find_my_doc/features/home/data/models/request_doctor.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:geocoding/geocoding.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../config/constants/app_colors.dart';
import '../states/my_order_screen_states.dart';

class MyOrderWidget extends StatelessWidget {
  const MyOrderWidget({super.key, required this.requestDoctor, required this.status});
  final RequestDoctor requestDoctor;
  final String status;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(13),
      decoration: BoxDecoration(
        border: Border.all(color: AppColors.grayColorD0, width: 1),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Doctor Name: ${requestDoctor.doctor?.name}',
            style: GoogleFonts.poppins(
              color: AppColors.grayColor1E,
              fontSize: 16.sp,
              fontWeight: FontWeight.w500,
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          Text(
            'Patient Name: ${requestDoctor.patient?.name}',
            style: GoogleFonts.poppins(
              color: AppColors.grayColor1E,
              fontSize: 16.sp,
              fontWeight: FontWeight.w500,
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          Row(
            children: [
              Text(
                'Location: ',
                style: GoogleFonts.poppins(
                  color: AppColors.grayColor1E,
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w500,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              FutureBuilder(
                  future: getLocation(requestDoctor.latitude!, requestDoctor.longitude!),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      return Text(
                        snapshot.data!,
                        style: GoogleFonts.poppins(
                          color: AppColors.grayColor1E,
                          fontSize: 13.sp,
                          fontWeight: FontWeight.w400,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      );
                    }
                    return SizedBox();
                  }),
            ],
          ),
          Gap(10),
          Row(
            children: [
              Text(
                'Urgency Level: ',
                style: GoogleFonts.poppins(
                  color: AppColors.grayColor1E,
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w500,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              Container(
                padding: EdgeInsets.symmetric(vertical: 2.5, horizontal: 9.5),
                decoration: BoxDecoration(
                  color: AppColors.limePurpleColor,
                  borderRadius: BorderRadius.circular(5),
                ),
                child: Text(
                  '${requestDoctor.urgencyLevel}',
                  style: GoogleFonts.poppins(
                    color: Colors.white,
                    fontWeight: FontWeight.w400,
                    fontSize: 10.sp,
                  ),
                ),
              ),
            ],
          ),
          Gap(10),
          Row(
            children: [
              Container(
                padding: EdgeInsets.symmetric(vertical: 2.5, horizontal: 9.5),
                decoration: BoxDecoration(
                  color: AppColors.lightGreenColor,
                  borderRadius: BorderRadius.circular(5),
                ),
                child: Text(
                  '${requestDoctor.status}',
                  style: GoogleFonts.poppins(
                    color: AppColors.purpleColor,
                    fontWeight: FontWeight.w400,
                    fontSize: 10.sp,
                  ),
                ),
              ),
              Spacer(),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.watch_later,
                        size: 20.w,
                        color: AppColors.purpleColor,
                      ),
                      Gap(5),
                      Text(
                        DateFormat('hh:mm a').format(requestDoctor.createdAt!),
                        style: GoogleFonts.poppins(
                          color: AppColors.grayColor1E,
                          fontSize: 12.sp,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Icon(
                        Icons.calendar_month,
                        size: 20.w,
                        color: AppColors.purpleColor,
                      ),
                      Gap(5),
                      Text(
                        DateFormat('dd MMMM yyyy').format(requestDoctor.createdAt!),
                        style: GoogleFonts.poppins(
                          color: AppColors.grayColor1E,
                          fontSize: 12.sp,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
          if (status == 'pending') Gap(10),
          if (status == 'pending')
            Consumer(builder: (_, ref, __) {
              return PrimaryButton(
                context,
                text: 'Accept',
                onTap: () {
                  showDialog(
                      context: context,
                      builder: (ctx) => AlertDialog(
                            title: Text('Are you sure?'),
                            content: Text('Do you want to accept the request?'),
                            actions: [
                              TextButton(
                                onPressed: () {
                                  Navigator.pop(ctx);
                                },
                                child: Text('No'),
                              ),
                              TextButton(
                                onPressed: () {
                                  ref.read(doctorRequestsProvider(status).notifier).accept(requestDoctor.id!);
                                  Navigator.pop(ctx);
                                },
                                child: Text('Yes'),
                              ),
                            ],
                          ));
                },
              );
            }),
        ],
      ),
    );
  }
}

Future<String> getLocation(double latitude, double longitude) async {
  List<Placemark> placemarks = await placemarkFromCoordinates(latitude, longitude);

  return "${placemarks[0].street}, ${placemarks[0].locality}, ${placemarks[0].country}";
}
