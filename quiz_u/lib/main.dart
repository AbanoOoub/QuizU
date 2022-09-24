import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:quiz_u/data/constant/routes.dart';
import 'package:quiz_u/data/constant/shared_prefs_keys.dart';
import 'package:quiz_u/data/helper/dio.dart';
import 'package:quiz_u/data/helper/shared_prefs.dart';
import 'package:quiz_u/presentation/screens/base_nav_sreen.dart';
import 'package:quiz_u/presentation/screens/connection_failed_screen.dart';
import 'package:quiz_u/presentation/screens/correct_screen.dart';
import 'package:quiz_u/presentation/screens/home_screen.dart';
import 'package:quiz_u/presentation/screens/leaderboard_screen.dart';
import 'package:quiz_u/presentation/screens/name_screen.dart';
import 'package:quiz_u/presentation/screens/onbording_screen.dart';
import 'package:quiz_u/presentation/screens/otp_screen.dart';
import 'package:quiz_u/presentation/screens/phone_screen.dart';
import 'package:quiz_u/presentation/screens/quiz_screen.dart';
import 'package:quiz_u/presentation/screens/wrong_ans_screen.dart';

import 'data/helper/bloc_observer.dart';

void main() async {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  await ScreenUtil.ensureScreenSize();
  await DioHelper.init();
  await CacheHelper.init();
  Bloc.observer = MyBlocObserver();
  FlutterNativeSplash.remove();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(360, 640),
      minTextAdapt: true,
      splitScreenMode: false,
      builder: (context, child) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          initialRoute: CacheHelper.getData(key: notFirstTimeKey) ?? false
              ? CacheHelper.getData(key: isTokenValidKey) ?? false
                  ? baseNavigationScreenRoute
                  : phoneScreenRoute
              : onBordingScreenRoute,
          routes: {
            homeScreenRoute: (context) => const HomeScreen(),
            onBordingScreenRoute: (context) => const OnBordingScreen(),
            baseNavigationScreenRoute: (context) =>
                const BaseNavigationScreen(),
            leaderboardScreenRoute: (context) => const LeaderboardScreen(),
            quizScreenRoute: (context) => const QuizScreen(),
            wrongAnswerScreenRoute: (context) => const WrongAnswerScreen(),
            correctScreenRoute: (context) => const CorrectScreen(),
            phoneScreenRoute: (context) => PhoneScreen(),
            otpScreenRoute: (context) => OTPScreen(),
            nameScreenRoute: (context) => NameScreen(),
            connectionFailedScreenRoute: (context) =>
                const ConnectionFailedScreen(),
          },
        );
      },
    );
  }
}
