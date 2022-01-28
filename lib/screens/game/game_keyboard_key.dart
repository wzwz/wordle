import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wordle/blocs/game/game.dart';
import 'package:wordle/models/game_model.dart';
import 'package:wordle/utils/constants.dart';

class GameKeyboardKey extends StatelessWidget {
  final String value;
  final double width;

  const GameKeyboardKey({
    Key? key,
    required this.value,
    required this.width,
  }) : super(key: key);

  Color? mapValueToColor(String value, GameModel gameModel) {
    if (gameModel.correct.contains(value)) {
      return ThemeDefault.colorCorrect;
    } else if (gameModel.partiallyCorrect.contains(value)) {
      return ThemeDefault.colorPartiallyCorrect;
    } else if (gameModel.wrong.contains(value)) {
      return ThemeDefault.colorWrong;
    }
    return ThemeDefault.colorPending;
  }

  @override
  Widget build(BuildContext context) {
    dynamic display = Text(value);
    if (value == 'DELETE') {
      display = const Icon(
        Icons.backspace,
        size: 20,
      );
    }
    return BlocBuilder<GameBloc, GameState>(builder: (context, state) {
      GameModel gameModel = state.gameModel;
      Color? keyColor = mapValueToColor(value, gameModel);
      return value == 'ENTER' || value == 'DELETE'
          ? Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 2),
                child: GestureDetector(
                  onTap: () => context.read<GameBloc>().add(KeyPressed(value)),
                  child: Container(
                    height: width * 1.3,
                    decoration: BoxDecoration(
                      color: keyColor,
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: Center(
                      child: display,
                    ),
                  ),
                ),
              ),
            )
          : Padding(
              padding: const EdgeInsets.symmetric(horizontal: 2),
              child: GestureDetector(
                onTap: () => context.read<GameBloc>().add(KeyPressed(value)),
                child: Container(
                  width: width,
                  height: width * 1.3,
                  decoration: BoxDecoration(
                    color: keyColor,
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: Center(
                    child: Text(value),
                  ),
                ),
              ),
            );
    });
  }
}
