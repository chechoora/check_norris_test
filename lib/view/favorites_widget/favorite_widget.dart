import 'package:check_norris_test/di/repository.dart';
import 'package:check_norris_test/domain/model/joke_item.dart';
import 'package:check_norris_test/view/favorites_widget/favorite_notifier.dart';
import 'package:check_norris_test/view/favorites_widget/favorite_state.dart';
import 'package:check_norris_test/view/util/simple_loading_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class FavoriteWidget extends ConsumerWidget {
  FavoriteWidget({super.key});

  late final provider = StateNotifierProvider.autoDispose<FavoriteNotifier, FavoriteState>((ref) {
    return FavoriteNotifier(
      jokeRepository: ref.read(jokeRepository),
      favoriteListener: ref.read(jokeFavoriteListener),
    );
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(provider);
    return Scaffold(
      body: _DisplayWidget(
        state: state,
        onRemoveFromFavorite: (joke) {
          ref.read(provider.notifier).removeFromFavorite(joke);
        },
      ),
    );
  }
}

class _DisplayWidget extends StatelessWidget {
  const _DisplayWidget({
    required this.state,
    this.onRemoveFromFavorite,
  });

  final FavoriteState state;
  final ValueChanged<JokeItem>? onRemoveFromFavorite;

  @override
  Widget build(BuildContext context) {
    if (state is LoadingState) {
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
                if (joke.isStored)
                  IconButton(
                    icon: const Icon(Icons.delete),
                    onPressed: () {
                      onRemoveFromFavorite?.call(joke);
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
