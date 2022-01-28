import 'package:flutter/material.dart';
import 'package:wordle/screens/game/guess_letter_box.dart';
import 'package:wordle/utils/constants.dart';

class Logo extends StatelessWidget {
  final double? maxWidth, maxHeight;

  const Logo({
    Key? key,
    this.maxWidth = 160,
    this.maxHeight = 50,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Map<String, Color> logoData = {
      'W': ThemeDefault.colorCorrect,
      'O': ThemeDefault.colorWrong,
      'R': ThemeDefault.colorPartiallyCorrect,
      'D': ThemeDefault.colorCorrect,
      'L': ThemeDefault.colorPartiallyCorrect,
      'E': ThemeDefault.colorWrong,
    };
    List<Widget> logo = [];
    logoData.forEach((letter, color) {
      logo.add(GuessLetterBox(
        backgroundColor: color,
        borderColor: color,
        text: letter,
      ));
    });
    return SizedBox(
      width: maxWidth,
      height: maxHeight,
      child: FittedBox(
        child: Row(
          children: logo,
        ),
      ),
    );
  }
}
