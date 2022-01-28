import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wordle/blocs/game/game.dart';
import 'package:wordle/screens/game/game.dart';
import 'package:wordle/utils/constants.dart';
import 'package:wordle/widgets/logo.dart';

class SplashScreen extends StatefulWidget {
  static const String id = '/';

  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocListener<GameBloc, GameState>(
      listener: (context, state) async {
        await Future.delayed(const Duration(seconds: 1));
        if (state is GameNotLoaded) {
          print('game not loaded');
        }
        if (state is GameReady) {
          Navigator.of(context)
              .pushNamedAndRemoveUntil(GameScreen.id, (route) => false);
        }
      },
      child: const Scaffold(
        backgroundColor: ThemeDefault.colorBackground,
        body: SafeArea(
          child: Center(
            child: Hero(
              tag: 'logo',
              child: Logo(
                maxWidth: null,
                maxHeight: null,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
