import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:wordle/blocs/ad/ad.dart';
import 'package:wordle/blocs/game/game.dart';
import 'package:wordle/models/game_model.dart';
import 'package:wordle/screens/game/game_keyboard.dart';
import 'package:wordle/screens/game/guess_row.dart';
import 'package:wordle/utils/ad_helper.dart';
import 'package:wordle/utils/constants.dart';
import 'package:wordle/widgets/dialogs/game_error.dart';
import 'package:wordle/widgets/dialogs/game_help.dart';
import 'package:wordle/widgets/dialogs/game_lost.dart';
import 'package:wordle/widgets/dialogs/game_settings.dart';
import 'package:wordle/widgets/dialogs/game_won.dart';
import 'package:wordle/widgets/logo.dart';

class GameScreen extends StatefulWidget {
  static const String id = 'game';

  const GameScreen({Key? key}) : super(key: key);

  @override
  State<GameScreen> createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> {
  late BannerAd _bannerAd;
  bool _isBannerAdReady = false;
  InterstitialAd? _interstitialAd;

  @override
  void initState() {
    super.initState();
    _bannerAd = BannerAd(
      adUnitId: AdHelper.bannerAdUnitId,
      request: const AdRequest(),
      size: AdSize.banner,
      listener: BannerAdListener(
        onAdLoaded: (_) {
          setState(() {
            _isBannerAdReady = true;
          });
        },
        onAdFailedToLoad: (ad, err) {
          print('Failed to load a banner ad: ${err.message}');
          _isBannerAdReady = false;
          ad.dispose();
        },
      ),
    );

    _bannerAd.load();
    _loadInterstitialAd();
  }

  void _loadInterstitialAd() {
    InterstitialAd.load(
      adUnitId: AdHelper.interstitialAdUnitId,
      request: const AdRequest(),
      adLoadCallback: InterstitialAdLoadCallback(
        onAdLoaded: (ad) {
          _interstitialAd = ad;

          ad.fullScreenContentCallback = FullScreenContentCallback(
            onAdDismissedFullScreenContent: (ad) {
              context.read<AdBloc>().add(CloseInterstitialAd());
            },
          );
        },
        onAdFailedToLoad: (err) {
          print('Failed to load an interstitial ad: ${err.message}');
        },
      ),
    );
  }

  Future<void> _showGameDialog(Widget content) async {
    await showGeneralDialog(
      context: context,
      barrierLabel: "Barrier",
      barrierDismissible: true,
      barrierColor: Colors.black.withOpacity(0.5),
      transitionDuration: const Duration(milliseconds: 300),
      transitionBuilder: (_, anim, __, child) {
        return ScaleTransition(
          scale: anim,
          child: FadeTransition(
            opacity: anim,
            child: child,
          ),
        );
      },
      pageBuilder: (_, __, ___) => content,
    );
  }

  Future<void> _showGameWonDialog() async {
    await _showGameDialog(const GameWonDialog());
  }

  Future<void> _showGameLostDialog() async {
    await _showGameDialog(const GameLostDialog());
  }

  Future<void> _showErrorDialog() async {
    await _showGameDialog(const GameErrorDialog());
    context.read<GameBloc>().add(ErrorDismissed());
  }

  Future<void> _showHelpDialog() async {
    await _showGameDialog(const GameHelpDialog());
  }

  Future<void> _showSettingsDialog() async {
    await _showGameDialog(const GameSettingsDialog());
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
      listeners: [
        BlocListener<GameBloc, GameState>(
          listenWhen: (previous, current) {
            // when guess is submitted successfully
            return previous.gameModel.guessResults.length <
                current.gameModel.guessResults.length;
          },
          listener: (_, state) {
            // TODO animate correct / partially correct / wrong guess boxes
          },
        ),
        BlocListener<GameBloc, GameState>(
          listener: (_, state) {
            if (state is GameError) {
              print('game error');
              _showErrorDialog();
            }
            if (state is GameWon) {
              print('game won');
              _showGameWonDialog();
            }
            if (state is GameLost) {
              print('game lost');
              _showGameLostDialog();
            }
          },
        ),
        BlocListener<AdBloc, AdState>(
          listener: (_, state) {
            if (state is NoAdShown) {
              _loadInterstitialAd();
            }
            if (state is InterstitialAdShown) {
              print('show interstitial ad');
              _interstitialAd?.show();
            }
          },
        ),
      ],
      child: BlocBuilder<GameBloc, GameState>(
        builder: (context, state) {
          GameModel gameModel = state.gameModel;
          return SafeArea(
            child: Scaffold(
              backgroundColor: ThemeDefault.colorBackground,
              body: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Stack(
                    children: [
                      const Center(
                        child: Hero(
                          tag: 'logo',
                          child: Logo(),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            GestureDetector(
                              onTap: _showHelpDialog,
                              child: const Icon(Icons.help),
                            ),
                            const SizedBox(
                              height: 50,
                            ),
                            GestureDetector(
                              onTap: _showSettingsDialog,
                              child: const Icon(Icons.settings),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  Expanded(
                    child: FittedBox(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 10,
                          vertical: 20,
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            for (int i = 0; i < 6; i++)
                              GuessRow(
                                guessNumber: i + 1,
                                guessText: gameModel.guessedWords.length > i
                                    ? gameModel.guessedWords[i]
                                    : '',
                              ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  GameKeyboard(),
                  if (_isBannerAdReady && adsEnabled)
                    Align(
                      alignment: Alignment.topCenter,
                      child: SizedBox(
                        width: _bannerAd.size.width.toDouble(),
                        height: _bannerAd.size.height.toDouble(),
                        child: AdWidget(ad: _bannerAd),
                      ),
                    ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  @override
  void dispose() {
    _bannerAd.dispose();
    _interstitialAd?.dispose();
    super.dispose();
  }
}
