import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:meta/meta.dart';
import 'package:quiz_u/data/constant/shared_prefs_keys.dart';
import 'package:quiz_u/data/helper/shared_prefs.dart';

import '../../data/constant/end_points.dart';
import '../../data/helper/connection.dart';
import '../../data/helper/dio.dart';

part 'name_state.dart';

class NameCubit extends Cubit<NameState> {
  NameCubit() : super(NameInitial());

  static NameCubit get(context) => BlocProvider.of(context);

  void postUserName({required String name}) async {
    emit(PostUserNameLoadingState());
    String uToken = CacheHelper.getData(key: userTokenKey) ?? '';
    await DioHelper.postData(
        endPoint: postUserNameEndPoint,
        token: uToken,
        data: {
          'name': name,
        }).then((value) {
      if (value.data['success'] == true) {
        CacheHelper.saveData(key: userPhoneKey, val: value.data['mobile']);
        CacheHelper.saveData(key: userNameKey, val: value.data['name']);
        Fluttertoast.showToast(msg: 'Welcome');
        emit(PostUserNameSuccessState());
      }
    }).catchError((onError) {
      debugPrint(onError.toString());
      emit(PostUserNameErrorState());
    });
  }
}
