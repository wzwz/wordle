import 'dart:async';
import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:wordle/repositories/game_repository/game_repository.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LocalGameRepository implements GameRepository {
  @override
  Future<String> getCurrentGame() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (prefs.getInt('currentGameKey') == null) {
      DateTime firstDay = DateTime(2022, 01, 27);
      Duration differenceFromToday = DateTime.now().difference(firstDay);
      prefs.setInt('currentGameKey', differenceFromToday.inDays % 2315);
    }
    int currentGameKey = prefs.getInt('currentGameKey')!;
    String data = await rootBundle
        .loadString("assets/json/possible_answers_shuffled.json");
    final jsonResult = jsonDecode(data);
    return jsonResult[currentGameKey];
  }

  @override
  Future<String> getNewGame() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    int currentGameKey = prefs.getInt('currentGameKey')!;
    int newGameKey = (currentGameKey + 1) % 2315;
    prefs.setInt('currentGameKey', newGameKey);
    String data = await rootBundle
        .loadString("assets/json/possible_answers_shuffled.json");
    final jsonResult = jsonDecode(data);
    return jsonResult[newGameKey];
  }

  Future<bool> isWordAcceptable(String word) async {
    word = word.toLowerCase();
    String possibleAnswersData = await rootBundle
        .loadString("assets/json/possible_answers_shuffled.json");
    final possibleAnswersJson = jsonDecode(possibleAnswersData);
    String acceptableWordsData =
        await rootBundle.loadString("assets/json/acceptable_words.json");
    final acceptableWordsJson = jsonDecode(acceptableWordsData);
    final allAcceptableWords = [...possibleAnswersJson, ...acceptableWordsJson];
    return allAcceptableWords
            .where((acceptableWord) => word == acceptableWord)
            .length ==
        1;
  }
}
