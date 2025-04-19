import 'dart:convert';

import 'package:find_my_doc/config/constants/app_strings.dart';
import 'package:find_my_doc/core/common/widgets/primary_button.dart';
import 'package:find_my_doc/main.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

import '../../../../core/common/widgets/my_app_bar.dart';
import '../../../../generated/assets.dart';
import 'extra/health_checkup_doctor_screen.dart';

class HealthCheckScreen extends StatefulWidget {
  const HealthCheckScreen({super.key});

  @override
  State<HealthCheckScreen> createState() => _HealthCheckScreenState();
}

class _HealthCheckScreenState extends State<HealthCheckScreen> {
  String search = '';
  String result = '';
  bool launchedBefore = true;
  bool loading = false;

  void checkFirst() async {
    final prefs = await SharedPreferences.getInstance();
    final hasLaunchedBefore = prefs.getBool('first') ?? false;

    if (hasLaunchedBefore) {
      setState(() {
        launchedBefore = false;
      });
    } else {
      await prefs.setBool('first', true);
      setState(() {
        launchedBefore = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(back: false, title: 'Health Check'),
      body: !launchedBefore ? _buildFirstWidget(context) : _buildSecondWidget(context),
      bottomSheet: !launchedBefore
          ? SizedBox.shrink()
          : Padding(
              padding: const EdgeInsets.all(8.0),
              child: PrimaryButton(
                context,
                text: "Send",
                onTap: () async {
                  setState(() {
                    loading = true;
                  });
                  try {
                    var res = await http.post(
                      Uri.parse('${AppString.baseUrl}suggest-doctor'),
                      headers: <String, String>{
                        'Content-Type': 'application/json; charset=UTF-8',
                        'Accept': 'application/json',
                        'Authorization': 'Bearer ${storage.getToken()}'
                      },
                      body: jsonEncode({'symptoms': search}),
                    );
                    try {
                      var body = jsonDecode(res.body);
                      // setState(() {
                      //   result = 'You need a ' + body['specialist'] + ' for a checkup.';
                      // });
                      Navigator.push(context, MaterialPageRoute(builder: (_) => HealthCheckupDoctorScreen(speciality: body['specialist'])));
                    } catch (er) {
                      setState(() {
                        result = 'You need a doctor for a checkup.';
                      });
                    }
                  } catch (e) {
                    print('error=>' + e.toString());
                  }
                  setState(() {
                    loading = false;
                  });
                },
              ),
            ),
    );
  }

  _buildFirstWidget(BuildContext context) {
    return ListView(
      padding: EdgeInsets.all(30),
      children: [
        Image.asset(
          Assets.imagesXray,
          width: MediaQuery.of(context).size.width / 3,
        ),
        Text(
          'Welcome to healthcheck',
          textAlign: TextAlign.center,
          style: TextStyle(fontWeight: FontWeight.w500, fontSize: 24),
        ),
        Gap(10),
        Text(
          'Understand the state of your health now to make you better choices about your lifestyle.',
          textAlign: TextAlign.center,
        ),
        Gap(10),
        PrimaryButton(
          context,
          text: 'Get Started',
          onTap: () async {
            SharedPreferences prefs = await SharedPreferences.getInstance();
            prefs.setBool('first', true);
            setState(() {
              launchedBefore = true;
            });
          },
        ),
        Gap(30),
        Text(
          'Healthcheck is information purpose only. It is not substitute for a medical suggestion or advice.',
          textAlign: TextAlign.center,
        ),
      ],
    );
  }

  _buildSecondWidget(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextFormField(
            onChanged: (v) {
              setState(() {
                search = v;
              });
            },
            maxLines: 5,
            decoration: InputDecoration(
              hintText: 'Tell us about your current health condition or symptoms.....',
              border: OutlineInputBorder(),
            ),
          ),
          Gap(25),
          Expanded(
            child: loading ? Center(child: CircularProgressIndicator()) : Text(result),
          ),
        ],
      ),
    );
  }
}
