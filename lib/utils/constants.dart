import 'package:flutter/material.dart';

class ThemeDefault {
  static const colorBackground = Colors.black;
  static const colorPrimary = Colors.blue;
  static const colorOnPrimary = Colors.white;
  static const colorError = Colors.red;

  static const colorCorrect = Colors.green;
  static const colorPartiallyCorrect = Color(0xFFF9A825);
  static const colorWrong = Color(0xFF424242);
  static const colorOnWrong = Colors.white;
  static const colorPending = Color(0xFF757575);

  static const colorGuessBoxBg = colorBackground;
  static const colorGuessBoxBorder = Color(0xFF757575);

  static const double guessBoxBorderWidth = 2;
}

Future<void> showGameDialog({
  required BuildContext context,
  required Widget child,
}) async {
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
    pageBuilder: (_, __, ___) => child,
  );
}

extension ShowSnackBar on BuildContext {
  void showSnackBar({
    required String message,
    Color backgroundColor = ThemeDefault.colorPrimary,
    Color textColor = ThemeDefault.colorOnPrimary,
  }) {
    ScaffoldMessenger.of(this)
      ..hideCurrentSnackBar()
      ..showSnackBar(SnackBar(
        content: Text(
          message,
          style: TextStyle(
            color: textColor,
          ),
        ),
        backgroundColor: backgroundColor,
        behavior: SnackBarBehavior.floating,
      ));
  }

  void showErrorSnackBar({required String message}) {
    showSnackBar(
      message: message,
      backgroundColor: ThemeDefault.colorError,
    );
  }
}
