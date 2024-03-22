import 'dart:ui';

import 'package:check_norris_test/domain/joke/joke_favorite_listener.dart';
import 'package:check_norris_test/domain/joke/joke_repository.dart';
import 'package:check_norris_test/domain/model/joke_item.dart';
import 'package:check_norris_test/view/favorites_widget/favorite_state.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class FavoriteNotifier extends StateNotifier<FavoriteState> {
  FavoriteNotifier({
    required this.jokeRepository,
    required this.favoriteListener,
  }) : super(LoadingState()) {
    _fetchStoredJokes();
    favoriteListener.addListener(onUpdateFavorite);
  }

  final JokeRepository jokeRepository;
  final JokeFavoriteListener favoriteListener;

  late List<JokeItem> jokeList;
  late VoidCallback onUpdateFavorite = () {
    _fetchStoredJokes();
  };

  @override
  void dispose() {
    favoriteListener.removeListener(onUpdateFavorite);
    super.dispose();
  }

  Future<void> removeFromFavorite(JokeItem joke) async {
    final newJokeItem = await jokeRepository.removeFromFavorite(joke);
    _updateJoke(newJokeItem);
    state = DataState(
      jokes: jokeList,
    );
  }

  Future<void> _fetchStoredJokes() async {
    state = LoadingState();
    jokeList = await jokeRepository.fetchStoredJokes();
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
