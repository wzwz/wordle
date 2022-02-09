import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wordle/blocs/bloc_observer.dart';
import 'package:wordle/blocs/game/game.dart';
import 'package:wordle/firebase_options.dart';
import 'package:wordle/repositories/auth_repository/auth_repository.dart';
import 'package:wordle/repositories/game_repository/local_game_repository.dart';
import 'package:wordle/screens/game/game.dart';
import 'package:wordle/screens/home.dart';
import 'package:wordle/screens/login.dart';
import 'package:wordle/screens/register.dart';
import 'package:wordle/screens/splash.dart';
import 'blocs/ad/ad.dart';
import 'blocs/auth/auth.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
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
        BlocProvider<AuthBloc>(
          create: (BuildContext context) =>
              AuthBloc(repository: AuthRepository()),
        ),
        BlocProvider<GameBloc>(
          create: (BuildContext context) =>
              GameBloc(repository: LocalGameRepository()),
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
          inputDecorationTheme: const InputDecorationTheme(
            isDense: true,
            iconColor: Colors.white54,
            floatingLabelStyle: TextStyle(
              color: Colors.white,
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: Colors.white,
              ),
            ),
          ),
        ),
        routes: {
          SplashScreen.id: (context) => const SplashScreen(),
          LoginScreen.id: (context) => const LoginScreen(),
          RegisterScreen.id: (context) => const RegisterScreen(),
          HomeScreen.id: (context) => const HomeScreen(),
          GameScreen.id: (context) => const GameScreen(),
        },
      ),
    );
  }
}
