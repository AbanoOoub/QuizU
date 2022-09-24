import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';
import 'package:quiz_u/data/helper/app_colors.dart';
import 'package:quiz_u/presentation/widgets/text.dart';
import 'package:share_plus/share_plus.dart';

class CorrectScreen extends StatelessWidget {
  const CorrectScreen({Key? key,}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)!.settings.arguments;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.white,
        elevation: 0,
        actions: [
          Padding(
            padding: EdgeInsets.all(10.h),
            child: InkWell(
              child: Icon(Icons.close, color: AppColors.black, size: 30.h),
              onTap: () {
                Navigator.pop(context);
                // Navigator.pushNamedAndRemoveUntil(
                //     context, baseNavigationScreenRoute, (route) => false);
              },
            ),
          )
        ],
      ),
      backgroundColor: AppColors.white,
      body: SingleChildScrollView(
        padding: EdgeInsets.only(top: 120.h),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Lottie.asset('assets/lottie_files/correct-answer.json',
                  height: 100.h, fit: BoxFit.fill),
              SizedBox(height: 60.h),
              Text('SUCCESS',
                  style: TextStyle(
                    fontSize: 50.sp,
                    color: AppColors.mainColor,
                    fontWeight: FontWeight.bold,
                  )),
              Text('you have completed $args correct answers',
                  style: TextStyle(
                    fontSize: 15.sp,
                    color: AppColors.secondColor,
                  )),
              SizedBox(height: 100.h),
              SizedBox(
                width: 150.w,
                child: InkWell(
                  onTap: () {
                    Share.share('I answered $args correct answers in QuizU!');
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.share, size: 25.h),
                      SizedBox(width: 25.w),
                      CustomText(
                          text: 'Share',
                          fontSize: 24.sp,
                          fontWeight: FontWeight.w400,
                          textColor: AppColors.mainTextColor)
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
