List<int> getWordleResult(String guess, String answer) {
  guess = guess.toLowerCase();
  answer = answer.toLowerCase();
  List<int> result = [3, 3, 3, 3, 3];

  // mark all correct letters
  for (int i = 0; i < 5; i++) {
    if (guess[i] == answer[i]) {
      result[i] = 1;
      guess = guess.replaceRange(i, i + 1, ' ');
      answer = answer.replaceRange(i, i + 1, ' ');
    }
  }
  // mark all partially correct letters
  for (int i = 0; i < 5; i++) {
    if (guess[i] != ' ' && answer.contains(guess[i])) {
      result[i] = 2;
      answer = answer.replaceRange(
          answer.indexOf(guess[i]), answer.indexOf(guess[i]) + 1, ' ');
    }
  }
  return result;
}
