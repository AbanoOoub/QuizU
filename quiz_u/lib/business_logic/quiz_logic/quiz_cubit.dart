import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:quiz_u/data/constant/end_points.dart';
import 'package:quiz_u/data/constant/shared_prefs_keys.dart';
import 'package:quiz_u/data/helper/dio.dart';
import 'package:quiz_u/data/helper/shared_prefs.dart';
import 'package:quiz_u/data/helper/sql_database.dart';
import 'package:quiz_u/data/models/question_model.dart';
import 'package:stream_duration/stream_duration.dart';

import '../../data/helper/app_colors.dart';
import '../../data/helper/connection.dart';

part 'quiz_state.dart';

class QuizCubit extends Cubit<QuizState> {
  QuizCubit() : super(QuizInitial());

  static QuizCubit get(context) => BlocProvider.of(context);

  List<QuestionModel> questions = [];

  int questionIndex = 0;
  int userScore = 0;

  final StreamDuration streamDuration =
  StreamDuration(const Duration(minutes: 2));
  Color timerColor = AppColors.mainColor;
  bool skipIsClicked = false;

  void getAllQuestions() async {
    emit(QuestionLoadingState());
    await DioHelper.getData(
        endPoint: questionsEndPoint,
        token: CacheHelper.getData(key: userTokenKey))
        .then((value) {
      questions = (value.data as List)
          .map((question) => QuestionModel.fromJson(question))
          .toList();

      emit(QuestionSuccessState());
    }).catchError((onError) {
      debugPrint(onError.toString());
      emit(QuestionErrorState());
    });
  }

  bool changed = false;

  void changeTimeColor(duration) {
    if (duration.inSeconds < Duration.secondsPerMinute && !changed) {
      timerColor = AppColors.error;
      changed = true;
      emit(TimeColorChangedSuccessState());
    }
  }

  void skipButtonClicked() {
    skipIsClicked = true;
    streamDuration.dispose();
    questionIndex++;
    emit(SkipButtonSuccessState());
  }

  void validateAnswer(String ans) {
    if (questionIndex < questions.length - 1) {
      if (questions[questionIndex].correct == ans) {
        questionIndex++;
        userScore++;
        debugPrint(userScore.toString());
        emit(CorrectAnswerState());
      } else {
        emit(WrongAnswerState());
      }
    } else {
      userScore++;
      emit(FinishQuizState());
    }
  }

  void saveScore(int score) {
    String userName = CacheHelper.getData(key: userNameKey);
    String userPhone = CacheHelper.getData(key: userPhoneKey);
    SqlDatabase database = SqlDatabase();
    database.insertToDatabase(
        sql: 'INSERT INTO User(name, phone, score, date) VALUES(?,?,?,?)',
        args: [
          userName,
          userPhone,
          score,
          DateFormat('dd-MM-yyyy hh:mm').format(DateTime.now()).toString()
        ]);
    emit(SaveDataSuccessState());
  }

  void postUserScore({required int score}) async {
    await DioHelper.postData(endPoint: postUserScoreEndPoint, data: {
      'score': score,
    }).then((value) {
      Fluttertoast.showToast(msg: 'your score saved successfully');
      emit(PostUserScoreSuccessState());
    }).catchError((onError) {
      debugPrint(onError.toString());
      emit(PostUserScoreErrorState());
    });
  }
}
