import 'package:equatable/equatable.dart';

class GameModel extends Equatable {
  final String answer;
  final int currentAttempt;
  final List<String> guessedWords, correct, partiallyCorrect, wrong;
  final List<List<int>> guessResults;

  const GameModel({
    this.answer = '',
    this.currentAttempt = 1,
    this.guessedWords = const [],
    this.correct = const [],
    this.partiallyCorrect = const [],
    this.wrong = const [],
    this.guessResults = const [],
  });

  GameModel copyWith({
    String? answer,
    int? currentAttempt,
    List<String>? guessedWords,
    List<String>? correct,
    List<String>? partiallyCorrect,
    List<String>? wrong,
    List<List<int>>? guessResults,
  }) {
    return GameModel(
      answer: answer ?? this.answer,
      currentAttempt: currentAttempt ?? this.currentAttempt,
      guessedWords: guessedWords ?? this.guessedWords,
      correct: correct ?? this.correct,
      partiallyCorrect: partiallyCorrect ?? this.partiallyCorrect,
      wrong: wrong ?? this.wrong,
      guessResults: guessResults ?? this.guessResults,
    );
  }

  @override
  List<Object> get props =>
      [answer, currentAttempt, guessedWords, correct, partiallyCorrect, wrong];

  @override
  String toString() =>
      'GameModel { answer: $answer, currentAttempt: $currentAttempt, guessedWords: $guessedWords, correct: $correct, partiallyCorrect: $partiallyCorrect, wrong: $wrong, guessResults: $guessResults }';
}
