import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../config/constants/app_colors.dart';

class MyDobField extends StatefulWidget {
  @override
  _MyDobFieldState createState() => _MyDobFieldState();
}

class _MyDobFieldState extends State<MyDobField> {
  List<String> months = ['January', 'February', 'March', 'April', 'May', 'June', 'July', 'August', 'September', 'October', 'November', 'December'];
  List<String> days = [];
  List<String> years = List.generate(100, (index) => (DateTime.now().year - index).toString());

  String? selectedDay;
  String? selectedMonth;
  String? selectedYear;
  @override
  void initState() {
    super.initState();
    DateTime now = DateTime.now();
    selectedDay = now.day.toString();
    selectedMonth = months[now.month - 1];
    selectedYear = now.year.toString();
    days = getDaysInMonth(DateTime.now().year, DateTime.now().month);
  }

  List<String> getDaysInMonth(int year, int monthIndex) {
    int daysInMonth = DateTime(year, monthIndex + 1, 0).day;
    return List.generate(daysInMonth, (index) => (index + 1).toString());
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        // Day Dropdown
        Expanded(
          child: Container(
            padding: EdgeInsets.symmetric(vertical: 15, horizontal: 10),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              border: Border.all(width: 1, color: AppColors.grayColorD0),
            ),
            child: DropdownButtonFormField<String>(
              decoration: InputDecoration.collapsed(hintText: ''),
              style: GoogleFonts.poppins(
                fontSize: 14.sp,
                fontWeight: FontWeight.w400,
                color: AppColors.grayColor8A,
              ),
              icon: Transform.rotate(
                  angle: pi / 2,
                  child: Icon(
                    Icons.keyboard_arrow_right_sharp,
                    size: 20.sp,
                  )),
              value: selectedDay,
              hint: Text(
                "Day",
                style: TextStyle(fontSize: 14.sp),
              ),
              items: days.map((day) {
                return DropdownMenuItem(child: Text(day), value: day);
              }).toList(),
              onChanged: (value) {
                setState(() {
                  selectedDay = value;
                });
              },
            ),
          ),
        ),
        Gap(7),

        // Month Dropdown
        Expanded(
          child: Container(
            padding: EdgeInsets.symmetric(vertical: 15, horizontal: 10),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              border: Border.all(width: 1, color: AppColors.grayColorD0),
            ),
            child: DropdownButtonFormField<String>(
              decoration: InputDecoration.collapsed(hintText: ''),
              style: GoogleFonts.poppins(
                fontSize: 14.sp,
                fontWeight: FontWeight.w400,
                color: AppColors.grayColor8A,
              ),
              icon: Transform.rotate(
                  angle: pi / 2,
                  child: Icon(
                    Icons.keyboard_arrow_right_sharp,
                    size: 20.sp,
                  )),
              value: selectedMonth,
              hint: Text(
                "Month",
                style: TextStyle(fontSize: 14.sp),
              ),
              items: months.map((month) {
                return DropdownMenuItem(child: Text(month), value: month);
              }).toList(),
              onChanged: (value) {
                setState(() {
                  selectedMonth = value;
                  days = getDaysInMonth(int.parse(selectedYear!), months.indexOf(selectedMonth!));
                });
              },
            ),
          ),
        ),
        Gap(7),

        // Year Dropdown
        Expanded(
          child: Container(
            padding: EdgeInsets.symmetric(vertical: 15, horizontal: 10),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              border: Border.all(width: 1, color: AppColors.grayColorD0),
            ),
            child: DropdownButtonFormField<String>(
              decoration: InputDecoration.collapsed(hintText: ''),
              style: GoogleFonts.poppins(
                fontSize: 14.sp,
                fontWeight: FontWeight.w400,
                color: AppColors.grayColor8A,
              ),
              icon: Transform.rotate(
                  angle: pi / 2,
                  child: Icon(
                    Icons.keyboard_arrow_right_sharp,
                    size: 20.sp,
                  )),
              value: selectedYear,
              hint: Text(
                "Year",
                style: TextStyle(fontSize: 14.sp),
              ),
              items: years.map((year) {
                return DropdownMenuItem(child: Text(year), value: year);
              }).toList(),
              onChanged: (value) {
                setState(() {
                  selectedYear = value;
                });
              },
            ),
          ),
        ),
      ],
    );
  }
}
