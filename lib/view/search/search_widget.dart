import 'package:check_norris_test/di/repository.dart';
import 'package:check_norris_test/domain/model/joke_item.dart';
import 'package:check_norris_test/view/search/search_notifier.dart';
import 'package:check_norris_test/view/search/search_state.dart';
import 'package:check_norris_test/view/util/search_bar_bar.dart';
import 'package:check_norris_test/view/util/simple_loading_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SearchWidget extends ConsumerWidget {
  SearchWidget({super.key});

  late final notifier = StateNotifierProvider.autoDispose<SearchNotifier, SearchState>((ref) {
    return SearchNotifier(
      jokeRepository: ref.read(jokeRepository),
    );
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(notifier);
    return Scaffold(
      body: Column(
        children: [
          SearchBarWidget(
            onSubmitted: (newText) {
              ref.read(notifier.notifier).searchJokes(newText);
            },
          ),
          Expanded(
            child: _DisplayWidget(
              state: state,
              onAddToFavorite: (joke) {
                ref.read(notifier.notifier).addToFavorite(joke);
              },
              onRemoveFromFavorite: (joke) {
                ref.read(notifier.notifier).removeFromFavorite(joke);
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
  });

  final SearchState state;
  final ValueChanged<JokeItem>? onAddToFavorite;
  final ValueChanged<JokeItem>? onRemoveFromFavorite;

  @override
  Widget build(BuildContext context) {
    if (state is IdleState) {
      return const Center(
        child: Text('Type something to find Chuck Norris meme'),
      );
    } else if (state is LoadingState) {
      return const SimpleLoadingWidget();
    } else if (state is DataState) {
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
    }
    throw ArgumentError('No widget for current state: $state');
  }
}
