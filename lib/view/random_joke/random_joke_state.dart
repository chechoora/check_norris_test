import 'package:check_norris_test/domain/model/random_joke.dart';

abstract class RandomJokeState {}

class LoadingState extends RandomJokeState {}

class DataState extends RandomJokeState {
  final RandomJoke randomJoke;

  DataState({required this.randomJoke});
}
