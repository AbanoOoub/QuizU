import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quiz_u/data/models/top_score_model.dart';

import '../../data/constant/end_points.dart';
import '../../data/constant/shared_prefs_keys.dart';
import '../../data/helper/connection.dart';
import '../../data/helper/dio.dart';
import '../../data/helper/shared_prefs.dart';

part 'leaderboard_state.dart';

class LeaderboardCubit extends Cubit<LeaderboardState> {
  LeaderboardCubit() : super(LeaderboardInitial());

  static LeaderboardCubit get(context) => BlocProvider.of(context);

  List<TopScore> topScores = [];

  void getTopScores() async {
    emit(GetTopScoresLoadingState());
    String token = CacheHelper.getData(key: userTokenKey);
    DioHelper.getData(endPoint: topScoresEndPoint, token: token)
        .then((value) async {
      topScores =
          (value.data as List)
              .map((data) => TopScore.fromJson(data))
              .toList();
      emit(GetTopScoresSuccessState());
    }).catchError((e) {
      debugPrint(e.toString());
      emit(GetTopScoresErrorState());
    });
  }
}
