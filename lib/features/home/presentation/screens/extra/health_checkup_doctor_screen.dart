import 'package:find_my_doc/core/common/widgets/my_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';

import '../../../../../config/constants/app_colors.dart';
import '../../../../../config/constants/app_strings.dart';
import '../../../../../core/common/widgets/secondary_button.dart';
import '../../../../map/presentation/screens/map_screen.dart';
import '../../../data/models/doctor.dart';
import '../../states/home_screen_states.dart';

class HealthCheckupDoctorScreen extends ConsumerWidget {
  const HealthCheckupDoctorScreen({super.key, required this.speciality});
  final String speciality;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(doctorSearchProvider);
    final notifier = ref.read(doctorSearchProvider.notifier);
    final speciality = ref.watch(specialityProvider);
    return Scaffold(
      appBar: MyAppBar(title: speciality),
      body: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: Container(
                  padding: EdgeInsets.only(left: 15),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: AppColors.grayColorD0, width: 1),
                  ),
                  child: DropdownButton<String>(
                    value: speciality,
                    items: AppString.specialties
                        .map((el) => DropdownMenuItem<String>(
                              child: Text(el),
                              value: el,
                            ))
                        .toList(),
                    onChanged: (val) {
                      ref.read(specialityProvider.notifier).state = val!;
                      notifier.changeVal(val);
                    },
                    underline: SizedBox(),
                  ),
                ),
              ),
              Gap(10),
              Container(
                decoration: BoxDecoration(
                  color: AppColors.purpleColor,
                  borderRadius: BorderRadius.circular(4),
                ),
                child: IconButton(
                  onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (_) => MapScreen())),
                  icon: Icon(
                    Icons.map,
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
          Expanded(
            child: state.when(
              data: (List<Doctor> doctors) {
                return doctors.isNotEmpty
                    ? ListView.builder(
                        shrinkWrap: true,
                        itemCount: doctors.length,
                        itemBuilder: (_, index) {
                          Doctor doctor = doctors[index];
                          return Card(
                            child: ListTile(
                              title: Text('${doctor.name}'),
                              subtitle: Text('Speciality: ${doctor.speciality}\nRating: ${doctor.ratings}✮'),
                              trailing: IconButton(
                                onPressed: () {
                                  showDialog(
                                      context: context,
                                      builder: (ctx) => AlertDialog(
                                            title: Text('Book an appointment?'),
                                            content: Text('Do you want to request for an appointment?'),
                                            actions: [
                                              SecondaryButton(
                                                context,
                                                text: 'Cancel',
                                                onTap: () {
                                                  Navigator.pop(ctx);
                                                },
                                              ),
                                              SecondaryButton(
                                                context,
                                                text: 'Book',
                                                onTap: () {
                                                  notifier.requestDoctorAppointment(doctor);
                                                  Navigator.pop(ctx);
                                                },
                                              ),
                                            ],
                                          ));
                                },
                                icon: Icon(Icons.call),
                              ),
                            ),
                          );
                        })
                    : Center(
                        child: Text('No doctors found!!'),
                      );
              },
              error: (error, t) => SizedBox(),
              loading: () => Center(child: CircularProgressIndicator()),
            ),
          ),
        ],
      ),
    );
  }
}
