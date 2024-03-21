import 'package:check_norris_test/domain/joke/joke_repository.dart';
import 'package:check_norris_test/view/search/search_state.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SearchNotifier extends StateNotifier<SearchState> {
  SearchNotifier({
    required this.jokeRepository,
  }) : super(LoadingState());

  final JokeRepository jokeRepository;

  Future<void> searchJokes(String text) async {
    state = LoadingState();
    state = DataState(
      jokes: await jokeRepository.searchJokes(text),
    );
  }
}
