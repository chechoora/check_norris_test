import 'package:check_norris_test/domain/joke/joke_repository.dart';
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
}
