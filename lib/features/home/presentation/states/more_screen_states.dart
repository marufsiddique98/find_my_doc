import 'package:find_my_doc/features/auth/presentation/screens/logout.dart';
import 'package:find_my_doc/features/home/presentation/screens/extra/about_us_screen.dart';
import 'package:find_my_doc/features/home/presentation/screens/extra/privacy_policy_screen.dart';
import 'package:find_my_doc/features/home/presentation/screens/extra/terms_and_conditions.dart';
import 'package:find_my_doc/features/home/presentation/screens/home_screen.dart';
import 'package:find_my_doc/features/map/presentation/screens/map_screen.dart';
import 'package:find_my_doc/features/profile/presentation/screens/profile_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../generated/assets.dart';

class MoreScreenModel {
  final String image;
  final String title;
  final Widget route;
  MoreScreenModel({required this.image, required this.title, required this.route});
}

final moreScreenProvider = Provider.autoDispose<List<MoreScreenModel>>((ref) => [
      MoreScreenModel(
        image: Assets.moreProfile,
        title: 'Your Profile',
        route: ProfileScreen(),
      ),
      MoreScreenModel(
        image: Assets.moreOrders,
        title: 'My Appointments',
        route: HomeScreen(),
      ),
      MoreScreenModel(
        image: Assets.moreMap,
        title: 'Saved Address',
        route: MapScreen(),
      ),
      MoreScreenModel(image: Assets.moreAbout, title: 'About Us', route: AboutUsPage()),
      MoreScreenModel(
        image: Assets.moreTerms,
        title: 'Terms & Conditions',
        route: TermsAndConditionsPage(),
      ),
      MoreScreenModel(
        image: Assets.morePrivacy,
        title: 'Privacy Policy',
        route: PrivacyPolicyPage(),
      ),
      MoreScreenModel(
        image: Assets.moreLogout,
        title: 'Log Out',
        route: Logout(),
      ),
    ]);
