import 'package:flutter/material.dart';
import 'package:flutter_osm_plugin/flutter_osm_plugin.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:geocoding/geocoding.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../config/constants/app_colors.dart';
import '../../../../generated/assets.dart';

class CurrentLocationMapWidget extends StatefulWidget {
  const CurrentLocationMapWidget({super.key});

  @override
  State<CurrentLocationMapWidget> createState() => _CurrentLocationMapWidgetState();
}

class _CurrentLocationMapWidgetState extends State<CurrentLocationMapWidget> {
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
    return ClipRRect(
      borderRadius: BorderRadius.circular(7),
      child: AspectRatio(
        aspectRatio: 16 / 11,
        child: Column(
          children: [
            Expanded(
              child: OSMFlutter(
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
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(vertical: 11.h),
              color: AppColors.lightGreenColor,
              child: Row(
                children: [
                  Spacer(),
                  SvgPicture.asset(Assets.iconsSmallMarker),
                  Gap(3),
                  Text(
                    searchText,
                    style: GoogleFonts.poppins(fontWeight: FontWeight.w400, fontSize: 14.sp, color: AppColors.grayColor1E),
                  ),
                  Spacer(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
