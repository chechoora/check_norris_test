import 'package:check_norris_test/domain/joke/joke_repository.dart';
import 'package:check_norris_test/domain/model/joke_item.dart';
import 'package:check_norris_test/view/search/search_state.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SearchNotifier extends StateNotifier<SearchState> {
  SearchNotifier({
    required this.jokeRepository,
  }) : super(IdleState());

  final JokeRepository jokeRepository;

  late List<JokeItem> jokeList;

  Future<void> searchJokes(String text) async {
    state = LoadingState();
    jokeList = await jokeRepository.searchJokes(text);
    state = DataState(
      jokes: jokeList,
    );
  }

  Future<void> addToFavorite(JokeItem joke) async {
    state = LoadingState();
    final newJokeItem = await jokeRepository.addToFavorite(joke);
    _updateJoke(newJokeItem);
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
      jokeList[index] = newJokeItem;
    }
  }
}
