import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:skylightDemo/core/colors.dart';

LinearGradient gradiant() {
  return LinearGradient(
    end: Alignment.topRight,
    begin: Alignment.bottomLeft,
    colors: [AppColors.primaryAppColor, AppColors.secondaryLightColor],
  );
}

TextStyle testStyle({
  required int fontsize,
}) =>
    TextStyle(color: Colors.white, fontSize: fontsize.sp);
