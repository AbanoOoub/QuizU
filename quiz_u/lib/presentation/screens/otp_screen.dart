import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_verification_code/flutter_verification_code.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:quiz_u/business_logic/login_logic/otp_logic/otp_cubit.dart';
import 'package:quiz_u/data/constant/routes.dart';
import 'package:quiz_u/data/constant/shared_prefs_keys.dart';
import 'package:quiz_u/data/helper/shared_prefs.dart';
import 'package:quiz_u/presentation/widgets/text.dart';

import '../../data/constant/regex.dart';
import '../../data/helper/app_colors.dart';
import '../widgets/text_btn.dart';

class OTPScreen extends StatelessWidget {
  OTPScreen({Key? key}) : super(key: key);

  final TextEditingController _otpCodeController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => OtpCubit(),
      child: BlocConsumer<OtpCubit, OtpState>(
        listener: (context, state) {
          // TODO: implement listener
          if (state is LoginSuccessState) {
            if (OtpCubit
                .get(context)
                .loginResponseModel!
                .status == 'new' ||
                OtpCubit
                    .get(context)
                    .loginResponseModel!
                    .name == null) {
              Navigator.pushReplacementNamed(context, nameScreenRoute);
            } else {
              Navigator.pushNamedAndRemoveUntil(
                  context, baseNavigationScreenRoute, (route) => false);
            }
            _otpCodeController.clear();
          }
          if (state is LoginErrorState) {
            Fluttertoast.showToast(msg: 'It\'s us not you, Try Again');
          }

          if (state is LoginInvalidState) {
            Fluttertoast.showToast(msg: 'Invalid OTP');
          }

          if (state is ConnectionFailedState) {
            Navigator.pushNamed(context, connectionFailedScreenRoute);
          }
        },
        builder: (context, state) {
          var otpCubit = OtpCubit.get(context);
          return Scaffold(
            body: Padding(
              padding: EdgeInsets.all(25.h),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Image.asset('assets/icons/appLogo.png',
                      height: 200.h, width: 200.w),
                  CustomText(
                      text: 'Please enter the OTP sent to your mobile',
                      fontSize: 24.sp,
                      fontWeight: FontWeight.w600,
                      textColor: AppColors.mainTextColor),
                  VerificationCode(
                    textStyle: TextStyle(
                        fontSize: 16.sp, color: AppColors.mainTextColor),
                    keyboardType: TextInputType.number,
                    underlineColor: AppColors.mainColor,
                    length: 4,
                    itemSize: 50.w,
                    onCompleted: (String value) {
                      _otpCodeController.text = value;
                    },
                    onEditing: (bool value) {},
                  ),
                  SizedBox(
                    width: 250.w,
                    height: 50.h,
                    child: state is LoginLoadingState
                        ? Center(
                      child: CircularProgressIndicator(
                          color: AppColors.mainColor),
                    )
                        : CustomTextButton(
                        btnBackgroundColor: AppColors.mainColor,
                        hasBorder: false,
                        text: 'Check',
                        fontSize: 24.sp,
                        fontWeight: FontWeight.w400,
                        textColor: AppColors.white,
                        onPressed: () {
                          if (_otpCodeController.text.length == 4 &&
                              numericRegex
                                  .hasMatch(_otpCodeController.text)) {
                            String mobile =
                                CacheHelper.getData(key: userPhoneKey) ??
                                    '';
                            otpCubit.login(
                                otp: _otpCodeController.text,
                                mobile: mobile);
                          } else {
                            _otpCodeController.clear();
                            Fluttertoast.showToast(
                                msg: 'please enter right OTP');
                          }
                        }),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
