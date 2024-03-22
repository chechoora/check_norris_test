import 'package:check_norris_test/di/repository.dart';
import 'package:check_norris_test/router/navigation_manager.dart';
import 'package:check_norris_test/view/category/category_notifier.dart';
import 'package:check_norris_test/view/category/category_state.dart';
import 'package:check_norris_test/view/util/display_error_widget.dart';
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
      body: _DisplayWidget(
        state: state,
        onRetryRequested: () {
          ref.read(notifier.notifier).fetchCategories();
        },
      ),
    );
  }
}

class _DisplayWidget extends StatelessWidget {
  const _DisplayWidget({
    required this.state,
    this.onRetryRequested,
  });

  final CategoryState state;
  final VoidCallback? onRetryRequested;

  @override
  Widget build(BuildContext context) {
    switch (state) {
      case LoadingState():
        return const SimpleLoadingWidget();
      case DataState():
        final categories = (state as DataState).categories;
        return ListView.builder(
          itemBuilder: (context, index) {
            final category = categories[index];
            return InkWell(
              child: Container(
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Theme.of(context).primaryColor,
                  ),
                  borderRadius: BorderRadius.circular(10),
                ),
                margin: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
                padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                child: Text(
                  category.name,
                  style: const TextStyle(
                    fontSize: 18,
                  ),
                ),
              ),
              onTap: () {
                context.push(
                  NavigationManager.randomJokePath,
                  extra: category.name,
                );
              },
            );
          },
          itemCount: categories.length,
        );
      case ErrorState():
        return DisplayErrorWidget(
          errorText: 'There was and error while loading categories.',
          onRetryRequested: onRetryRequested,
        );
    }
  }
}
