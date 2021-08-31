import 'package:flutter/material.dart';
import 'colors.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

// const double _largeFontSize = 24;
// const double _mediumFontSize2x = 16;
// const double _mediumFontSize = 14;
// const double _smallFontSize2X = 12;
// const double _smallFontSize = 10;

double _largeFontSize = 24.sp;
double _mediumFontSize2x = 20.sp;
double _mediumFontSize = 18.sp;
double _smallFontSize2X = 16.sp;
double _smallFontSize = 14.sp;

const TextStyle _defaultTextStyle = TextStyle(fontFamily: 'NotoSans', color: blackColor);

TextStyle medium24TextStyle = _defaultTextStyle.copyWith(fontSize: _largeFontSize, fontWeight: FontWeight.w500);
TextStyle medium16TextStyle = _defaultTextStyle.copyWith(fontSize: _mediumFontSize2x, fontWeight: FontWeight.w500);
TextStyle medium14TextStyle = _defaultTextStyle.copyWith(fontSize: _mediumFontSize, fontWeight: FontWeight.w500);
TextStyle medium12TextStyle = _defaultTextStyle.copyWith(fontSize: _smallFontSize2X, fontWeight: FontWeight.w500);
TextStyle medium10TextStyle = _defaultTextStyle.copyWith(fontSize: _smallFontSize, fontWeight: FontWeight.w500);

TextStyle regular14TextStyle = _defaultTextStyle.copyWith(fontSize: _mediumFontSize, fontWeight: FontWeight.w400);
TextStyle regular12TextStyle = _defaultTextStyle.copyWith(fontSize: _smallFontSize2X, fontWeight: FontWeight.w400);
TextStyle regular10TextStyle = _defaultTextStyle.copyWith(fontSize: _smallFontSize, fontWeight: FontWeight.w400);




