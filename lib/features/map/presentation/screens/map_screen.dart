import 'dart:convert';

import 'package:find_my_doc/features/home/data/models/doctor.dart';
import 'package:flutter/material.dart';
import 'package:flutter_osm_plugin/flutter_osm_plugin.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../config/constants/app_colors.dart';
import '../../../../config/constants/app_strings.dart';
import '../../../../core/common/widgets/secondary_button.dart';
import '../../../auth/presentation/screens/doctor_signup_screen.dart';
import '../../../home/presentation/states/home_screen_states.dart';

class MapScreen extends ConsumerStatefulWidget {
  const MapScreen({super.key});

  @override
  ConsumerState<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends ConsumerState<MapScreen> {
  MapController mapController = MapController.withPosition(
    initPosition: GeoPoint(latitude: 29, longitude: 89),
  );

  TextEditingController searchController = TextEditingController();
  String searchText = '';
  FocusNode searchFocus = FocusNode();
  List<Doctor> doctors = [];
  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(milliseconds: 200), () {
      mapController.init();
      getLocation();
      mapController.listenerMapSingleTapping.addListener(() async {
        GeoPoint? tappedPoint = mapController.listenerMapSingleTapping.value;
        if (tappedPoint != null) {
          Doctor? selectedDoctor = doctors.firstWhere(
            (doctor) => doctor.latitude == tappedPoint.latitude && doctor.longitude == tappedPoint.longitude,
            orElse: () => Doctor(),
          );

          if (selectedDoctor.name != null) {
            showDoctorDetails(selectedDoctor);
          }
        }
      });
    });
  }

  void getLocation() async {
    try {
      Position position = await determinePosition();

      setState(() {
        mapController.moveTo(GeoPoint(latitude: position.latitude, longitude: position.longitude));
      });

      List<Placemark> placemarks = await placemarkFromCoordinates(position.latitude, position.longitude);

      setState(() {
        searchText = "${placemarks[0].street}, ${placemarks[0].locality}, ${placemarks[0].country}";
        searchController.text = searchText;
      });
      addMarkers();
    } catch (e) {
      print("Error in getLocation(): $e");
    }
  }

  void addMarkers() async {
    print('add marker');
    Position position = await determinePosition();
    String res = await getDoctorSearchData(position: position);
    await mapController.addMarker(
      GeoPoint(latitude: position.latitude!, longitude: position.longitude!),
      markerIcon: MarkerIcon(
        iconWidget: Icon(
          Icons.person_pin_circle,
          color: Colors.blue,
          size: 56,
        ),
      ),
    );
    doctors.clear();
    List<Doctor> docs = List<Doctor>.from(jsonDecode(res).map((el) => Doctor.fromJson(el)).toList());
    doctors.addAll(docs);

    for (Doctor doctor in docs) {
      await mapController.addMarker(
        GeoPoint(latitude: doctor.latitude!, longitude: doctor.longitude!),
        markerIcon: MarkerIcon(
          iconWidget: Icon(
            Icons.person_pin_circle,
            color: Colors.blue,
            size: 56,
          ),
        ),
      );
    }
  }

  void showDoctorDetails(Doctor doctor) {
    showModalBottomSheet(
      context: context,
      builder: (_) => Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(doctor.name ?? "Unknown Doctor"),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(doctorSearchProvider);
    final notifier = ref.read(doctorSearchProvider.notifier);
    final speciality = ref.watch(specialityProvider);
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Stack(
        children: [
          OSMFlutter(
              controller: mapController,
              osmOption: OSMOption(
                  userTrackingOption: UserTrackingOption(
                    enableTracking: true,
                    unFollowUser: false,
                  ),
                  zoomOption: ZoomOption(
                    initZoom: 8,
                    minZoomLevel: 3,
                    maxZoomLevel: 19,
                    stepZoom: 1.0,
                  ),
                  userLocationMarker: UserLocationMaker(
                    personMarker: MarkerIcon(
                      icon: Icon(
                        Icons.location_history_rounded,
                        color: Colors.red,
                        size: 48,
                      ),
                    ),
                    directionArrowMarker: MarkerIcon(
                      icon: Icon(
                        Icons.double_arrow,
                        size: 48,
                      ),
                    ),
                  ),
                  isPicker: true,
                  roadConfiguration: RoadOption(
                    roadColor: AppColors.purpleColor,
                  ))),
          SafeArea(
            child: Container(
              padding: EdgeInsets.only(top: 10.h, left: 25.w, right: 25.w),
              width: double.infinity,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    children: [
                      Container(
                        decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(8)),
                        child: IconButton(
                          onPressed: () {
                            showModalBottomSheet(
                              context: context,
                              builder: (_) => Container(
                                color: Colors.white,
                                child: state.when(
                                  data: (List<Doctor> doctors) {
                                    return doctors.isNotEmpty
                                        ? ListView.builder(
                                            shrinkWrap: true,
                                            itemCount: doctors.length,
                                            itemBuilder: (_, index) {
                                              Doctor doctor = doctors[index];
                                              return Card(
                                                color: AppColors.lightGreenColor.withAlpha(60),
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
                            );
                          },
                          icon: Icon(Icons.person),
                        ),
                      ),
                      Gap(10.w),
                      Expanded(
                        child: TextFormField(
                          focusNode: searchFocus,
                          controller: searchController,
                          decoration: InputDecoration(
                            hintText: 'Search location',
                            hintStyle: GoogleFonts.poppins(fontSize: 16.sp, fontWeight: FontWeight.w400, color: AppColors.grayColor63),
                            filled: true,
                            fillColor: Colors.white,
                            prefixIcon: Icon(Icons.location_on_outlined, color: AppColors.grayColor1E, size: 22.w),
                            border: OutlineInputBorder(gapPadding: 0, borderSide: BorderSide.none, borderRadius: BorderRadius.circular(8)),
                            contentPadding: EdgeInsets.zero,
                          ),
                        ),
                      ),
                      Gap(10.w),
                      Container(
                        decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(8)),
                        child: IconButton(
                          onPressed: () {
                            if (searchFocus.hasFocus) {
                              searchFocus.unfocus();
                            }
                          },
                          icon: Icon(Icons.close),
                        ),
                      ),
                    ],
                  ),
                  // if (searchFocus.hasFocus)
                  //   Container(
                  //     margin: EdgeInsets.only(top: 10.h),
                  //     decoration: BoxDecoration(
                  //         color: Colors.white,
                  //         borderRadius: BorderRadius.circular(8)),
                  //     child: ListView.builder(
                  //         itemCount: 3,
                  //         shrinkWrap: true,
                  //         itemBuilder: (_, index) {
                  //           return ListTile(
                  //             title: Text(
                  //               'N-35 Karakoram Hwy',
                  //               style: GoogleFonts.poppins(
                  //                   color: AppColors.grayColor1E,
                  //                   fontSize: 14.sp,
                  //                   fontWeight: FontWeight.w400),
                  //             ),
                  //             subtitle: Text(
                  //               'Mirpur-1, Dhaka',
                  //               style: GoogleFonts.poppins(
                  //                   color: AppColors.grayColor63,
                  //                   fontSize: 14.sp,
                  //                   fontWeight: FontWeight.w400),
                  //             ),
                  //           );
                  //         }),
                  //   ),
                ],
              ),
            ),
          ),
        ],
      ),
      bottomSheet: Container(
        margin: EdgeInsets.only(left: 25.w, right: 25.w, bottom: 25.h, top: 40.h),
        padding: EdgeInsets.only(left: 15),
        decoration: BoxDecoration(
          color: Colors.white,
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
      floatingActionButton: FloatingActionButton(
        child: Icon(
          Icons.my_location,
          color: Colors.white,
        ),
        backgroundColor: AppColors.purpleColor,
        shape: CircleBorder(),
        elevation: 0,
        onPressed: getLocation,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      // bottomSheet: Container(
      //   color: Colors.transparent, // 50% transparency
      //   padding: EdgeInsets.only(left: 25.w, right: 25.w, bottom: 25.h, top: 70.h),
      //   child: PrimaryButton(
      //     context,
      //     text: 'Done',
      //     onTap: () {},
      //   ),
      // ),
    );
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    mapController.dispose();
  }
}
