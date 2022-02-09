import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wordle/blocs/auth/auth.dart';
import 'package:wordle/blocs/game/game.dart';
import 'package:wordle/mixins/auth_required.dart';
import 'package:wordle/screens/game/game.dart';
import 'package:wordle/utils/constants.dart';
import 'package:wordle/widgets/logo.dart';

class HomeScreen extends StatefulWidget {
  static const String id = 'home';

  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with AuthRequired {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ThemeDefault.colorBackground,
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Column(
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
                            onTap: () {},
                            child: const Icon(Icons.help),
                          ),
                          const SizedBox(
                            height: 50,
                          ),
                          GestureDetector(
                            onTap: () {
                              context.read<AuthBloc>().add(LogOut());
                            },
                            child: const Icon(Icons.settings),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Column(
                    children: [
                      InkWell(
                        onTap: () {
                          context.read<GameBloc>().add(NewGame());
                          Navigator.of(context).pushNamed(GameScreen.id);
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            color: ThemeDefault.colorPending,
                            borderRadius: BorderRadius.circular(5),
                          ),
                          child: const Padding(
                            padding: EdgeInsets.all(16),
                            child: Center(
                              child: Text(
                                'Word Of The Day',
                                style: TextStyle(
                                  fontSize: 20,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),
                      InkWell(
                        onTap: () {
                          context.read<GameBloc>().add(NewGame());
                          Navigator.of(context).pushNamed(GameScreen.id);
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            color: ThemeDefault.colorPending,
                            borderRadius: BorderRadius.circular(5),
                          ),
                          child: const Padding(
                            padding: EdgeInsets.all(16),
                            child: Center(
                              child: Text(
                                'Quick Game',
                                style: TextStyle(
                                  fontSize: 20,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),
                      InkWell(
                        onTap: () {
                          context.read<GameBloc>().add(NewGame());
                          Navigator.of(context).pushNamed(GameScreen.id);
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            color: ThemeDefault.colorPending,
                            borderRadius: BorderRadius.circular(5),
                          ),
                          child: const Padding(
                            padding: EdgeInsets.all(16),
                            child: Center(
                              child: Text(
                                'Time Attack Versus',
                                style: TextStyle(
                                  fontSize: 20,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 0),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
