import 'package:check_norris_test/domain/category/category_repository.dart';
import 'package:check_norris_test/view/category/category_state.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CategoryNotifier extends StateNotifier<CategoryState> {
  CategoryNotifier({
    required this.categoryRepository,
  }) : super(LoadingState()) {
    _fetchCategories();
  }

  final CategoryRepository categoryRepository;

  Future<void> _fetchCategories() async {
    state = LoadingState();
    state = DataState(categories: await categoryRepository.fetchCategories());
  }
}
