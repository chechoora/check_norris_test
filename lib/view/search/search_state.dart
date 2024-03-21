import 'package:check_norris_test/domain/model/joke.dart';

abstract class SearchState {}

class LoadingState extends SearchState {}

class DataState extends SearchState {
  final List<Joke> jokes;

  DataState({
    required this.jokes,
  });
}
