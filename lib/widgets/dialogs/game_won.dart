import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wordle/blocs/ad/ad.dart';
import 'package:wordle/blocs/game/game.dart';
import 'package:wordle/utils/constants.dart';

class GameWonDialog extends StatelessWidget {
  const GameWonDialog({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dialog(
        backgroundColor: ThemeDefault.colorCorrect,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.0),
        ),
        child: SizedBox(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  'Congratulations',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 26,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 10),
                const Text(
                  'You have guessed the word correctly!',
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 15),
                InkWell(
                  onTap: () {
                    context.read<GameBloc>().add(NewGame());
                  if (adsEnabled) {
                    context.read<AdBloc>().add(ShowInterstitialAd());
                  }
                    Navigator.of(context).pop();
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      color: ThemeDefault.colorWrong,
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text('New Game'),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      );
  }
}