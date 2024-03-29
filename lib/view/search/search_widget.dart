import 'package:check_norris_test/di/repository.dart';
import 'package:check_norris_test/domain/model/joke_item.dart';
import 'package:check_norris_test/view/search/search_notifier.dart';
import 'package:check_norris_test/view/search/search_state.dart';
import 'package:check_norris_test/view/util/display_error_widget.dart';
import 'package:check_norris_test/view/util/search_bar_bar.dart';
import 'package:check_norris_test/view/util/simple_loading_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SearchWidget extends ConsumerWidget {
  SearchWidget({super.key});

  late final provider = StateNotifierProvider.autoDispose<SearchNotifier, SearchState>((ref) {
    return SearchNotifier(
      jokeRepository: ref.read(jokeRepository),
      favoriteListener: ref.read(jokeFavoriteListener),
    );
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(provider);
    return Scaffold(
      body: Column(
        children: [
          SearchBarWidget(
            onSubmitted: (newText) {
              ref.read(provider.notifier).searchJokes(newText);
            },
          ),
          Expanded(
            child: _DisplayWidget(
              state: state,
              onAddToFavorite: (joke) {
                ref.read(provider.notifier).addToFavorite(joke);
              },
              onRemoveFromFavorite: (joke) {
                ref.read(provider.notifier).removeFromFavorite(joke);
              },
              onRetryRequested: () {
                ref.read(provider.notifier).retrySearch();
              },
            ),
          ),
        ],
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

  final SearchState state;
  final ValueChanged<JokeItem>? onAddToFavorite;
  final ValueChanged<JokeItem>? onRemoveFromFavorite;
  final VoidCallback? onRetryRequested;

  @override
  Widget build(BuildContext context) {
    switch (state) {
      case IdleState():
        return const Center(
          child: Text('Type something to find Chuck Norris meme'),
        );
      case LoadingState():
        return const SimpleLoadingWidget();
      case DataState():
        final jokes = (state as DataState).jokes;
        return ListView.builder(
          itemBuilder: (context, index) {
            final joke = jokes[index];
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
          },
          itemCount: jokes.length,
        );
      case ErrorState():
        return DisplayErrorWidget(
          errorText: 'There was and error while loading your joke.',
          onRetryRequested: onRetryRequested,
        );
    }
  }
}
