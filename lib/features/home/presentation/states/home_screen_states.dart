import 'dart:convert';
import 'dart:io';

import 'package:find_my_doc/features/home/data/models/request_doctor.dart';
import 'package:find_my_doc/main.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:geolocator/geolocator.dart';
import 'package:riverpod/riverpod.dart';
import '../../../../config/constants/app_strings.dart';
import '../../../auth/presentation/screens/doctor_signup_screen.dart';
import '../../data/models/doctor.dart';
import '../screens/help_screen.dart';
import '../screens/home_screen.dart';
import '../screens/more_screen.dart';
import '../screens/my_orders_screen.dart';
import 'package:http/http.dart' as http;

final bottomNavigationProvider = StateNotifierProvider<BottomNavigationViewModel, int>(
  (ref) => BottomNavigationViewModel(ref),
);

class BottomNavigationViewModel extends StateNotifier<int> {
  final Ref ref;
  BottomNavigationViewModel(this.ref) : super(0);

  void updateIndex(int newIndex) {
    state = newIndex;
    ref.read(bottomNavigationWidgetProvider.notifier).updateScreenIndex(newIndex);
  }
}

final bottomNavigationWidgetProvider = StateNotifierProvider<BottomNavigationWidgetViewModel, Widget>(
  (ref) => BottomNavigationWidgetViewModel(),
);

class BottomNavigationWidgetViewModel extends StateNotifier<Widget> {
  BottomNavigationWidgetViewModel() : super(HomeScreen());

  final List<Widget> _screens = [
    HomeScreen(),
    HelpScreen(),
    MyOrdersScreen(),
    MoreScreen(),
  ];

  void updateScreenIndex(int newIndex) {
    state = _screens[newIndex];
  }
}

final specialityProvider = StateProvider<String>((ref) => AppString.specialties[0]);

final doctorSearchProvider = StateNotifierProvider<DoctorSearchNotifier, AsyncValue<List<Doctor>>>((ref) => DoctorSearchNotifier());

class DoctorSearchNotifier extends StateNotifier<AsyncValue<List<Doctor>>> {
  DoctorSearchNotifier() : super(AsyncLoading()) {
    init();
  }
  init() async {
    Position position = await determinePosition();
    String data = await getDoctorSearchData(AppString.specialties[0], position);
    List? result = jsonDecode(data);
    if (result == null) {
      state = AsyncData([]);
    } else {
      state = AsyncData(List<Doctor>.from(result.map((el) => Doctor.fromJson(el)).toList()));
    }
  }

  changeVal(String val) async {
    state = AsyncLoading();
    Position position = await determinePosition();
    String data = await getDoctorSearchData(val, position);
    print('data: ' + data);
    List? result = jsonDecode(data);
    if (result == null) {
      state = AsyncData([]);
    } else {
      state = AsyncData(List<Doctor>.from(result.map((el) => Doctor.fromJson(el)).toList()));
    }
  }

  Future<void> requestDoctorAppointment(Doctor doctor) async {
    state = AsyncLoading();
    Position position = await determinePosition();
    var res = await http.post(
      Uri.parse('${AppString.baseUrl}api/appointments'),
      headers: {
        HttpHeaders.authorizationHeader: 'Bearer ${storage.getToken()}',
      },
      body: jsonEncode({
        {
          "doctor_id": doctor,
          "patient_id": 2,
          "latitude": position.latitude,
          "longitude": position.longitude,
          "urgency_level": 3,
          "created_at": DateTime.now().toString(),
        }
      }),
    );
    Fluttertoast.showToast(msg: res.body);
  }
}

Future<String> getDoctorSearchData(String speciality, Position position) async {
  var res = await http.get(
    Uri.parse('${AppString.baseUrl}api/doctors?speciality=${speciality}&latitude=37.7749&longitude=-122.4194'),
    headers: {
      HttpHeaders.authorizationHeader: 'Bearer ${storage.getToken()}',
    },
  );
  print('data: ' + res.body);
  return res.body;
}
