import 'package:equatable/equatable.dart';

abstract class RegisterEvent extends Equatable {
  const RegisterEvent();

  @override
  List<Object> get props => [];
}

class RegisterAttempted extends RegisterEvent {}

class RegisterSuccessful extends RegisterEvent {}

class RegisterFailed extends RegisterEvent {
  final String error;

  const RegisterFailed({required this.error});

  @override
  List<Object> get props => [error];
}
