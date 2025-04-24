import 'dart:convert';
import 'dart:io';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../config/constants/app_strings.dart';
import '../../../../main.dart';
import '../../data/models/request_doctor.dart';

final myOrderScreenStates = StateNotifierProvider((ref) => MyOrderScreenNotifier());

class MyOrderScreenNotifier extends StateNotifier {
  MyOrderScreenNotifier() : super(0);
}

// Provider for managing tab index
final myOrderScreenTabIndexProvider = StateNotifierProvider<MyOrderScreenTabIndexNotifier, int>(
  (ref) => MyOrderScreenTabIndexNotifier(),
);

class MyOrderScreenTabIndexNotifier extends StateNotifier<int> {
  MyOrderScreenTabIndexNotifier() : super(0);

  void updateIndex(int newIndex) {
    state = newIndex;
  }
}

final tabControllerProvider = Provider.autoDispose.family<TabController, TickerProvider>(
  (ref, vsync) {
    final tabIndexNotifier = ref.watch(myOrderScreenTabIndexProvider.notifier);

    final tabController = TabController(length: 2, vsync: vsync);

    tabController.addListener(() {
      tabIndexNotifier.updateIndex(tabController.index);
    });

    ref.onDispose(() {
      tabController.dispose();
    });

    return tabController;
  },
);
final doctorRequestsProvider = StateNotifierProvider.autoDispose
    .family<DoctorRequestsNotifier, AsyncValue<List<RequestDoctor>>, String>((ref, status) => DoctorRequestsNotifier(status));

class DoctorRequestsNotifier extends StateNotifier<AsyncValue<List<RequestDoctor>>> {
  final String status;
  DoctorRequestsNotifier(this.status) : super(AsyncLoading()) {
    init();
  }
  init() async {
    try {
      var res = await http.get(
        Uri.parse('${AppString.baseUrl}api/doctors/appointments/$status'),
        headers: {
          HttpHeaders.authorizationHeader: 'Bearer ${storage.getToken()}',
        },
      );
      print('DoctorRequestsNotifier data: ' + res.body);
      List result = jsonDecode(res.body);
      state = AsyncData(List<RequestDoctor>.from(result.map((el) => RequestDoctor.fromJson(el)).toList()));
    } catch (e, r) {
      state = AsyncError(e, r);
    }
  }

  void accept(int id) async {
    state = AsyncLoading();
    var res = await http.patch(
      Uri.parse('${AppString.baseUrl}api/appointments/$id/accept'),
      headers: {
        HttpHeaders.authorizationHeader: 'Bearer ${storage.getToken()}',
      },
    );
    if (res.statusCode == 201 || res.statusCode == 200) {
      Fluttertoast.showToast(msg: res.body.toString());
    } else {
      Fluttertoast.showToast(msg: 'Something error occurred');
    }
    init();
  }
}
