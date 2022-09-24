part of 'quiz_cubit.dart';

@immutable
abstract class QuizState {}

class QuizInitial extends QuizState {}

class QuestionLoadingState extends QuizState {}

class QuestionSuccessState extends QuizState {}

class QuestionErrorState extends QuizState {}

class TimeColorChangedSuccessState extends QuizState {}

class SkipButtonSuccessState extends QuizState {}

class ValidateAnswerSuccessState extends QuizState {}

class CorrectAnswerState extends QuizState {}

class WrongAnswerState extends QuizState {}

class FinishQuizState extends QuizState {}

class SaveDataSuccessState extends QuizState {}

class PostUserScoreSuccessState extends QuizState {}

class PostUserScoreErrorState extends QuizState {}

class ConnectionFailedState extends QuizState {}
