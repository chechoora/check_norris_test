import 'package:check_norris_test/domain/category/category_api_source.dart';
import 'package:check_norris_test/domain/model/category.dart';

class CategoryRepository {
  final CategoryApiSource categorySource;

  CategoryRepository({
    required this.categorySource,
  });

  Future<List<Category>> fetchCategories() async {
    return categorySource.fetchCategories();
  }
}
