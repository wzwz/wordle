import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wordle/blocs/login/login.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc() : super(LoginInitial()) {
    on<LoginAttempted>(_onLoginAttempted);
    on<LoginSuccessful>(_onLoginSuccessful);
    on<LoginFailed>(_onLoginFailed);
  }

  void _onLoginAttempted(LoginAttempted event, Emitter<LoginState> emit) {
    emit(LoginLoading());
  }

  void _onLoginSuccessful(LoginSuccessful event, Emitter<LoginState> emit) {
    emit(LoginComplete());
  }

  void _onLoginFailed(LoginFailed event, Emitter<LoginState> emit) {
    emit(LoginError(event.error));
  }
}
