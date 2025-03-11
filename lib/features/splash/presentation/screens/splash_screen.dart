import 'package:find_my_doc/features/auth/presentation/screens/login_screen.dart';
import 'package:find_my_doc/features/home/presentation/screens/home_bottom_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:sized_context/sized_context.dart';
import '../../../../generated/assets.dart';
import '../../../../main.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    moveToNextScreen();
  }

  void moveToNextScreen() async {
    await Future.delayed(Duration(seconds: 3));
    if (storage.getToken() == null) {
      Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (_) => LoginScreen()), (r) => false);
    } else {
      Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (_) => HomeBottomNavigationBar()), (r) => false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Image.asset(
          Assets.imagesLogo,
          width: context.widthPx * .6,
        ).animate().fade(duration: Duration(seconds: 3)),
      ),
    );
  }
}
