import 'package:find_my_doc/features/home/data/models/request_doctor.dart';
import 'package:find_my_doc/features/map/presentation/screens/map_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tab_indicator_styler/tab_indicator_styler.dart';
import '../../../../config/constants/app_colors.dart';
import '../../../../core/common/widgets/my_app_bar.dart';

import '../states/my_order_screen_states.dart';
import '../widgets/my_order_widget.dart';

class MyOrdersScreen extends ConsumerStatefulWidget {
  const MyOrdersScreen({super.key});

  @override
  ConsumerState<MyOrdersScreen> createState() => _MyOrdersScreenState();
}

class _MyOrdersScreenState extends ConsumerState<MyOrdersScreen> with SingleTickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    final tabController = ref.watch(tabControllerProvider(this));
    final index = ref.watch(myOrderScreenTabIndexProvider);
    return Scaffold(
      appBar: MyAppBar(
        title: 'My Orders',
        back: false,
      ),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          children: [
            Container(
              color: AppColors.lightGreenColor,
              margin: EdgeInsets.only(bottom: 15),
              child: TabBar(
                padding: EdgeInsets.symmetric(vertical: 5),
                controller: tabController,
                tabs: [
                  Tab(
                    height: 40.h,
                    text: '    Pending    ',
                  ),
                  Tab(
                    height: 40.h,
                    text: '    Completed    ',
                  ),
                ],
                labelColor: Colors.white,
                unselectedLabelColor: Colors.black,
                labelStyle: GoogleFonts.poppins(
                  fontSize: 13.sp,
                  fontWeight: FontWeight.w400,
                ),
                unselectedLabelStyle: GoogleFonts.poppins(
                  fontSize: 13.sp,
                  fontWeight: FontWeight.w400,
                ),
                dividerHeight: 0,
                indicator: RectangularIndicator(
                  color: AppColors.purpleColor,
                  bottomLeftRadius: 5,
                  topLeftRadius: 5,
                  topRightRadius: 5,
                  bottomRightRadius: 5,
                ),
              ),
            ),
            if (index == 0)
              Expanded(
                child: MyOrderListWidget(status: 'pending'),
              ),
            if (index == 1)
              Expanded(
                child: MyOrderListWidget(status: 'accepted'),
              ),
            if (index == 2)
              Expanded(
                child: MyOrderListWidget(status: 'cancelled'),
              ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
          onPressed: () {
            Navigator.push(context, MaterialPageRoute(builder: (_) => MapScreen()));
          },
          label: Row(
            children: [
              Icon(Icons.add),
              Text('Book New Appointment'),
            ],
          )),
    );
  }
}

class MyOrderListWidget extends ConsumerWidget {
  const MyOrderListWidget({super.key, required this.status});
  final String status;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(doctorRequestsProvider(status));
    return state.when(
        data: (List<RequestDoctor> data) {
          return ListView.separated(
            itemCount: data.length,
            shrinkWrap: true,
            separatorBuilder: (_, i) => Gap(15),
            itemBuilder: (_, index) {
              RequestDoctor requestDoctor = data[index];
              return data.isNotEmpty ? MyOrderWidget(requestDoctor: requestDoctor) : Center(child: Text('No records found...'));
            },
          );
        },
        error: (error, t) => Center(child: Text(error.toString())),
        loading: () => Center(child: CircularProgressIndicator()));
  }
}
