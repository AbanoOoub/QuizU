import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:quiz_u/presentation/screens/home_screen.dart';
import 'package:quiz_u/presentation/screens/profile_screen.dart';

import '../../data/helper/app_colors.dart';
import 'leaderboard_screen.dart';

class BaseNavigationScreen extends StatefulWidget {
  const BaseNavigationScreen({Key? key}) : super(key: key);

  @override
  State<BaseNavigationScreen> createState() => _BaseNavigationScreenState();
}

class _BaseNavigationScreenState extends State<BaseNavigationScreen> {
  int screenIndex = 0;

  List<Widget> screens = [
    const HomeScreen(),
    const LeaderboardScreen(),
    const ProfileScreen(),
  ];
  List<String> appBarTitles = [
    'QuizU',
    'Leaderboard',
    'Profile',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: AppColors.mainColor,
        elevation: 2,
        title: Center(
          child: Text(
            appBarTitles[screenIndex],
            style: TextStyle(
              fontSize: 18.sp,
              color: AppColors.white,
            ),
          ),
        ),
      ),
      body: screens[screenIndex],
      bottomNavigationBar: BottomNavigationBar(
          currentIndex: screenIndex,
          selectedFontSize: 14.sp,
          selectedIconTheme:
              IconThemeData(color: AppColors.mainColor, size: 25.h),
          selectedItemColor: AppColors.mainColor,
          selectedLabelStyle: const TextStyle(fontWeight: FontWeight.w400),
          unselectedIconTheme: IconThemeData(color: AppColors.secondColor),
          unselectedLabelStyle: TextStyle(color: AppColors.secondColor),
          onTap: (int index) {
            setState(() {
              screenIndex = index;
            });
          },
          items: const [
            BottomNavigationBarItem(
                icon: Icon(Icons.home), label: 'Home'),
            BottomNavigationBarItem(
                icon: Icon(Icons.bar_chart), label: 'Rates'),
            BottomNavigationBarItem(
                icon: Icon(Icons.person_outline), label: 'Profile'),
          ]),
    );
  }
}
