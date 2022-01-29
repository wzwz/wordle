import 'package:flutter/material.dart';
import 'package:wordle/screens/game/guess_letter_box.dart';
import 'package:wordle/utils/constants.dart';

class GameHelpDialog extends StatelessWidget {
  const GameHelpDialog({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dialog(
      insetPadding: const EdgeInsets.all(10),
      backgroundColor: ThemeDefault.colorPending,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.0),
      ),
      child: SizedBox(
        width: double.infinity,
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                'How to play?',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 26,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 20),
              const Text('Type a 5-letter word and tap "ENTER" to submit'),
              const SizedBox(height: 15),
              const Example(
                data: {
                  'S': ThemeDefault.colorCorrect,
                  'H': ThemeDefault.colorCorrect,
                  'E': ThemeDefault.colorPartiallyCorrect,
                  'A': ThemeDefault.colorPartiallyCorrect,
                  'R': ThemeDefault.colorWrong,
                },
                maxHeight: null,
              ),
              const SizedBox(height: 15),
              RichText(
                text: const TextSpan(
                  children: [
                    TextSpan(
                      text: 'Green',
                      style: TextStyle(
                        color: ThemeDefault.colorCorrect,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    TextSpan(
                        text:
                            ' - this letter is present in the answer and in its correct place.'),
                  ],
                ),
              ),
              const SizedBox(height: 15),
              RichText(
                text: const TextSpan(
                  children: [
                    TextSpan(
                      text: 'Orange',
                      style: TextStyle(
                        color: ThemeDefault.colorPartiallyCorrect,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    TextSpan(
                        text:
                            ' - this letter is present in the answer, but is incorrectly placed.'),
                  ],
                ),
              ),
              const SizedBox(height: 15),
              const Example(
                data: {
                  'S': ThemeDefault.colorCorrect,
                  'H': ThemeDefault.colorCorrect,
                  'A': ThemeDefault.colorCorrect,
                  'R': ThemeDefault.colorWrong,
                  'E': ThemeDefault.colorCorrect,
                },
                maxHeight: null,
              ),
              const SizedBox(height: 15),
              RichText(
                text: const TextSpan(
                  children: [
                    TextSpan(
                      text: 'Black',
                      style: TextStyle(
                        color: ThemeDefault.colorWrong,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    TextSpan(
                        text:
                            ' - this letter is not present anywhere in the answer.'),
                  ],
                ),
              ),
              const SizedBox(height: 15),
              const Example(
                data: {
                  'S': ThemeDefault.colorCorrect,
                  'H': ThemeDefault.colorCorrect,
                  'A': ThemeDefault.colorCorrect,
                  'P': ThemeDefault.colorCorrect,
                  'E': ThemeDefault.colorCorrect,
                },
                maxHeight: null,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class Example extends StatelessWidget {
  final double? maxWidth, maxHeight;
  final Map<String, Color> data;

  const Example({
    Key? key,
    required this.data,
    this.maxWidth = 160,
    this.maxHeight = 50,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<Widget> logo = [];
    data.forEach((letter, color) {
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
