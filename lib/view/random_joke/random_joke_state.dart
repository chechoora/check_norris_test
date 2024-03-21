import 'package:check_norris_test/domain/model/joke_item.dart';

abstract class RandomJokeState {}

class LoadingState extends RandomJokeState {}

class DataState extends RandomJokeState {
  final JokeItem randomJoke;

  DataState({required this.randomJoke});
}