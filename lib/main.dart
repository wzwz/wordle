import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wordle/blocs/bloc_observer.dart';
import 'package:wordle/blocs/game/game.dart';
import 'package:wordle/repositories/game_repository/local_game_repository.dart';
import 'package:wordle/screens/game/game.dart';
import 'package:wordle/screens/splash.dart';
import 'blocs/ad/ad.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  MobileAds.instance.initialize();
  MobileAds.instance.updateRequestConfiguration(RequestConfiguration(
      testDeviceIds: ["636061B01559E7B8712DB0EB6C172ACB"]));
  BlocOverrides.runZoned(
    () => runApp(const App()),
    blocObserver: SimpleBlocObserver(),
  );
}

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<GameBloc>(
          create: (BuildContext context) =>
              GameBloc(repository: LocalGameRepository())..add(LoadGame()),
        ),
        BlocProvider<AdBloc>(
          create: (BuildContext context) => AdBloc(),
        ),
      ],
      child: MaterialApp(
        title: 'Wordley - Unlimited Plays',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          brightness: Brightness.dark,
        ),
        routes: {
          SplashScreen.id: (context) => const SplashScreen(),
          GameScreen.id: (context) => const GameScreen(),
        },
      ),
    );
  }
}
