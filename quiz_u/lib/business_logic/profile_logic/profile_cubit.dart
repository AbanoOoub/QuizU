import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quiz_u/data/constant/shared_prefs_keys.dart';
import 'package:quiz_u/data/helper/connection.dart';
import 'package:quiz_u/data/helper/dio.dart';
import 'package:quiz_u/data/helper/shared_prefs.dart';

import '../../data/constant/end_points.dart';
import '../../data/helper/sql_database.dart';
import '../../data/models/profile_model.dart';

part 'profile_state.dart';

class ProfileCubit extends Cubit<ProfileState> {
  ProfileCubit() : super(ProfileInitial());

  static ProfileCubit get(context) => BlocProvider.of(context);

  late ProfileModel profileModel;
  List<Map> userScores = [];

  void getUserInfo() async {
    emit(GetUserInfoLoadingState());
    String token = CacheHelper.getData(key: userTokenKey);
    DioHelper.getData(endPoint: profileEndPoint, token: token)
        .then((value) async {
      profileModel = ProfileModel.fromJson(value.data);
      userScores = await getScores(profileModel.mobile!);
      emit(GetUserInfoSuccessState());
    }).catchError((e) {
      debugPrint(e.toString());
      emit(GetUserInfoErrorState());
    });
  }

  Future<List<Map>> getScores(String phone) async {
    SqlDatabase database = SqlDatabase();
    List<Map> userScores = await database.readFromDatabase(
        'SELECT * FROM User WHERE phone = $phone ORDER BY date DESC');
    return userScores;
  }
}
