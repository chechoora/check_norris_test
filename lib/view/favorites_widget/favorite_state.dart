import 'package:check_norris_test/domain/model/joke_item.dart';

abstract class FavoriteState {}

class LoadingState extends FavoriteState {}

class DataState extends FavoriteState {
  final List<JokeItem> jokes;

  DataState({
    required this.jokes,
  });
}
