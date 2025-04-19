import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../config/constants/app_colors.dart';
import '../states/home_screen_states.dart';

class HomeBottomNavigationBar extends ConsumerWidget {
  const HomeBottomNavigationBar({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final index = ref.watch(bottomNavigationProvider);
    final indexNotifier = ref.read(bottomNavigationProvider.notifier);
    final screen = ref.watch(bottomNavigationWidgetProvider);

    return Scaffold(
      body: WillPopScope(
        onWillPop: () async {
          if (index == 0) {
            bool canPop = await showDialog(
                context: context,
                builder: (_) => AlertDialog(
                      title: Text('Are you sure?'),
                      content: Text('Do you want to exit the app?'),
                      actions: [
                        TextButton(
                            onPressed: () {
                              Navigator.pop(context, false);
                            },
                            child: Text('No')),
                        TextButton(
                            onPressed: () {
                              Navigator.pop(context, true);
                            },
                            child: Text('Yes')),
                      ],
                    ));
            return canPop;
          } else {
            indexNotifier.updateIndex(0);
            return false;
          }
        },
        child: screen,
      ),
      bottomNavigationBar: SizedBox(
        height: kBottomNavigationBarHeight + 20,
        child: BottomNavigationBar(
          currentIndex: index,
          type: BottomNavigationBarType.fixed,
          onTap: (i) => indexNotifier.updateIndex(i),
          selectedItemColor: AppColors.purpleColor,
          unselectedItemColor: AppColors.grayColorA2,
          showUnselectedLabels: true,
          items: [
            BottomNavigationBarItem(
                icon: Icon(
                  Icons.home_filled,
                  size: 24.w,
                  color: index == 0 ? AppColors.purpleColor : AppColors.grayColorA7,
                ),
                label: 'Home'),
            BottomNavigationBarItem(
                icon: Icon(
                  Icons.calendar_today,
                  size: 24.w,
                  color: index == 1 ? AppColors.purpleColor : AppColors.grayColorA7,
                ),
                label: 'Appointments'),
            BottomNavigationBarItem(
                icon: Icon(
                  Icons.check_circle,
                  size: 24.w,
                  color: index == 2 ? AppColors.purpleColor : AppColors.grayColorA7,
                ),
                label: 'Healthcheck'),
            BottomNavigationBarItem(
                icon: Icon(
                  Icons.person,
                  size: 24.w,
                  color: index == 3 ? AppColors.purpleColor : AppColors.grayColorA7,
                ),
                label: 'Account'),
          ],
        ),
      ),
    );
  }
}
