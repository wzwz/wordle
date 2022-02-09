import 'package:equatable/equatable.dart';
import 'package:wordle/models/user_model.dart';

enum AuthStatus {
  authenticated,
  unauthenticated,
}

abstract class AuthState extends Equatable {
  final AuthStatus status;
  final User user;

  const AuthState({
    required this.status,
    this.user = User.empty,
  });

  @override
  List<Object> get props => [];
}

class AuthError extends AuthState {
  final String error;

  const AuthError({
    required this.error,
  }) : super(
          status: AuthStatus.unauthenticated,
        );
}

class AuthAuthenticated extends AuthState {
  const AuthAuthenticated({
    required User user,
  }) : super(
          status: AuthStatus.authenticated,
          user: user,
        );
}

class AuthUnauthenticated extends AuthState {
  const AuthUnauthenticated() : super(status: AuthStatus.unauthenticated);
}
