import 'package:check_norris_test/domain/joke/joke_repository.dart';
import 'package:check_norris_test/domain/model/joke_item.dart';
import 'package:check_norris_test/view/random_joke/random_joke_state.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class RandomJokeNotifier extends StateNotifier<RandomJokeState> {
  RandomJokeNotifier({
    required this.category,
    required this.jokeRepository,
  }) : super(LoadingState()) {
    _fetchRandomJoke();
  }

  final String category;
  final JokeRepository jokeRepository;

  Future<void> _fetchRandomJoke() async {
    state = LoadingState();
    state = DataState(randomJoke: await jokeRepository.fetchRandomJokeByCategory(category));
  }

  Future<void> addToFavorite(JokeItem joke) async {
    state = LoadingState();
    final newJokeItem = await jokeRepository.addToFavorite(joke);
    state = DataState(
      randomJoke: newJokeItem,
    );
  }

  Future<void> removeFromFavorite(JokeItem joke) async {
    state = LoadingState();
    final newJokeItem = await jokeRepository.removeFromFavorite(joke);
    state = DataState(
      randomJoke: newJokeItem,
    );
  }
}
