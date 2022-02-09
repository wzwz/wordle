import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wordle/blocs/auth/auth.dart';
import 'package:wordle/models/user_model.dart';
import 'package:wordle/screens/login.dart';
import 'package:wordle/utils/constants.dart';

mixin AuthRequired<T extends StatefulWidget> on State<T> {
  @override
  void initState() {
    context.read<AuthBloc>().userSubscription.onData((user) {
      if (user == User.empty) {
        Navigator.of(context)
            .pushNamedAndRemoveUntil(LoginScreen.id, (route) => false);
        context.showSnackBar(message: 'You have been logged out!');
      }
    });
    super.initState();
  }
}
