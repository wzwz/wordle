import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wordle/blocs/game/game.dart';
import 'package:wordle/models/game_model.dart';
import 'package:wordle/repositories/game_repository/local_game_repository.dart';
import 'package:wordle/utils/game_helper.dart';

class GameBloc extends Bloc<GameEvent, GameState> {
  final LocalGameRepository _repository;

  GameBloc({required LocalGameRepository repository})
      : _repository = repository,
        super(GameLoading()) {
    on<LoadGame>(_onLoadGame);
    on<NewGame>(_onNewGame);
    on<RestartGame>(_onRestartGame);
    on<KeyPressed>(_onKeyPressed);
    on<ErrorDismissed>(_onErrorDismissed);
  }

  Future<void> _onLoadGame(LoadGame event, Emitter<GameState> emit) async {
    emit(GameReady(
        gameModel: GameModel(answer: await _repository.getCurrentGame())));
  }

  Future<void> _onNewGame(NewGame event, Emitter<GameState> emit) async {
    emit(GameReady(
        gameModel: GameModel(answer: await _repository.getNewGame())));
  }

  Future<void> _onRestartGame(
      RestartGame event, Emitter<GameState> emit) async {
    emit(GameReady(
        gameModel: GameModel(answer: await _repository.getCurrentGame())));
  }

  Future<void> _onKeyPressed(KeyPressed event, Emitter<GameState> emit) async {
    int currentAttempt = state.gameModel.currentAttempt;
    List<String> guessedWords = [...state.gameModel.guessedWords];
    List<String> correct = [...state.gameModel.correct];
    List<String> partiallyCorrect = [...state.gameModel.partiallyCorrect];
    List<String> wrong = [...state.gameModel.wrong];
    List<List<int>> guessResults = [...state.gameModel.guessResults];

    if (state is GameWon) {
      return;
    }

    switch (event.value) {
      case 'ENTER':
        if (guessedWords.isNotEmpty &&
            guessedWords.length == currentAttempt &&
            guessedWords[currentAttempt - 1].length == 5) {
          // check for invalid entry
          if (!await _repository
              .isWordAcceptable(guessedWords[currentAttempt - 1])) {
            // invalid entry
            print('invalid word entered');
            emit(GameError(
              gameModel: state.gameModel,
              error: 'You have entered an invalid word!',
            ));
            return;
          }
          // valid 5 letter word entered
          // result will be either correct or wrong
          // end result will be game won / game lost / next attempt
          String guess = guessedWords[currentAttempt - 1];

          List<int> result = getWordleResult(guess, state.gameModel.answer);
          guessResults.add(result);

          for (int i = 0; i < result.length; i++) {
            switch (result[i]) {
              case 1:
                if (!correct.contains(guess[i])) {
                  correct.add(guess[i]);
                }
                break;
              case 2:
                if (!partiallyCorrect.contains(guess[i])) {
                  partiallyCorrect.add(guess[i]);
                }
                break;
              case 3:
                if (!wrong.contains(guess[i])) {
                  wrong.add(guess[i]);
                }
                break;
            }
          }

          if (result.where((letterResult) => letterResult == 1).length == 5) {
            // correct 5 letter word entered
            emit(GameWon(
                gameModel: state.gameModel.copyWith(
              guessResults: guessResults,
              correct: correct,
              partiallyCorrect: partiallyCorrect,
              wrong: wrong,
            )));
          } else {
            // incorrect 5 letter word entered
            if (currentAttempt == 6) {
              // no more attempts
              print('no more attempts, game lost!');
              emit(GameLost(
                  gameModel: state.gameModel.copyWith(
                guessResults: guessResults,
                correct: correct,
                partiallyCorrect: partiallyCorrect,
                wrong: wrong,
              )));
            } else {
              // go to next attempt
              print(
                  'wrong word attempted, going to attempt #${currentAttempt + 1}');
              emit(GameReady(
                  gameModel: state.gameModel.copyWith(
                currentAttempt: currentAttempt + 1,
                guessResults: guessResults,
                correct: correct,
                partiallyCorrect: partiallyCorrect,
                wrong: wrong,
              )));
            }
          }
        }
        break;
      case 'DELETE':
        if (guessedWords.isNotEmpty &&
            guessedWords[currentAttempt - 1].isNotEmpty) {
          guessedWords[currentAttempt - 1] = guessedWords[currentAttempt - 1]
              .substring(0, guessedWords[currentAttempt - 1].length - 1);
        }
        emit(GameReady(
            gameModel: state.gameModel.copyWith(guessedWords: guessedWords)));
        break;
      default:
        if (guessedWords.length < currentAttempt) {
          guessedWords.add(event.value);
        } else if (guessedWords[currentAttempt - 1].length < 5) {
          guessedWords[currentAttempt - 1] += event.value;
        }
        emit(GameReady(
            gameModel: state.gameModel.copyWith(guessedWords: guessedWords)));
        break;
    }
  }

  Future<void> _onErrorDismissed(
      ErrorDismissed event, Emitter<GameState> emit) async {
    emit(GameReady(gameModel: state.gameModel));
  }
}
