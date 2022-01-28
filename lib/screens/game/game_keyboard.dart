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
    double maxWidth = queryData.size.width > 400 ? 400 : queryData.size.width;
    double keyWidth = (maxWidth - 4) / keyboardRows[0].length - 4;
    return SizedBox(
      width: queryData.size.width > 400 ? 400 : double.infinity,
      child: Padding(
        padding: const EdgeInsets.all(2),
        child: Column(
          children: keyboardRows
              .map((row) => GameKeyboardRow(
                    keyboardRow: row,
                    keyWidth: keyWidth,
                  ))
              .toList(),
        ),
      ),
    );
  }
}
