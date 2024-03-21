import 'package:check_norris_test/domain/model/joke.dart';

abstract class RandomJokeState {}

class LoadingState extends RandomJokeState {}

class DataState extends RandomJokeState {
  final Joke randomJoke;

  DataState({required this.randomJoke});
}
