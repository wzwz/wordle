import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wordle/blocs/bloc_observer.dart';
import 'package:wordle/blocs/game/game.dart';
import 'package:wordle/repositories/game_repository/local_game_repository.dart';
import 'package:wordle/screens/game/game.dart';
import 'package:wordle/screens/splash.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
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
      ],
      child: MaterialApp(
        title: 'WORDLE',
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
