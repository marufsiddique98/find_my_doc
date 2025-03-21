import 'dart:convert';
import 'dart:developer';

import 'package:find_my_doc/features/profile/data/models/app_user.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;

import '../../../../config/constants/app_strings.dart';
import '../../../../main.dart';

final profileProvider = FutureProvider<AppUser?>((ref) async {
  try {
    log('message');
    var res = await http.get(Uri.parse('${AppString.baseUrl}api/profile'), headers: {'Authorization': 'Bearer ${storage.getToken()}'});
    log(res.body);
    return AppUser.fromJson(jsonDecode(res.body));
  } catch (e) {
    log(e.toString());
  }
  return null;
});
