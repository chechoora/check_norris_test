import 'package:check_norris_test/domain/model/category.dart';
import 'package:chopper/chopper.dart';

class CategoryApiMapper {
  List<Category> mapCategory(Response response) {
    final List<dynamic> jsonResponse = response.body;
    return jsonResponse
        .whereType<String>()
        .map(
          (e) => Category(
            name: e,
          ),
        )
        .toList();
  }
}
