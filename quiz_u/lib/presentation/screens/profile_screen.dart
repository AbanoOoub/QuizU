import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:quiz_u/business_logic/profile_logic/profile_cubit.dart';
import 'package:quiz_u/data/constant/routes.dart';
import 'package:quiz_u/data/constant/shared_prefs_keys.dart';
import 'package:quiz_u/data/helper/shared_prefs.dart';
import 'package:quiz_u/presentation/widgets/text.dart';
import 'package:quiz_u/presentation/widgets/text_btn.dart';

import '../../data/helper/app_colors.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ProfileCubit()..getUserInfo(),
      child: BlocConsumer<ProfileCubit, ProfileState>(
        listener: (context, state) {
          // TODO: implement listener
          if (state is ConnectionFailedState) {
            Navigator.pushNamed(context, connectionFailedScreenRoute);
          }
        },
        builder: (context, state) {
          var profileCubit = ProfileCubit.get(context);
          return state is GetUserInfoLoadingState
              ? Center(
                  child: CircularProgressIndicator(color: AppColors.mainColor),
                )
              : Column(
                  children: [
                    Expanded(
                      flex: 2,
                      child: Padding(
                        padding: EdgeInsets.all(10.h),
                        child: Column(
                          children: [
                            profileCubit.profileModel.name!.isEmpty
                                ? const SizedBox()
                                : CustomText(
                                    text: profileCubit.profileModel.name!,
                                    fontSize: 24.sp,
                                    fontWeight: FontWeight.w400,
                                    textColor: AppColors.mainTextColor),
                            SizedBox(height: 5.h),
                            CustomText(
                                text: profileCubit.profileModel.mobile!,
                                fontSize: 20.sp,
                                fontWeight: FontWeight.w300,
                                textColor: AppColors.secondColor),
                            Divider(
                              color: AppColors.secondColor,
                              thickness: 1,
                              height: 30.h,
                            ),
                            Center(
                              child: CustomText(
                                  text: 'My Scores',
                                  fontSize: 30.sp,
                                  fontWeight: FontWeight.w500,
                                  textColor: AppColors.mainTextColor),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 5,
                      child: profileCubit.userScores.isEmpty
                          ? Center(
                              child: CustomText(
                                  text: 'No Scores Yet',
                                  fontSize: 20.sp,
                                  fontWeight: FontWeight.w400,
                                  textColor: AppColors.mainTextColor),
                            )
                          : ListView.builder(
                              itemCount: profileCubit.userScores.length,
                              itemBuilder: (context, index) => Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    CustomText(
                                        text: profileCubit.userScores[index]
                                            ['date'],
                                        fontSize: 24.sp,
                                        fontWeight: FontWeight.w400,
                                        textColor: AppColors.mainTextColor),
                                    CustomText(
                                        text: profileCubit.userScores[index]
                                                ['score']
                                            .toString(),
                                        fontSize: 24.sp,
                                        fontWeight: FontWeight.w400,
                                        textColor: AppColors.mainTextColor),
                                  ],
                                ),
                              ),
                            ),
                    ),
                    Expanded(
                      flex: 1,
                      child: Padding(
                        padding: EdgeInsets.all(10.h),
                        child: SizedBox(
                          width: 200.w,
                          child: CustomTextButton(
                            btnBackgroundColor: AppColors.white,
                            hasBorder: true,
                            borderColor: AppColors.error,
                            text: 'Logout',
                            fontSize: 24.sp,
                            fontWeight: FontWeight.w400,
                            textColor: AppColors.error,
                            onPressed: () {
                              CacheHelper.saveData(
                                  key: isTokenValidKey, val: false);
                              CacheHelper.saveData(key: userTokenKey, val: '');
                              Navigator.pushNamedAndRemoveUntil(
                                  context, phoneScreenRoute, (route) => false);
                            },
                          ),
                        ),
                      ),
                    ),
                  ],
                );
        },
      ),
    );
  }
}
