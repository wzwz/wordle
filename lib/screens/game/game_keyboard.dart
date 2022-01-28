import 'package:flutter/material.dart';
import 'package:wordle/screens/game/game_keyboard_row.dart';

class GameKeyboard extends StatelessWidget {
  final List<List<String>> keyboardRows = [
    ['Q', 'W', 'E', 'R', 'T', 'Y', 'U', 'I', 'O', 'P'],
    ['A', 'S', 'D', 'F', 'G', 'H', 'J', 'K', 'L'],
    ['ENTER', 'Z', 'X', 'C', 'V', 'B', 'N', 'M', 'DELETE']
  ];

  GameKeyboard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    MediaQueryData queryData = MediaQuery.of(context);
    double keyWidth = (queryData.size.width - 4) / keyboardRows[0].length - 4;
    return Padding(
      padding: const EdgeInsets.all(2),
      child: Column(
        children: keyboardRows
            .map((row) => GameKeyboardRow(
                  keyboardRow: row,
                  keyWidth: keyWidth,
                ))
            .toList(),
      ),
    );
  }
}
