import 'package:equatable/equatable.dart';

abstract class LoginEvent extends Equatable {
  const LoginEvent();

  @override
  List<Object> get props => [];
}

class LoginAttempted extends LoginEvent {}

class LoginSuccessful extends LoginEvent {}

class LoginFailed extends LoginEvent {
  final String error;

  const LoginFailed({required this.error});

  @override
  List<Object> get props => [error];
}
