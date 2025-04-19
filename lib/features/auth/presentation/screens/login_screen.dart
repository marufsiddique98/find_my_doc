import 'dart:convert';
import 'dart:developer';

import 'package:find_my_doc/features/auth/presentation/screens/doctor_signup_screen.dart';
import 'package:find_my_doc/features/auth/presentation/screens/signup_screen.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sized_context/sized_context.dart';

import '../../../../config/constants/app_colors.dart';
import '../../../../config/constants/app_strings.dart';
import '../../../../core/common/dialogs/show_loading.dart';
import '../../../../core/common/widgets/primary_button.dart';
import '../../../../generated/assets.dart';
import '../../../../main.dart';
import '../../../home/presentation/screens/home_bottom_navigation_bar.dart';
import '../../../home/presentation/screens/home_screen.dart';
import '../states/signup_provider.dart';
import '../widgets/my_input_field.dart';

class LoginScreen extends ConsumerStatefulWidget {
  const LoginScreen({super.key});

  @override
  ConsumerState<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<LoginScreen> {
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final accept = ref.watch(acceptProvider);
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.all(20),
          child: SizedBox(
            height: context.heightPx,
            width: context.widthPx,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(Assets.imagesLogo, width: 170.w),
                Gap(50),
                ...MyInputField(context, text: 'Email', controller: email),
                ...MyInputField(context, text: 'Password', controller: password),
                Transform.translate(
                  offset: Offset(-14, 0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Checkbox(
                          value: accept,
                          onChanged: (v) {
                            ref.read(acceptProvider.notifier).state = v!;
                          }),
                      Flexible(
                        child: Text.rich(
                          TextSpan(
                            text: 'By signing up you agree to our ',
                            style: GoogleFonts.poppins(
                              fontSize: 12.sp,
                              fontWeight: FontWeight.w500,
                              color: AppColors.grayColor22,
                            ),
                            children: [
                              TextSpan(
                                text: 'Terms & Conditions',
                                style: GoogleFonts.poppins(
                                  fontSize: 12.sp,
                                  fontWeight: FontWeight.w600,
                                  color: AppColors.purpleColor,
                                ),
                                recognizer: TapGestureRecognizer()
                                  ..onTap = () {
                                    print('Terms & Conditions tapped');
                                  },
                              ),
                            ],
                          ),
                          overflow: TextOverflow.visible,
                          maxLines: 2,
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 20.0, bottom: 10),
                  child: PrimaryButton(
                    context,
                    text: 'Login',
                    onTap: () async {
                      if (accept) {
                        try {
                          showLoading(context);
                          var response = await http.post(
                            Uri.parse('${AppString.baseUrl}login'),
                            body: jsonEncode({
                              "email": email.text,
                              "password": password.text,
                            }),
                          );
                          Navigator.pop(context);
                          log('Login response ==> ${response.body}');
                          if (response.statusCode == 200) {
                            storage.setToken(jsonDecode(response.body)['token']);
                            Navigator.push(context, MaterialPageRoute(builder: (_) => HomeBottomNavigationBar()));
                          } else {
                            Fluttertoast.showToast(msg: response.body);
                          }
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
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 20.0),
                  child: Text('OR'),
                ),
                PrimaryButton(
                  context,
                  text: 'Register As A Doctor',
                  onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => DoctorSignupScreen())),
                ),
                PrimaryButton(
                  context,
                  isOutlined: true,
                  text: 'Create An Account',
                  onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => SignupScreen())),
                ),
                Gap(20.h),
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
