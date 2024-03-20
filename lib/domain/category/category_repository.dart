import 'package:check_norris_test/data/api/category/category_api_mapper.dart';
import 'package:check_norris_test/data/api/category/category_api_service.dart';
import 'package:check_norris_test/domain/model/category.dart';

class CategoryRepository {
  final CategoryApiService categoryApiService;
  final CategoryApiMapper categoryApiMapper;

  CategoryRepository({
    required this.categoryApiService,
    required this.categoryApiMapper,
  });

  Future<List<Category>> fetchCategories() async {
    final response = await categoryApiService.fetchCategories();
    return categoryApiMapper.mapCategory(response);
  }
}
