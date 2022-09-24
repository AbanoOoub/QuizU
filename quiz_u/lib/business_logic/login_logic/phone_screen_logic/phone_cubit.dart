import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../data/constant/end_points.dart';
import '../../../data/constant/routes.dart';
import '../../../data/constant/shared_prefs_keys.dart';
import '../../../data/helper/connection.dart';
import '../../../data/helper/dio.dart';
import '../../../data/helper/shared_prefs.dart';
import '../../../data/models/token_validation_model.dart';

part 'phone_state.dart';

class PhoneCubit extends Cubit<PhoneState> {
  PhoneCubit() : super(PhoneInitial());

  static PhoneCubit get(context) => BlocProvider.of(context);

  TokenValidationResponseModel? tokenValidationResponseModel;

  String hint = '1221903638';
  String countryDialCode = '';

  void checkTokenValidation(BuildContext context) async {
    String uToken = CacheHelper.getData(key: userTokenKey) ?? '';
    debugPrint('uToken = $uToken');
    emit(ValidationLoadingState());
    await DioHelper.getData(endPoint: tokenValidationEndPoint, token: uToken)
        .then((value) {
      if (value.data['success'] == true) {
        CacheHelper.saveData(key: isTokenValidKey, val: true);

        emit(ValidationSuccessState());
      } else {
        CacheHelper.saveData(key: isTokenValidKey, val: false);
        emit(ValidationFailedState());
      }
    }).catchError((onError) {
      debugPrint(onError.toString());
      emit(ValidationErrorState());
    });
  }

  void savePhoneNumber({required String phone}) {
    CacheHelper.saveData(key: userPhoneKey, val: phone);
    emit(SavePhoneNumberSuccessState());
  }

  void changeHint({required String country}) {
    if (country == 'Egypt') {
      hint = '122 190 3638';
    } else {
      hint = '53 555 5555';
    }
    emit(ChangeHintSuccessState());
  }
}
