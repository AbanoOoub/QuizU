import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:quiz_u/business_logic/login_logic/phone_screen_logic/phone_cubit.dart';
import 'package:quiz_u/data/constant/routes.dart';
import 'package:quiz_u/data/helper/app_colors.dart';
import 'package:quiz_u/presentation/widgets/text_btn.dart';

import '../../data/constant/regex.dart';

class PhoneScreen extends StatelessWidget {
  PhoneScreen({Key? key}) : super(key: key);

  final TextEditingController _phoneController = TextEditingController();
  final GlobalKey<FormState> _loginFormKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => PhoneCubit(),
      child: BlocConsumer<PhoneCubit, PhoneState>(
        listener: (context, state) {
          if (state is SavePhoneNumberSuccessState) {
            Navigator.pushNamed(context, otpScreenRoute);
          }
          if (state is ConnectionFailedState) {
            Navigator.pushNamed(context, connectionFailedScreenRoute);
          }
          if (state is ValidationSuccessState) {
            Navigator.pushNamedAndRemoveUntil(
                context, baseNavigationScreenRoute, (route) => false);
          }
        },
        builder: (context, state) {
          var phoneCubit = PhoneCubit.get(context);
          return Scaffold(
            body: state is ValidationLoadingState
                ? Center(
                    child:
                        CircularProgressIndicator(color: AppColors.mainColor),
                  )
                : Padding(
                    padding: EdgeInsets.all(25.h),
                    child: Form(
                      key: _loginFormKey,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Image.asset('assets/icons/appLogo.png',
                              height: 200.h, width: 200.w),
                          IntlPhoneField(
                            decoration: InputDecoration(
                              labelText: 'Phone Number',
                              hintText: phoneCubit.hint,
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: AppColors.mainColor, width: 0.5),
                                borderRadius: BorderRadius.circular(9.r),
                              ),
                              labelStyle: TextStyle(color: AppColors.mainColor),
                              border: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: AppColors.secondColor, width: 0.5),
                                borderRadius: BorderRadius.circular(9.r),
                              ),
                            ),
                            controller: _phoneController,
                            initialCountryCode: 'EG',
                            countries: const [
                              'EG',
                              'SA',
                            ],
                            onCountryChanged: (country) {
                              phoneCubit.changeHint(country: country.name);
                            },
                          ),
                          SizedBox(
                            width: 250.w,
                            height: 50.h,
                            child: CustomTextButton(
                                btnBackgroundColor: AppColors.mainColor,
                                hasBorder: false,
                                text: 'Start',
                                fontSize: 24.sp,
                                fontWeight: FontWeight.w400,
                                textColor: AppColors.white,
                                onPressed: () async {
                                  if (_loginFormKey.currentState!.validate()) {
                                    if (phoneRegex
                                            .hasMatch(_phoneController.text) &&
                                        _phoneController.text[0] != '0') {
                                      phoneCubit.savePhoneNumber(
                                          phone: _phoneController.text);
                                    } else {
                                      Fluttertoast.showToast(
                                        msg: "This phone is invalid",
                                        toastLength: Toast.LENGTH_SHORT,
                                      );
                                    }
                                  }
                                }),
                          ),
                        ],
                      ),
                    )),
          );
        },
      ),
    );
  }
}
