import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';
import 'package:quiz_u/data/helper/app_colors.dart';
import 'package:quiz_u/presentation/widgets/text_btn.dart';

import '../../data/constant/routes.dart';

class WrongAnswerScreen extends StatelessWidget {
  const WrongAnswerScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.white,
        elevation: 0,
        actions: [
          Padding(
            padding: EdgeInsets.all(10.h),
            child: InkWell(
              child: Icon(Icons.close,color: AppColors.black,size: 30.h),
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
              Lottie.asset('assets/lottie_files/wrong-answer.json',
                  height: 100.h, fit: BoxFit.fill),
              SizedBox(height: 60.h),
              Text('OOPS',
                  style: TextStyle(
                    fontSize: 60.sp,
                    color: AppColors.error,
                    fontWeight: FontWeight.bold,
                  )),
              Text('your answer is wrong',
                  style: TextStyle(
                    fontSize: 15.sp,
                    color: AppColors.secondColor,
                  )),
              SizedBox(height: 100.h),
              SizedBox(
                width: 250.w,
                height: 50.h,
                child: CustomTextButton(
                  btnBackgroundColor: AppColors.error.withOpacity(0.5),
                  hasBorder: false,
                  text: 'Try Again',
                  fontSize: 24.sp,
                  fontWeight: FontWeight.w400,
                  textColor: AppColors.white,
                  onPressed: () {
                    Navigator.pushReplacementNamed(context, quizScreenRoute);
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
