import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:quiz_u/data/constant/routes.dart';
import 'package:quiz_u/data/helper/app_colors.dart';
import 'package:quiz_u/presentation/widgets/text.dart';
import 'package:quiz_u/presentation/widgets/text_btn.dart';

import '../../data/helper/connection.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image.asset('assets/icons/appLogo.png', height: 200.h, width: 200.w),
          CustomText(
              text: 'Ready to test your knowledge and challenge others?',
              fontSize: 30.sp,
              fontWeight: FontWeight.w500,
              textColor: AppColors.mainTextColor),
          SizedBox(height: 20.h),
          AnimatedTextKit(
            animatedTexts: [
              TyperAnimatedText(
                  'answer as much questions correctly within 2 minutes',
                  speed: const Duration(milliseconds: 80),
                  textAlign: TextAlign.center,
                  textStyle: TextStyle(
                      fontSize: 20.sp,
                      fontWeight: FontWeight.w300,
                      color: AppColors.secondColor)),
            ],
          ),
          SizedBox(height: 120.h),
          SizedBox(
            width: 250.w,
            height: 50.h,
            child: CustomTextButton(
                btnBackgroundColor: AppColors.mainColor,
                text: 'Quiz Me',
                hasBorder: false,
                fontSize: 25.sp,
                fontWeight: FontWeight.w400,
                textColor: AppColors.white,
                onPressed: () {
                  Navigator.pushNamed(context, quizScreenRoute);
                }),
          ),
        ],
      ),
    );
  }
}
