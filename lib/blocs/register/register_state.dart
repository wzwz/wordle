import 'package:equatable/equatable.dart';

abstract class RegisterState extends Equatable {
  const RegisterState();

  @override
  List<Object> get props => [];
}

class RegisterInitial extends RegisterState {}

class RegisterLoading extends RegisterState {}

class RegisterComplete extends RegisterState {}

class RegisterError extends RegisterState {
  final String error;

  const RegisterError(this.error);

  @override
  List<Object> get props => [error];
}
