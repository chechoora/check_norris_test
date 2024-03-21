import 'package:check_norris_test/data/api/category/category_api_mapper.dart';
import 'package:check_norris_test/data/api/category/category_api_service.dart';
import 'package:check_norris_test/domain/model/category.dart';

class CategoryApiSource {
  final CategoryApiService categoryApiService;
  final CategoryApiMapper categoryApiMapper;

  CategoryApiSource({
    required this.categoryApiService,
    required this.categoryApiMapper,
  });

  Future<List<Category>> fetchCategories() async {
    final response = await categoryApiService.fetchCategories();
    return categoryApiMapper.mapCategory(response);
  }
}
