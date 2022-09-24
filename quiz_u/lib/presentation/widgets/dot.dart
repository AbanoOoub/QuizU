import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../data/helper/app_colors.dart';

class CustomDot extends StatelessWidget {
  const CustomDot({Key? key, required this.index, required this.currIndex }) : super(key: key);

  final int index;
  final int currIndex;

  @override
  Widget build(BuildContext context) {
      return Container(
        height: 10,
        width: currIndex == index ? 25 : 10,
        margin: EdgeInsets.only(right: 5.h),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20.r),
          color: AppColors.mainColor,
        ),
      );

  }
}
