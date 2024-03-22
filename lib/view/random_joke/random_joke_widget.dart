import 'package:check_norris_test/di/repository.dart';
import 'package:check_norris_test/domain/model/joke_item.dart';
import 'package:check_norris_test/view/random_joke/random_joke_notifier.dart';
import 'package:check_norris_test/view/random_joke/random_joke_state.dart';
import 'package:check_norris_test/view/util/display_error_widget.dart';
import 'package:check_norris_test/view/util/simple_loading_widget.dart';
import 'package:flutter/cupertino.dart';
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
      appBar: AppBar(
        title: Text(category),
      ),
      body: _DisplayWidget(
        state: state,
        onAddToFavorite: (joke) {
          ref.read(notifier.notifier).addToFavorite(joke);
        },
        onRemoveFromFavorite: (joke) {
          ref.read(notifier.notifier).removeFromFavorite(joke);
        },
        onRetryRequested: () {
          ref.read(notifier.notifier).fetchRandomJoke();
        },
      ),
    );
  }
}

class _DisplayWidget extends StatelessWidget {
  const _DisplayWidget({
    required this.state,
    this.onAddToFavorite,
    this.onRemoveFromFavorite,
    this.onRetryRequested,
  });

  final RandomJokeState state;
  final ValueChanged<JokeItem>? onAddToFavorite;
  final ValueChanged<JokeItem>? onRemoveFromFavorite;
  final VoidCallback? onRetryRequested;

  @override
  Widget build(BuildContext context) {
    switch (state) {
      case LoadingState():
        return const SimpleLoadingWidget();
      case DataState():
        final joke = (state as DataState).randomJoke;
        return Container(
          decoration: BoxDecoration(
            border: Border.all(
              color: Theme.of(context).primaryColor,
            ),
            borderRadius: BorderRadius.circular(10),
          ),
          margin: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
          padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
          child: Row(
            children: [
              Expanded(
                child: Text(
                  joke.text,
                  style: const TextStyle(
                    fontSize: 18,
                  ),
                ),
              ),
              IconButton(
                icon: joke.isStored ? const Icon(Icons.favorite) : const Icon(Icons.favorite_outline),
                onPressed: () {
                  if (joke.isStored) {
                    onRemoveFromFavorite?.call(joke);
                  } else {
                    onAddToFavorite?.call(joke);
                  }
                },
              ),
            ],
          ),
        );
      case ErrorState():
        return DisplayErrorWidget(
          errorText: 'There was and error while loading jokes.',
          onRetryRequested: onRetryRequested,
        );
    }
  }
}
