import 'package:check_norris_test/domain/model/joke_item.dart';

abstract class SearchState {}

class IdleState extends SearchState {}

class LoadingState extends SearchState {}

class DataState extends SearchState {
  final List<JokeItem> jokes;

  DataState({
    required this.jokes,
  });
}
