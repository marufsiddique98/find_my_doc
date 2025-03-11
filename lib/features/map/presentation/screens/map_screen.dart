import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_osm_plugin/flutter_osm_plugin.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:geocoding/geocoding.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../config/constants/app_colors.dart';
import '../../../../core/common/widgets/primary_button.dart';

class MapScreen extends StatefulWidget {
  const MapScreen({super.key});

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  MapController mapController = MapController(
    initPosition: GeoPoint(latitude: 29, longitude: 89),
  );
  TextEditingController searchController = TextEditingController();
  String searchText = '';
  FocusNode searchFocus = FocusNode();

  @override
  void initState() {
    super.initState();
    getLocation();
  }

  void getLocation() async {
    mapController.setZoom(stepZoom: 8);
    GeoPoint position = await mapController.myLocation();
    setState(() {
      mapController.moveTo(position);
    });
    List<Placemark> placemarks = await placemarkFromCoordinates(position.latitude, position.longitude);

    setState(() {
      searchText = "${placemarks[0].street}, ${placemarks[0].locality}, ${placemarks[0].country}";
      searchController.text = searchText;
    });
  }

  @override
  Widget build(BuildContext context) {
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
                roadConfiguration: RoadOption(
                  roadColor: AppColors.purpleColor,
                ),
                // markerOption: MarkerOption(
                //     defaultMarker: MarkerIcon(
                //   icon: Icon(
                //     Icons.person_pin_circle,
                //     color: Colors.blue,
                //     size: 56,
                //   ),
                // )),
              )),
          SafeArea(
            child: Container(
              padding: EdgeInsets.only(top: 10.h, left: 25.w, right: 25.w),
              width: double.infinity,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    children: [
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
                  if (searchFocus.hasFocus)
                    Container(
                      margin: EdgeInsets.only(top: 10.h),
                      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(8)),
                      child: ListView.builder(
                          itemCount: 3,
                          shrinkWrap: true,
                          itemBuilder: (_, index) {
                            return ListTile(
                              title: Text(
                                'N-35 Karakoram Hwy',
                                style: GoogleFonts.poppins(color: AppColors.grayColor1E, fontSize: 14.sp, fontWeight: FontWeight.w400),
                              ),
                              subtitle: Text(
                                'Mirpur-1, Dhaka',
                                style: GoogleFonts.poppins(color: AppColors.grayColor63, fontSize: 14.sp, fontWeight: FontWeight.w400),
                              ),
                            );
                          }),
                    ),
                ],
              ),
            ),
          ),
        ],
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
      bottomSheet: Container(
        color: Colors.transparent, // 50% transparency
        padding: EdgeInsets.only(left: 25.w, right: 25.w, bottom: 25.h, top: 70.h),
        child: PrimaryButton(
          context,
          text: 'Done',
          onTap: () {},
        ),
      ),
    );
  }
}
