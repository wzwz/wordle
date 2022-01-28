import 'package:flutter/material.dart';
import 'package:wordle/screens/game/game_keyboard_key.dart';

class GameKeyboardRow extends StatelessWidget {
  final List<String> keyboardRow;
  final double keyWidth;

  const GameKeyboardRow({
    Key? key,
    required this.keyboardRow,
    required this.keyWidth,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        vertical: 2,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: keyboardRow
            .map(
              (key) => GameKeyboardKey(
                value: key,
                width: keyWidth,
              ),
            )
            .toList(),
      ),
    );
  }
}
