import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:quiz_u/business_logic/quiz_logic/quiz_cubit.dart';
import 'package:quiz_u/data/constant/routes.dart';
import 'package:quiz_u/data/helper/app_colors.dart';
import 'package:quiz_u/presentation/widgets/text.dart';
import 'package:quiz_u/presentation/widgets/text_btn.dart';
import 'package:slide_countdown/slide_countdown.dart';

class QuizScreen extends StatelessWidget {
  const QuizScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => QuizCubit()..getAllQuestions(),
      child: BlocConsumer<QuizCubit, QuizState>(
        listener: (context, state) async {
          // TODO: implement listener
          if (state is QuestionErrorState) {
            Navigator.pushReplacementNamed(context, baseNavigationScreenRoute);
            Fluttertoast.showToast(msg: 'Not you it\'s us try again!');
          }
          if (state is WrongAnswerState) {
            Navigator.pushReplacementNamed(context, wrongAnswerScreenRoute);
          }
          if (state is FinishQuizState) {
            int score = QuizCubit.get(context).userScore;
            QuizCubit.get(context).saveScore(score);
            QuizCubit.get(context).postUserScore(score: score);
            if (state is PostUserScoreSuccessState) {
              Navigator.pushReplacementNamed(context, correctScreenRoute,
                  arguments: score);
            }
          }
          if (state is ConnectionFailedState) {
            Navigator.pushNamed(context, connectionFailedScreenRoute);
          }
        },
        builder: (context, state) {
          var quizCubit = QuizCubit.get(context);
          return Scaffold(
            body: state is QuestionLoadingState
                ? Center(
                    child:
                        CircularProgressIndicator(color: AppColors.mainColor),
                  )
                : SafeArea(
                    child: Padding(
                      padding: EdgeInsets.all(25.h),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Padding(
                            padding: EdgeInsets.all(25.h),
                            child: SlideCountdown(
                              duration: quizCubit.streamDuration.duration,
                              shouldShowMinutes: (p0) {
                                if (p0.inMinutes == 0) {
                                  quizCubit.changeTimeColor(p0);
                                }
                                return true;
                              },
                              shouldShowSeconds: (p0) {
                                return true;
                              },
                              onDone: () {
                                int score = quizCubit.userScore;
                                quizCubit.saveScore(score);
                                quizCubit.postUserScore(score: score);
                                if (state is PostUserScoreSuccessState) {
                                  Navigator.pushReplacementNamed(
                                      context, correctScreenRoute,
                                      arguments: score);
                                }
                                Navigator.pop(context);
                              },
                              textStyle: TextStyle(
                                  fontWeight: FontWeight.w400,
                                  fontSize: 35.sp,
                                  color: AppColors.white),
                              onChanged: (duration) {},
                              decoration: BoxDecoration(
                                color: quizCubit.timerColor,
                                borderRadius:
                                    const BorderRadius.all(Radius.circular(10)),
                              ),
                            ),
                          ),
                          CustomText(
                              text: quizCubit
                                  .questions[quizCubit.questionIndex].question!,
                              fontSize: 30.sp,
                              fontWeight: FontWeight.w500,
                              textColor: AppColors.mainTextColor),
                          SizedBox(height: 50.h),
                          SizedBox(
                            width: double.infinity,
                            height: 50.h,
                            child: CustomTextButton(
                                btnBackgroundColor: AppColors.white,
                                hasBorder: true,
                                borderColor: AppColors.secondColor,
                                text: quizCubit
                                    .questions[quizCubit.questionIndex].a!,
                                onPressed: () {
                                  quizCubit.validateAnswer('a');
                                },
                                fontSize: 24.sp,
                                fontWeight: FontWeight.w400,
                                textColor: AppColors.secondColor),
                          ),
                          SizedBox(height: 10.h),
                          SizedBox(
                            width: double.infinity,
                            height: 50.h,
                            child: CustomTextButton(
                                btnBackgroundColor: AppColors.white,
                                hasBorder: true,
                                borderColor: AppColors.secondColor,
                                text: quizCubit
                                    .questions[quizCubit.questionIndex].b!,
                                onPressed: () {
                                  quizCubit.validateAnswer('b');
                                },
                                fontSize: 24.sp,
                                fontWeight: FontWeight.w400,
                                textColor: AppColors.secondColor),
                          ),
                          SizedBox(height: 10.h),
                          SizedBox(
                            width: double.infinity,
                            height: 50.h,
                            child: CustomTextButton(
                                btnBackgroundColor: AppColors.white,
                                hasBorder: true,
                                borderColor: AppColors.secondColor,
                                text: quizCubit
                                    .questions[quizCubit.questionIndex].c!,
                                onPressed: () {
                                  quizCubit.validateAnswer('c');
                                },
                                fontSize: 24.sp,
                                fontWeight: FontWeight.w400,
                                textColor: AppColors.secondColor),
                          ),
                          SizedBox(height: 10.h),
                          SizedBox(
                            width: double.infinity,
                            height: 50.h,
                            child: CustomTextButton(
                                btnBackgroundColor: AppColors.white,
                                hasBorder: true,
                                borderColor: AppColors.secondColor,
                                text: quizCubit
                                    .questions[quizCubit.questionIndex].d!,
                                onPressed: () {
                                  quizCubit.validateAnswer('d');
                                },
                                fontSize: 24.sp,
                                fontWeight: FontWeight.w400,
                                textColor: AppColors.secondColor),
                          ),
                          SizedBox(height: 50.h),
                          if (!quizCubit.skipIsClicked) ...[
                            SizedBox(
                              width: 100.w,
                              height: 40.h,
                              child: CustomTextButton(
                                  btnBackgroundColor:
                                      AppColors.secondColor.withOpacity(0.5),
                                  hasBorder: false,
                                  text: 'Skip',
                                  onPressed: () {
                                    quizCubit.skipButtonClicked();
                                  },
                                  fontSize: 24.sp,
                                  fontWeight: FontWeight.w400,
                                  textColor: AppColors.white),
                            ),
                          ]
                        ],
                      ),
                    ),
                  ),
          );
        },
      ),
    );
  }
}
