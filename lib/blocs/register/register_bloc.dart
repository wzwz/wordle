import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wordle/blocs/register/register.dart';

class RegisterBloc extends Bloc<RegisterEvent, RegisterState> {
  RegisterBloc() : super(RegisterInitial()) {
    on<RegisterAttempted>(_onRegisterAttempted);
    on<RegisterSuccessful>(_onRegisterSuccessful);
    on<RegisterFailed>(_onRegisterFailed);
  }

  void _onRegisterAttempted(RegisterAttempted event, Emitter<RegisterState> emit) {
    emit(RegisterLoading());
  }

  void _onRegisterSuccessful(RegisterSuccessful event, Emitter<RegisterState> emit) {
    emit(RegisterComplete());
  }

  void _onRegisterFailed(RegisterFailed event, Emitter<RegisterState> emit) {
    emit(RegisterError(event.error));
  }
}
