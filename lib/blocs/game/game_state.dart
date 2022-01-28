import 'package:equatable/equatable.dart';
import 'package:wordle/models/game_model.dart';

abstract class GameState extends Equatable {
  final GameModel gameModel;

  const GameState({
    this.gameModel = const GameModel(),
  });

  @override
  List<Object> get props => [gameModel];
}

class GameLoading extends GameState {}

class GameReady extends GameState {
  const GameReady({required GameModel gameModel}) : super(gameModel: gameModel);
}

class GameNotLoaded extends GameState {}

class GameError extends GameState {
  final String error;

  const GameError({
    required GameModel gameModel,
    required this.error,
  }) : super(gameModel: gameModel);
}

class GameWon extends GameState {
  const GameWon({required GameModel gameModel}) : super(gameModel: gameModel);
}

class GameLost extends GameState {
  const GameLost({required GameModel gameModel}) : super(gameModel: gameModel);
}
