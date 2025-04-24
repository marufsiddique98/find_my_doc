import 'dart:convert';

import 'package:find_my_doc/config/constants/app_strings.dart';
import 'package:find_my_doc/core/common/widgets/my_app_bar.dart';
import 'package:find_my_doc/core/common/widgets/primary_button.dart';
import 'package:find_my_doc/features/auth/presentation/screens/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:gap/gap.dart';
import 'package:http/http.dart' as http;

class VerificationScreen extends StatefulWidget {
  const VerificationScreen({super.key, required this.email});
  final String email;

  @override
  State<VerificationScreen> createState() => _VerificationScreenState();
}

class _VerificationScreenState extends State<VerificationScreen> {
  TextEditingController code = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(title: 'Verification'),
      body: ListView(
        padding: EdgeInsets.all(35),
        children: [
          Text(
            'Verify you email',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          Gap(20),
          TextFormField(
            controller: code,
            decoration: InputDecoration(
              hintText: 'Enter your verification code',
              border: OutlineInputBorder(),
            ),
          ),
          Gap(30),
          PrimaryButton(
            context,
            text: 'Verify',
            onTap: () async {
              try {
                var res = await http.get(Uri.parse('${AppString.baseUrl}verify?code=${code.text}'));
                if (res.statusCode == 200) {
                  try {
                    String msg = jsonDecode(res.body)['message'];
                    if (msg == "Email verified successfully") {
                      Fluttertoast.showToast(msg: 'Email verified successfully. Please login.');
                      Navigator.push(context, MaterialPageRoute(builder: (_) => LoginScreen()));
                    } else {
                      Fluttertoast.showToast(msg: msg);
                    }
                  } catch (e) {
                    Fluttertoast.showToast(msg: 'Invalid code.');
                  }
                } else {
                  Fluttertoast.showToast(msg: res.body.toString());
                }
              } catch (e) {
                Fluttertoast.showToast(msg: e.toString());
              }
            },
          ),
        ],
      ),
    );
  }
}
