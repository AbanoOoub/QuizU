import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:quiz_u/business_logic/Leaderboard_logic/leaderboard_cubit.dart';
import 'package:quiz_u/data/constant/routes.dart';
import 'package:quiz_u/data/helper/app_colors.dart';
import 'package:quiz_u/presentation/widgets/text.dart';

class LeaderboardScreen extends StatelessWidget {
  const LeaderboardScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => LeaderboardCubit()..getTopScores(),
      child: BlocConsumer<LeaderboardCubit, LeaderboardState>(
        listener: (context, state) {
          // TODO: implement listener
          if (state is ConnectionFailedState) {
            Navigator.pushNamed(context, connectionFailedScreenRoute);
          }
        },
        builder: (context, state) {
          var leaderboardCubit = LeaderboardCubit.get(context);
          return state is GetTopScoresLoadingState
              ? Center(
                  child: CircularProgressIndicator(color: AppColors.mainColor),
                )
              : leaderboardCubit.topScores.isEmpty
                  ? Center(
                      child: CustomText(
                          text: 'No Scores Yet',
                          fontSize: 20.sp,
                          fontWeight: FontWeight.w400,
                          textColor: AppColors.mainTextColor),
                    )
                  : Center(
                      child: ListView.builder(
                          itemCount: leaderboardCubit.topScores.length,
                          itemBuilder: (context, index) => Padding(
                                padding: EdgeInsets.all(10.h),
                                child: index == 0
                                    ? Container(
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceEvenly,
                                          children: [
                                            Expanded(
                                                flex: 1,
                                                child: Image.asset(
                                                  'assets/icons/1.png',
                                                  width: 60.w,
                                                  height: 60.h,
                                                )),
                                            Expanded(
                                              flex: 1,
                                              child: SizedBox(
                                                width: 100.w,
                                                child: CustomText(
                                                    text: leaderboardCubit
                                                        .topScores[index].name!,
                                                    fontSize: 20.sp,
                                                    fontWeight: FontWeight.w400,
                                                    textColor: AppColors
                                                        .mainTextColor),
                                              ),
                                            ),
                                            Expanded(
                                              flex: 1,
                                              child: SizedBox(
                                                width: 100.w,
                                                child: CustomText(
                                                    text: leaderboardCubit
                                                        .topScores[index].score!
                                                        .toString(),
                                                    fontSize: 20.sp,
                                                    fontWeight: FontWeight.w400,
                                                    textColor: AppColors
                                                        .mainTextColor),
                                              ),
                                            ),
                                          ],
                                        ),
                                        decoration: BoxDecoration(
                                          color: AppColors.white,
                                          boxShadow: [
                                            BoxShadow(
                                              color: AppColors.black
                                                  .withOpacity(0.2),
                                              spreadRadius: 0.5,
                                              blurRadius: 1,
                                              offset: const Offset(0.5,
                                                  0.5), // changes position of shadow
                                            )
                                          ],
                                        ))
                                    : index == 1
                                        ? Container(
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceEvenly,
                                              children: [
                                                Expanded(
                                                    flex: 1,
                                                    child: Image.asset(
                                                      'assets/icons/2.png',
                                                      width: 60.w,
                                                      height: 60.h,
                                                    )),
                                                Expanded(
                                                  flex: 1,
                                                  child: SizedBox(
                                                    width: 100.w,
                                                    child: CustomText(
                                                        text: leaderboardCubit
                                                            .topScores[index]
                                                            .name!,
                                                        fontSize: 20.sp,
                                                        fontWeight:
                                                            FontWeight.w400,
                                                        textColor: AppColors
                                                            .mainTextColor),
                                                  ),
                                                ),
                                                Expanded(
                                                  flex: 1,
                                                  child: SizedBox(
                                                    width: 100.w,
                                                    child: CustomText(
                                                        text: leaderboardCubit
                                                            .topScores[index]
                                                            .score!
                                                            .toString(),
                                                        fontSize: 20.sp,
                                                        fontWeight:
                                                            FontWeight.w400,
                                                        textColor: AppColors
                                                            .mainTextColor),
                                                  ),
                                                ),
                                              ],
                                            ),
                                            decoration: BoxDecoration(
                                              color: AppColors.white,
                                              boxShadow: [
                                                BoxShadow(
                                                  color: AppColors.black
                                                      .withOpacity(0.2),
                                                  spreadRadius: 0.5,
                                                  blurRadius: 1,
                                                  offset: const Offset(0.5,
                                                      0.5), // changes position of shadow
                                                )
                                              ],
                                            ),
                                          )
                                        : index == 2
                                            ? Container(
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceEvenly,
                                                  children: [
                                                    Expanded(
                                                        flex: 1,
                                                        child: Image.asset(
                                                          'assets/icons/3.png',
                                                          width: 60.w,
                                                          height: 60.h,
                                                        )),
                                                    Expanded(
                                                      flex: 1,
                                                      child: SizedBox(
                                                        width: 100.w,
                                                        child: CustomText(
                                                            text:
                                                                leaderboardCubit
                                                                    .topScores[
                                                                        index]
                                                                    .name!,
                                                            fontSize: 20.sp,
                                                            fontWeight:
                                                                FontWeight.w400,
                                                            textColor: AppColors
                                                                .mainTextColor),
                                                      ),
                                                    ),
                                                    Expanded(
                                                      flex: 1,
                                                      child: SizedBox(
                                                        width: 100.w,
                                                        child: CustomText(
                                                            text:
                                                                leaderboardCubit
                                                                    .topScores[
                                                                        index]
                                                                    .score!
                                                                    .toString(),
                                                            fontSize: 20.sp,
                                                            fontWeight:
                                                                FontWeight.w400,
                                                            textColor: AppColors
                                                                .mainTextColor),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                decoration: BoxDecoration(
                                                  color: AppColors.white,
                                                  boxShadow: [
                                                    BoxShadow(
                                                      color: AppColors.black
                                                          .withOpacity(0.2),
                                                      spreadRadius: 0.5,
                                                      blurRadius: 1,
                                                      offset: const Offset(0.5,
                                                          0.5), // changes position of shadow
                                                    )
                                                  ],
                                                ),
                                              )
                                            : Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceEvenly,
                                                children: [
                                                  Expanded(
                                                    flex: 1,
                                                    child: CustomText(
                                                        text: '${index + 1})',
                                                        fontSize: 20.sp,
                                                        fontWeight:
                                                            FontWeight.w400,
                                                        textColor: AppColors
                                                            .mainTextColor),
                                                  ),
                                                  Expanded(
                                                    flex: 1,
                                                    child: SizedBox(
                                                      width: 100.w,
                                                      child: CustomText(
                                                          text: leaderboardCubit
                                                              .topScores[index]
                                                              .name!,
                                                          fontSize: 20.sp,
                                                          fontWeight:
                                                              FontWeight.w400,
                                                          textColor: AppColors
                                                              .mainTextColor),
                                                    ),
                                                  ),
                                                  Expanded(
                                                    flex: 1,
                                                    child: SizedBox(
                                                      width: 100.w,
                                                      child: CustomText(
                                                          text: leaderboardCubit
                                                              .topScores[index]
                                                              .score!
                                                              .toString(),
                                                          fontSize: 20.sp,
                                                          fontWeight:
                                                              FontWeight.w400,
                                                          textColor: AppColors
                                                              .mainTextColor),
                                                    ),
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
