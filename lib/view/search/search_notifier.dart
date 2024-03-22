import 'package:check_norris_test/domain/joke/joke_favorite_listener.dart';
import 'package:check_norris_test/domain/joke/joke_repository.dart';
import 'package:check_norris_test/domain/model/joke_item.dart';
import 'package:check_norris_test/domain/model/result.dart';
import 'package:check_norris_test/view/search/search_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SearchNotifier extends StateNotifier<SearchState> {
  SearchNotifier({
    required this.jokeRepository,
    required this.favoriteListener,
  }) : super(IdleState()) {
    favoriteListener.addListener(onUpdateFavorite);
  }

  final JokeRepository jokeRepository;
  final JokeFavoriteListener favoriteListener;

  late List<JokeItem> jokeList;
  late VoidCallback onUpdateFavorite = () {
    final query = lastSearchQuery;
    if (query != null) {
      searchJokes(query);
    }
  };

  String? lastSearchQuery;

  @override
  void dispose() {
    favoriteListener.removeListener(onUpdateFavorite);
    super.dispose();
  }

  Future<void> searchJokes(String text) async {
    lastSearchQuery = text;
    state = LoadingState();
    final result = await jokeRepository.searchJokes(text);
    switch (result) {
      case ErrorResult<List<JokeItem>>():
        state = ErrorState();
      case DataResult<List<JokeItem>>():
        jokeList = result.data;
        state = DataState(
          jokes: jokeList,
        );
    }
  }

  Future<void> addToFavorite(JokeItem joke) async {
    final newJokeItem = await jokeRepository.addToFavorite(joke);
    _updateJoke(newJokeItem);
    state = DataState(
      jokes: jokeList,
    );
  }

  Future<void> removeFromFavorite(JokeItem joke) async {
    final newJokeItem = await jokeRepository.removeFromFavorite(joke);
    _updateJoke(newJokeItem);
    state = DataState(
      jokes: jokeList,
    );
  }

  void _updateJoke(JokeItem newJokeItem) {
    final index = jokeList.indexWhere((joke) => joke.serverId == newJokeItem.serverId);
    if (index != -1) {
      jokeList[index] = newJokeItem;
    }
  }

  void retrySearch() {
    final query = lastSearchQuery;
    if (query != null) {
      searchJokes(query);
    }
  }
}
