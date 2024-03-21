import 'package:check_norris_test/di/repository.dart';
import 'package:check_norris_test/router/navigation_manager.dart';
import 'package:check_norris_test/view/category/category_notifier.dart';
import 'package:check_norris_test/view/category/category_state.dart';
import 'package:check_norris_test/view/util/simple_loading_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class CategoryWidget extends ConsumerWidget {
  CategoryWidget({super.key});

  final notifier = StateNotifierProvider.autoDispose<CategoryNotifier, CategoryState>((ref) {
    return CategoryNotifier(
      categoryRepository: ref.read(categoryRepository),
    );
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(notifier);
    return Scaffold(
      body: _buildBody(state),
    );
  }

  Widget _buildBody(CategoryState state) {
    if (state is LoadingState) {
      return const SimpleLoadingWidget();
    } else if (state is DataState) {
      final categories = state.categories;
      return ListView.separated(
        itemBuilder: (context, index) {
          final category = categories[index];
          return InkWell(
            child: Text(category.name),
            onTap: () {
              context.push(
                NavigationManager.randomJokePath,
                extra: category.name,
              );
            },
          );
        },
        separatorBuilder: (context, index) {
          return const Divider();
        },
        itemCount: categories.length,
      );
    }
    throw ArgumentError('No widget for current state: $state');
  }
}
