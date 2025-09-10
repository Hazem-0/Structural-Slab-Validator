import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'app_colors.dart';

class Styles {
  static BoxDecoration get boxDecoration => BoxDecoration(
        gradient: const LinearGradient(
          colors: AppColors.gradientPrimary,
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
        borderRadius: BorderRadius.all(
          Radius.circular(25.r), // responsive radius
        ),
      );
  static OutlineInputBorder get border => OutlineInputBorder(
        borderRadius: BorderRadius.circular(8.r),
        borderSide: const BorderSide(color: AppColors.borderDefault),
      );

  static OutlineInputBorder get focusedBorder => OutlineInputBorder(
        borderRadius: BorderRadius.circular(8.r),
        borderSide: BorderSide(color: AppColors.borderFocused, width: 2.w),
      );
  static TextStyle get font14WhiteBold => TextStyle(
        fontSize: 14.h, // responsive font
        color: AppColors.surfaceLight,
        fontWeight: FontWeight.bold,
        shadows: [
          Shadow(
            offset: Offset(1.w, 1.h),
            blurRadius: 2.r,
            color: const Color.fromARGB(255, 0, 0, 0),
          ),
        ],
      );

  static TextStyle get font20WhiteBold => TextStyle(
        fontSize: 20.h,
        color: AppColors.surfaceLight,
        fontWeight: FontWeight.bold,
      );
  static EdgeInsets get paddingLeft20Top10 => EdgeInsets.only(left: 20.w, top: 10.h);
}
