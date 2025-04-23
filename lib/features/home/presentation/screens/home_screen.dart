import 'package:find_my_doc/config/constants/app_colors.dart';
import 'package:find_my_doc/features/home/presentation/screens/health_check_screen.dart';
import 'package:find_my_doc/features/map/presentation/screens/map_screen.dart';
import 'package:find_my_doc/features/notification/presentation/notification_screen.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import '../../../../generated/assets.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Image.asset(
          Assets.imagesLogo,
          height: kToolbarHeight - 20,
        ),
        actions: [
          IconButton(
            onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (_) => NotificationScreen())),
            icon: Icon(Icons.notifications_none),
          ),
          GestureDetector(
            onTap: () {},
            child: CircleAvatar(),
          ),
          Gap(12),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ShaderMask(
              shaderCallback: (Rect bounds) {
                return const LinearGradient(
                  colors: [Colors.red, Colors.cyan],
                  begin: Alignment.topRight,
                  end: Alignment.bottomLeft,
                ).createShader(bounds);
              },
              child: Icon(
                Icons.favorite,
                size: 75,
                color: Colors.white,
              ),
            ),
            Text(
              'We\'re Here\nHow Can We Help?',
              style: TextStyle(
                fontSize: 26,
                fontWeight: FontWeight.w500,
              ),
            ),
            Gap(25),
            Row(
              children: [
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      Navigator.push(context, MaterialPageRoute(builder: (_) => HealthCheckScreen()));
                    },
                    child: Card(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 28.0, horizontal: 15),
                        child: Column(
                          children: [
                            Text(
                              'Check Symptoms',
                              style: TextStyle(
                                color: AppColors.purpleColor,
                                fontSize: 20,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            Divider(),
                            Text('For quick information'),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      Navigator.push(context, MaterialPageRoute(builder: (_) => MapScreen()));
                    },
                    child: Card(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 28.0, horizontal: 15),
                        child: Column(
                          children: [
                            Text(
                              'Book Appointments',
                              style: TextStyle(
                                color: AppColors.purpleColor,
                                fontSize: 20,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            Divider(),
                            Text('To speak to a doctor'),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),

            // Row(
            //   children: [
            //     Expanded(
            //       child: Container(
            //         padding: EdgeInsets.only(left: 15),
            //         decoration: BoxDecoration(
            //           borderRadius: BorderRadius.circular(8),
            //           border: Border.all(color: AppColors.grayColorD0, width: 1),
            //         ),
            //         child: DropdownButton<String>(
            //           value: speciality,
            //           items: AppString.specialties
            //               .map((el) => DropdownMenuItem<String>(
            //                     child: Text(el),
            //                     value: el,
            //                   ))
            //               .toList(),
            //           onChanged: (val) {
            //             ref.read(specialityProvider.notifier).state = val!;
            //             notifier.changeVal(val);
            //           },
            //           underline: SizedBox(),
            //         ),
            //       ),
            //     ),
            //     Gap(10),
            //     Container(
            //       decoration: BoxDecoration(
            //         color: AppColors.purpleColor,
            //         borderRadius: BorderRadius.circular(4),
            //       ),
            //       child: IconButton(
            //         onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (_) => MapScreen())),
            //         icon: Icon(
            //           Icons.map,
            //           color: Colors.white,
            //         ),
            //       ),
            //     ),
            //   ],
            // ),
            // Expanded(
            //   child: state.when(
            //     data: (List<Doctor> doctors) {
            //       return doctors.isNotEmpty
            //           ? ListView.builder(
            //               shrinkWrap: true,
            //               itemCount: doctors.length,
            //               itemBuilder: (_, index) {
            //                 Doctor doctor = doctors[index];
            //                 return Card(
            //                   child: ListTile(
            //                     title: Text('${doctor.name}'),
            //                     subtitle: Text('Speciality: ${doctor.speciality}\nRating: ${doctor.ratings}✮'),
            //                     trailing: IconButton(
            //                       onPressed: () {
            //                         showDialog(
            //                             context: context,
            //                             builder: (ctx) => AlertDialog(
            //                                   title: Text('Book an appointment?'),
            //                                   content: Text('Do you want to request for an appointment?'),
            //                                   actions: [
            //                                     SecondaryButton(
            //                                       context,
            //                                       text: 'Cancel',
            //                                       onTap: () {
            //                                         Navigator.pop(ctx);
            //                                       },
            //                                     ),
            //                                     SecondaryButton(
            //                                       context,
            //                                       text: 'Book',
            //                                       onTap: () {
            //                                         notifier.requestDoctorAppointment(doctor);
            //                                         Navigator.pop(ctx);
            //                                       },
            //                                     ),
            //                                   ],
            //                                 ));
            //                       },
            //                       icon: Icon(Icons.call),
            //                     ),
            //                   ),
            //                 );
            //               })
            //           : Center(
            //               child: Text('No doctors found!!'),
            //             );
            //     },
            //     error: (error, t) => SizedBox(),
            //     loading: () => Center(child: CircularProgressIndicator()),
            //   ),
            // ),
          ],
        ),
      ),
    );
  }
}
