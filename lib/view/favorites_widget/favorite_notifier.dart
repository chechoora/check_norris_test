import 'package:check_norris_test/domain/joke/joke_repository.dart';
import 'package:check_norris_test/domain/model/joke_item.dart';
import 'package:check_norris_test/view/favorites_widget/favorite_state.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class FavoriteNotifier extends StateNotifier<FavoriteState> {
  FavoriteNotifier({
    required this.jokeRepository,
  }) : super(LoadingState()) {
    _fetchStoredJokes();
  }

  final JokeRepository jokeRepository;

  late List<JokeItem> jokeList;

  Future<void> _fetchStoredJokes() async {
    state = LoadingState();
    jokeList = await jokeRepository.fetchStoredJokes();
    state = DataState(
      jokes: jokeList,
    );
  }

  Future<void> removeFromFavorite(JokeItem joke) async {
    state = LoadingState();
    final newJokeItem = await jokeRepository.removeFromFavorite(joke);
    _updateJoke(newJokeItem);
    state = DataState(
      jokes: jokeList,
    );
  }

  void _updateJoke(JokeItem newJokeItem) {
    final index = jokeList.indexWhere((joke) => joke.serverId == newJokeItem.serverId);
    if (index != -1) {
      jokeList.removeAt(index);
    }
  }
}
