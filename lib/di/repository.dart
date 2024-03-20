import 'package:check_norris_test/data/api/category/category_api_mapper.dart';
import 'package:check_norris_test/di/api.dart';
import 'package:check_norris_test/domain/category/category_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final categoryRepository = Provider<CategoryRepository>((ref) {
  return CategoryRepository(
    categoryApiService: ref.read(categoryApiService),
    categoryApiMapper: CategoryApiMapper(),
  );
});
