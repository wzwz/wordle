import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wordle/blocs/game/game.dart';
import 'package:wordle/models/game_model.dart';
import 'package:wordle/screens/game/guess_letter_box.dart';
import 'package:wordle/utils/constants.dart';

class GuessRow extends StatelessWidget {
  final int guessNumber;
  final String guessText;

  const GuessRow({Key? key, required this.guessNumber, this.guessText = ''})
      : super(key: key);

  Color? mapResultToColor(int result) {
    switch (result) {
      case 1:
        return ThemeDefault.colorCorrect;
      case 2:
        return ThemeDefault.colorPartiallyCorrect;
      case 3:
        return ThemeDefault.colorWrong;
    }
    return ThemeDefault.colorPending;
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GameBloc, GameState>(
      builder: (context, state) {
        GameModel gameModel = state.gameModel;
        List<Color?> guessLetterBoxColors = [];
        if (gameModel.guessResults.length >= guessNumber) {
          guessLetterBoxColors = gameModel.guessResults[guessNumber - 1]
              .map((result) => mapResultToColor(result))
              .toList();
        }
        return Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            for (int i = 0; i < 5; i++)
              GuessLetterBox(
                text: guessText.length > i ? guessText[i] : '',
                backgroundColor: gameModel.guessResults.length >= guessNumber
                    ? guessLetterBoxColors[i]
                    : ThemeDefault.colorGuessBoxBg,
                borderColor: gameModel.guessResults.length >= guessNumber
                    ? guessLetterBoxColors[i]
                    : ThemeDefault.colorGuessBoxBorder,
              ),
          ],
        );
      },
    );
  }
}
