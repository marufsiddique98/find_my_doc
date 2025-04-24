import 'dart:convert';
import 'dart:developer';

import 'package:find_my_doc/features/auth/presentation/screens/login_screen.dart';
import 'package:find_my_doc/features/auth/presentation/screens/verification_screen.dart';
import 'package:find_my_doc/features/home/presentation/screens/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sized_context/sized_context.dart';
import '../../../../config/constants/app_colors.dart';
import '../../../../config/constants/app_strings.dart';
import '../../../../core/common/dialogs/show_loading.dart';
import '../../../home/presentation/screens/home_bottom_navigation_bar.dart';
import '../states/signup_provider.dart';
import 'package:geolocator/geolocator.dart';
import '../../../../core/common/widgets/primary_button.dart';
import '../../../../generated/assets.dart';
import '../../../../main.dart';
import '../widgets/my_input_field.dart';
import 'package:http/http.dart' as http;

class DoctorSignupScreen extends ConsumerStatefulWidget {
  const DoctorSignupScreen({super.key});

  @override
  ConsumerState<DoctorSignupScreen> createState() => _DoctorSignupScreenState();
}

class _DoctorSignupScreenState extends ConsumerState<DoctorSignupScreen> {
  TextEditingController name = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController cpassword = TextEditingController();
  String speciality = AppString.specialties[0];

  @override
  Widget build(BuildContext context) {
    final accept = ref.watch(acceptProvider);
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 14),
          child: SizedBox(
            width: context.widthPx,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Gap(40.h),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Sign Up',
                      style: GoogleFonts.poppins(
                        fontSize: 18.h,
                        fontWeight: FontWeight.w600,
                        color: AppColors.purpleColor,
                      ),
                    ),
                  ],
                ),
                Gap(40),
                ...MyInputField(context, text: 'Full Name', controller: name),
                ...MyInputField(context, text: 'Email', controller: email),
                ...MyInputField(context, text: 'Password', controller: password),
                ...MyInputField(context, text: 'Confirm Password', controller: cpassword),
                Gap(10),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 15),
                  width: context.widthPx,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: AppColors.grayColorD0, width: 1),
                  ),
                  child: DropdownButton<String>(
                    isExpanded: true,
                    value: speciality,
                    items: AppString.specialties
                        .map((el) => DropdownMenuItem<String>(
                              child: Text(el),
                              value: el,
                            ))
                        .toList(),
                    onChanged: (val) => setState(() {
                      speciality = val!;
                    }),
                    underline: SizedBox(),
                  ),
                ),
                Transform.translate(
                  offset: Offset(-14, 0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Checkbox(
                          value: accept,
                          onChanged: (v) {
                            ref.read(acceptProvider.notifier).state = v!;
                          }),
                      Flexible(
                        child: RichText(
                          text: TextSpan(
                            style: GoogleFonts.poppins(
                              fontSize: 12.sp,
                              fontWeight: FontWeight.w500,
                              color: AppColors.grayColor22,
                            ),
                            children: [
                              TextSpan(text: 'By signing up you agree to our '),
                              TextSpan(
                                text: 'Terms & Conditions',
                                style: GoogleFonts.poppins(
                                  fontSize: 12.sp,
                                  fontWeight: FontWeight.w600,
                                  color: AppColors.purpleColor,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                PrimaryButton(
                  context,
                  text: 'Sign Up',
                  onTap: () async {
                    if (accept) {
                      try {
                        log('message');
                        showLoading(context);
                        var position = await determinePosition();
                        var response = await http.post(
                          Uri.parse('${AppString.baseUrl}register'),
                          body: jsonEncode({
                            "email": email.text,
                            "password": password.text,
                            "name": name.text,
                            "speciality": speciality,
                            "latitude": position.latitude,
                            "longitude": position.longitude,
                            "role": "doctor"
                          }),
                        );
                        var res = await http.post(
                          Uri.parse('${AppString.baseUrl}login'),
                          body: jsonEncode({
                            "email": email.text,
                            "password": password.text,
                          }),
                        );
                        Navigator.pop(context);
                        Navigator.push(context, MaterialPageRoute(builder: (_) => VerificationScreen(email: email.text)));
                      } catch (e) {
                        Navigator.pop(context);
                        log(e.toString());
                        Fluttertoast.showToast(msg: e.toString());
                      }
                    } else {
                      Fluttertoast.showToast(msg: 'Please accept the terms and conditions');
                    }
                  },
                ),
                Gap(40.h),
                Row(
                  children: [
                    Spacer(),
                    Text(
                      'Already You Have An Account? ',
                      style: GoogleFonts.poppins(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w500,
                        color: AppColors.grayColor22,
                      ),
                    ),
                    GestureDetector(
                      onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => LoginScreen())),
                      child: Text(
                        'Sign In',
                        style: GoogleFonts.poppins(
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w600,
                          color: AppColors.purpleColor,
                        ),
                      ),
                    ),
                    Spacer(),
                  ],
                ),
                Gap(20),
                Image.asset(
                  Assets.imagesFooter,
                  width: context.widthPx,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

Future<Position> determinePosition() async {
  bool serviceEnabled;
  LocationPermission permission;

  serviceEnabled = await Geolocator.isLocationServiceEnabled();
  if (!serviceEnabled) {
    return Future.error('Location services are disabled.');
  }

  permission = await Geolocator.checkPermission();
  if (permission == LocationPermission.denied) {
    permission = await Geolocator.requestPermission();
    if (permission == LocationPermission.denied) {
      return Future.error('Location permissions are denied');
    }
  }

  if (permission == LocationPermission.deniedForever) {
    return Future.error('Location permissions are permanently denied, we cannot request permissions.');
  }
  return await Geolocator.getCurrentPosition();
}
