import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../data/helper/app_colors.dart';

class CustomTextFormField extends StatelessWidget {
  const CustomTextFormField(
      {Key? key,
      // required this.label,
      required this.hint,
      this.suffixIcon,
      this.hideCharacters = false,
      this.withBorders = false,
      this.readOnly = false,
      this.textInputType,
      this.textInputAction,
      this.textAlign = TextAlign.start,
      this.fillColor,
      this.labelColor,
      this.hintColor,
      this.textColor,
      this.controller,
      this.onChange,
      this.prefixIcon,
      this.onEditingComplete})
      : super(key: key);

  final TextEditingController? controller;
  // final String label;
  final String hint;
  final Widget? suffixIcon;
  final Widget? prefixIcon;
  final bool hideCharacters;
  final bool withBorders;
  final TextAlign textAlign;
  final bool readOnly;
  final TextInputType? textInputType;
  final TextInputAction? textInputAction;
  final Color? fillColor;
  final Color? hintColor;
  final Color? labelColor;
  final Color? textColor;
  final void Function(String)? onChange;
  final void Function()? onEditingComplete;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Text(
        //   label,
        //   style: TextStyle(
        //       color: labelColor ?? AppColors.mainTextColor, fontSize: 24.sp),
        // ),
        // SizedBox(height: 8.h),
        TextFormField(
          readOnly: readOnly,
          obscureText: hideCharacters,
          controller: controller,
          keyboardType: textInputType,
          textInputAction: textInputAction,
          onChanged: onChange,
          textAlign: textAlign,
          validator: (v){
            if(v==null || v.isEmpty){
              return 'this field is required';
            }
            return null;
          },
          onEditingComplete: onEditingComplete,
          style: TextStyle(
            color: textColor ?? AppColors.mainTextColor,
            fontSize: 20.sp,
            fontWeight: FontWeight.w500,
          ),
          decoration: InputDecoration(
            suffixIcon: suffixIcon,
            prefixIcon: prefixIcon,
            hintText: hint,
            hintStyle: TextStyle(
                color: hintColor ?? AppColors.secondColor, fontSize: 20.sp),
            filled: fillColor != null,
            fillColor: fillColor,
            contentPadding: EdgeInsets.symmetric(horizontal: 16.w),
            errorBorder: withBorders
                ? OutlineInputBorder(
                    borderSide: BorderSide(color: AppColors.error, width: 0.5),
                    borderRadius: BorderRadius.circular(8.r),
                  )
                : InputBorder.none,
            border: withBorders
                ? OutlineInputBorder(
                    borderSide:
                        BorderSide(color: AppColors.secondColor, width: 0.5),
                    borderRadius: BorderRadius.circular(9.r),
                  )
                : InputBorder.none,
            focusedBorder: withBorders
                ? OutlineInputBorder(
                    borderSide:
                        BorderSide(color: AppColors.mainColor, width: 0.5),
                    borderRadius: BorderRadius.circular(9.r),
                  )
                : InputBorder.none,
            focusedErrorBorder: withBorders
                ? OutlineInputBorder(
                    borderSide: BorderSide(color: AppColors.error, width: 0.5),
                    borderRadius: BorderRadius.circular(9.r),
                  )
                : InputBorder.none,
          ),
        )
      ],
    );
  }
}
