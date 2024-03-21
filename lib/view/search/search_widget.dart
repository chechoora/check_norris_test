import 'package:check_norris_test/di/repository.dart';
import 'package:check_norris_test/view/search/search_notifier.dart';
import 'package:check_norris_test/view/search/search_state.dart';
import 'package:check_norris_test/view/util/search_bar_bar.dart';
import 'package:check_norris_test/view/util/simple_loading_widget.dart';
import 'package:flutter/material.dart';
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
          _buildSearchBar(ref),
          _buildBody(state),
        ],
      ),
    );
  }

  Widget _buildSearchBar(WidgetRef ref) {
    return SearchBarWidget(
      onSubmitted: (newText) {
        ref.read(notifier.notifier).searchJokes(newText);
      },
    );
  }

  Widget _buildBody(SearchState state) {
    if (state is LoadingState) {
      return const SimpleLoadingWidget();
    } else if (state is DataState) {
      final jokes = state.jokes;
      return Expanded(
        child: ListView.separated(
          itemBuilder: (context, index) {
            final joke = jokes[index];
            return Text(joke.text);
          },
          separatorBuilder: (context, index) {
            return const Divider();
          },
          itemCount: jokes.length,
        ),
      );
    }
    throw ArgumentError('No widget for current state: $state');
  }
}
