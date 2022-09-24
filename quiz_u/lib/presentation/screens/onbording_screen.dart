import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';
import 'package:quiz_u/data/constant/onbording_list.dart';
import 'package:quiz_u/data/helper/app_colors.dart';
import 'package:quiz_u/presentation/widgets/text_btn.dart';

import '../../data/constant/routes.dart';
import '../../data/constant/shared_prefs_keys.dart';
import '../../data/helper/shared_prefs.dart';
import '../widgets/dot.dart';

class OnBordingScreen extends StatefulWidget {
  const OnBordingScreen({Key? key}) : super(key: key);

  @override
  _OnBordingScreenState createState() => _OnBordingScreenState();
}

class _OnBordingScreenState extends State<OnBordingScreen> {
  int currentIndex = 0;
  late PageController _controller;

  @override
  void initState() {
    _controller = PageController(initialPage: 0);
    CacheHelper.saveData(key: notFirstTimeKey, val: true);
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: PageView.builder(
              controller: _controller,
              itemCount: onBordData.length,
              onPageChanged: (int index) {
                setState(() {
                  currentIndex = index;
                });
              },
              itemBuilder: (_, i) {
                return Padding(
                  padding: EdgeInsets.all(40.h),
                  child: Column(
                    children: [
                      Lottie.asset(
                        onBordData[i].image!,
                        height: 250.h,
                      ),
                      Text(
                        onBordData[i].title!,
                        style: TextStyle(
                          fontSize: 35.sp,
                          color: AppColors.mainTextColor,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 20.h),
                      Text(
                        onBordData[i].description!,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 18.sp,
                          color: AppColors.secondColor,
                        ),
                      )
                    ],
                  ),
                );
              },
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(
              onBordData.length,
                  (index) => CustomDot(index: index, currIndex: currentIndex),
            ),
          ),
          Container(
            height: 50.h,
            margin: EdgeInsets.all(40.h),
            width: double.infinity,
            child: CustomTextButton(
              btnBackgroundColor: AppColors.mainColor,
              hasBorder: false,
              text: currentIndex == onBordData.length - 1 ? "Continue" : "Next",
              fontSize: 24.sp,
              fontWeight: FontWeight.w400,
              textColor: AppColors.white,
              onPressed: () {
                if (currentIndex == onBordData.length - 1) {
                  Navigator.pushReplacementNamed(
                      context, phoneScreenRoute);
                }
                _controller.nextPage(
                  duration: const Duration(milliseconds: 500),
                  curve: Curves.ease,
                );
              },),
          )
        ],
      ),
    );
  }
}

