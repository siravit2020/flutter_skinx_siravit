import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

final baseTheme = ThemeData(
  primarySwatch: Colors.purple,
  brightness: Brightness.light,
  textTheme: GoogleFonts.k2dTextTheme(
    TextTheme(
      bodyText1: TextStyle(fontSize: 18.sp),
      bodyText2: TextStyle(fontSize: 16.sp),
      headline6: TextStyle(
        fontSize: 20.sp,
      ),
      headline5: TextStyle(
        fontSize: 22.sp,
        fontWeight: FontWeight.w600,
      ),
      headline1: TextStyle(
        fontWeight: FontWeight.bold,
        fontSize: 50.sp,
      ),
    ),
  ).apply(displayColor: Colors.grey.shade900),
);
