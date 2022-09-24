import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quiz_u/data/constant/end_points.dart';
import 'package:quiz_u/data/constant/shared_prefs_keys.dart';
import 'package:quiz_u/data/helper/dio.dart';
import 'package:quiz_u/data/helper/shared_prefs.dart';
import 'package:quiz_u/data/models/login_model.dart';

part 'otp_state.dart';

class OtpCubit extends Cubit<OtpState> {
  OtpCubit() : super(OtpInitial());

  static OtpCubit get(context) => BlocProvider.of(context);

  LoginResponseModel? loginResponseModel;

  void login({required String otp, required String mobile}) async {
    emit(LoginLoadingState());
    await DioHelper.postData(
        endPoint: loginEndPoint,
        data: {"OTP": otp, "mobile": mobile}).then((value) {
      if (value.data['success'] == true) {
        loginResponseModel = LoginResponseModel.fromJson(value.data);
        saveInCache();
        emit(LoginSuccessState());
      } else {
        emit(LoginInvalidState());
      }
      debugPrint(loginResponseModel.toString());
      debugPrint(value.data.toString());
    }).catchError((e) {
      debugPrint(e.toString());
      emit(LoginErrorState());
    });
  }

  void saveInCache() {
    CacheHelper.saveData(key: isTokenValidKey, val: true);
    CacheHelper.saveData(
        key: userTokenKey, val: loginResponseModel!.token.toString());
    CacheHelper.saveData(
        key: userPhoneKey, val: loginResponseModel!.mobile.toString());
    if (loginResponseModel!.name != null) {
      CacheHelper.saveData(
          key: userNameKey, val: loginResponseModel!.name.toString());
    }
  }
}
