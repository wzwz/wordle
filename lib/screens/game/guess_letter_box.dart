import 'package:flutter/material.dart';
import 'package:wordle/utils/constants.dart';

class GuessLetterBox extends StatelessWidget {
  final Color? borderColor;
  final Color? backgroundColor;
  final Color? textColor;
  final String text;

  const GuessLetterBox({
    Key? key,
    this.borderColor = ThemeDefault.colorPending,
    this.backgroundColor = ThemeDefault.colorBackground,
    this.textColor = Colors.black,
    this.text = '',
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: Container(
        width: 50,
        height: 50,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 3),
          child: Center(
            child: Text(
              text,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 28,
                color: Colors.white,
              ),
            ),
          ),
        ),
        decoration: BoxDecoration(
          color: backgroundColor,
          border: Border.all(
            color: borderColor!,
            width: ThemeDefault.guessBoxBorderWidth,
          ),
          borderRadius: BorderRadius.circular(5),
        ),
      ),
    );
  }
}
