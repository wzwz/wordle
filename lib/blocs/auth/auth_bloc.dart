import 'dart:async';
import 'package:wordle/blocs/auth/auth_state.dart';
import 'package:wordle/blocs/auth/auth_event.dart';
import 'package:wordle/models/user_model.dart';
import 'package:wordle/repositories/auth_repository/auth_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthRepository _repository;
  late final StreamSubscription<User> userSubscription;

  AuthBloc({required AuthRepository repository})
      : _repository = repository,
        super(
          repository.currentUser.isNotEmpty
              ? AuthAuthenticated(user: repository.currentUser)
              : const AuthUnauthenticated(),
        ) {
    on<UserChanged>(_onUserChanged);
    on<SignUp>(_onSignUp);
    on<LogIn>(_onLogIn);
    on<LogInAnonymously>(_onLogInAnonymously);
    on<LogOut>(_onLogOut);
    userSubscription = _repository.user.listen(
      (user) => add(UserChanged(user)),
    );
  }

  void _onUserChanged(UserChanged event, Emitter<AuthState> emit) {
    emit(event.user.isNotEmpty
        ? AuthAuthenticated(user: event.user)
        : const AuthUnauthenticated());
  }

  Future<void> _onLogOut(LogOut event, Emitter<AuthState> emit) async {
    print('_onLogOut');
    await _repository.signOut();
    emit(const AuthUnauthenticated());
  }

  Future<void> _onLogIn(LogIn event, Emitter<AuthState> emit) async {
    print('_onLogIn');
    try {
      await _repository.logInWithEmailAndPassword(
          email: event.email, password: event.password);
      emit(AuthAuthenticated(user: _repository.currentUser));
    } on LogInWithEmailAndPasswordFailure catch (e) {
      emit(AuthError(error: e.message));
      emit(const AuthUnauthenticated());
    } catch (e) {
      print(e);
      emit(const AuthError(error: 'An unknown error occurred.'));
      emit(const AuthUnauthenticated());
    }
  }

  Future<void> _onLogInAnonymously(LogInAnonymously event, Emitter<AuthState> emit) async {
    print('_onLogInAnonymously');
    try {
      await _repository.logInAnonymously();
      emit(AuthAuthenticated(user: _repository.currentUser));
    } on LogInWithEmailAndPasswordFailure catch (e) {
      emit(AuthError(error: e.message));
      emit(const AuthUnauthenticated());
    } catch (e) {
      print(e);
      emit(const AuthError(error: 'An unknown error occurred.'));
      emit(const AuthUnauthenticated());
    }
  }

  Future<void> _onSignUp(SignUp event, Emitter<AuthState> emit) async {
    print('_onSignUp');
    try {
      await _repository.signUp(email: event.email, password: event.password);
      emit(AuthAuthenticated(user: _repository.currentUser));
    } on SignUpWithEmailAndPasswordFailure catch (e) {
      emit(AuthError(error: e.message));
      emit(const AuthUnauthenticated());
    } catch (e) {
      print(e);
      emit(const AuthError(error: 'An unknown error occurred.'));
      emit(const AuthUnauthenticated());
    }
  }

  @override
  Future<void> close() {
    userSubscription.cancel();
    return super.close();
  }
}
