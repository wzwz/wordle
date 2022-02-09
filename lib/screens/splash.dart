import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wordle/blocs/auth/auth.dart';
import 'package:wordle/screens/home.dart';
import 'package:wordle/screens/login.dart';
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
    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) async {
        await Future.delayed(const Duration(seconds: 1));
        if (state is AuthUnauthenticated) {
          Navigator.of(context)
              .pushNamedAndRemoveUntil(LoginScreen.id, (route) => false);
        }
        if (state is AuthAuthenticated) {
          Navigator.of(context)
              .pushNamedAndRemoveUntil(HomeScreen.id, (route) => false);
        }
      },
      child: const Scaffold(
        backgroundColor: ThemeDefault.colorBackground,
        body: SafeArea(
          child: Center(
            child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 10),
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
      ),
    );
  }
}
