import 'package:equatable/equatable.dart';

abstract class GameEvent extends Equatable {
  const GameEvent();

  @override
  List<Object> get props => [];
}

class LoadGame extends GameEvent {}

class GameLoaded extends GameEvent {
  final String answer;

  const GameLoaded(this.answer);
}

class KeyPressed extends GameEvent {
  final String value;

  const KeyPressed(this.value);
}

class ErrorDismissed extends GameEvent {}

class NewGame extends GameEvent {}

class RestartGame extends GameEvent {}
