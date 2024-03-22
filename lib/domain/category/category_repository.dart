import 'package:check_norris_test/domain/category/category_api_source.dart';
import 'package:check_norris_test/domain/model/category.dart';
import 'package:check_norris_test/domain/model/result.dart';

class CategoryRepository {
  final CategoryApiSource categorySource;

  CategoryRepository({
    required this.categorySource,
  });

  Future<Result<List<Category>>> fetchCategories() async {
    try {
      final result = await categorySource.fetchCategories();
      return DataResult(data: result);
    } on Exception catch (e) {
      return ErrorResult(message: e.toString());
    }
  }
}
