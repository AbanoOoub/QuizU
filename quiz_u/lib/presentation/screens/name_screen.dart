import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:quiz_u/business_logic/user_name_screen_logic/name_cubit.dart';
import 'package:quiz_u/presentation/widgets/text_form_field.dart';

import '../../data/constant/routes.dart';
import '../../data/helper/app_colors.dart';
import '../widgets/text.dart';
import '../widgets/text_btn.dart';

class NameScreen extends StatelessWidget {
  NameScreen({Key? key}) : super(key: key);

  final TextEditingController _nameController = TextEditingController();
  final GlobalKey<FormState> _nameFormKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => NameCubit(),
      child: BlocConsumer<NameCubit, NameState>(
        listener: (context, state) {
          // TODO: implement listener
          if (state is PostUserNameSuccessState) {
            Navigator.pushNamedAndRemoveUntil(
                context, baseNavigationScreenRoute, (route) => false);
          }
          if (state is ConnectionFailedState) {
            Navigator.pushNamed(context, connectionFailedScreenRoute);
          }
        },
        builder: (context, state) {
          var nameCubit = NameCubit.get(context);
          return Scaffold(
            body: Padding(
              padding: EdgeInsets.all(25.h),
              child: Form(
                key: _nameFormKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Image.asset('assets/icons/appLogo.png',
                        height: 200.h, width: 200.w),
                    CustomText(
                        text: 'What\'s your name?',
                        fontSize: 24.sp,
                        fontWeight: FontWeight.w600,
                        textColor: AppColors.mainTextColor),
                    CustomTextFormField(
                      hint: 'Enter Name',
                      controller: _nameController,
                      withBorders: true,
                      textInputType: TextInputType.name,
                    ),
                    state is PostUserNameLoadingState
                        ? Center(
                            child: CircularProgressIndicator(
                                color: AppColors.mainColor),
                          )
                        : SizedBox(
                            width: 250.w,
                            height: 50.h,
                            child: CustomTextButton(
                                btnBackgroundColor: AppColors.mainColor,
                                hasBorder: false,
                                text: 'Done',
                                fontSize: 24.sp,
                                fontWeight: FontWeight.w400,
                                textColor: AppColors.white,
                                onPressed: () {
                                  if (_nameFormKey.currentState!.validate()) {
                                    nameCubit.postUserName(
                                        name: _nameController.text);
                                  }
                                }),
                          ),
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
