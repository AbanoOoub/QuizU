import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';
import 'package:quiz_u/data/helper/app_colors.dart';

class ConnectionFailedScreen extends StatelessWidget {
  const ConnectionFailedScreen({
    Key? key,
  }) : super(key: key);

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
              child: Icon(Icons.close, color: AppColors.black, size: 30.h),
              onTap: () {
                Navigator.pop(context);
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
              Lottie.asset('assets/lottie_files/connection_failed.json',
                  height: 100.h, fit: BoxFit.fill),
              SizedBox(height: 60.h),
              Text('check your internet connection',
                  style: TextStyle(
                    fontSize: 35.sp,
                    color: AppColors.mainColor,
                    fontWeight: FontWeight.bold,
                  )),
            ],
          ),
        ),
      ),
    );
  }
}
