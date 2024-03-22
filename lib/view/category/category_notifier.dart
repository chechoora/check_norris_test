import 'package:check_norris_test/domain/category/category_repository.dart';
import 'package:check_norris_test/domain/model/category.dart';
import 'package:check_norris_test/domain/model/result.dart';
import 'package:check_norris_test/view/category/category_state.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CategoryNotifier extends StateNotifier<CategoryState> {
  CategoryNotifier({
    required this.categoryRepository,
  }) : super(LoadingState()) {
    fetchCategories();
  }

  final CategoryRepository categoryRepository;

  Future<void> fetchCategories() async {
    state = LoadingState();
    final result = await categoryRepository.fetchCategories();
    switch (result) {
      case ErrorResult<List<Category>>():
        state = ErrorState();
      case DataResult<List<Category>>():
        state = DataState(categories: result.data);
    }
  }
}
