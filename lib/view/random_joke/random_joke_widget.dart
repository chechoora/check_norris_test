import 'package:check_norris_test/di/repository.dart';
import 'package:check_norris_test/view/random_joke/random_joke_notifier.dart';
import 'package:check_norris_test/view/random_joke/random_joke_state.dart';
import 'package:check_norris_test/view/util/simple_loading_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class RandomJokeWidget extends ConsumerWidget {
  RandomJokeWidget({
    required this.category,
    super.key,
  });

  final String category;

  late final notifier = StateNotifierProvider.autoDispose<RandomJokeNotifier, RandomJokeState>((ref) {
    return RandomJokeNotifier(
      category: category,
      jokeRepository: ref.read(jokeRepository),
    );
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(notifier);
    return Scaffold(
      appBar: AppBar(),
      body: _buildBody(state),
    );
  }

  Widget _buildBody(RandomJokeState state) {
    if (state is LoadingState) {
      return const SimpleLoadingWidget();
    } else if (state is DataState) {
      final joke = state.randomJoke;
      return Center(
        child: Text(joke.text),
      );
    }
    throw ArgumentError('No widget for current state: $state');
  }
}
