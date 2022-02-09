import 'package:equatable/equatable.dart';
import 'package:wordle/models/user_model.dart';

abstract class AuthEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class AuthCheck extends AuthEvent {}

class SignUp extends AuthEvent {
  final String email, password;

  SignUp(this.email, this.password);

  @override
  List<Object> get props => [email, password];
}

class LogIn extends AuthEvent {
  final String email, password;

  LogIn(this.email, this.password);

  @override
  List<Object> get props => [email, password];
}

class LogInAnonymously extends AuthEvent {}

class UserChanged extends AuthEvent {
  final User user;

  UserChanged(this.user);

  @override
  List<Object> get props => [user];
}

class LogOut extends AuthEvent {}
