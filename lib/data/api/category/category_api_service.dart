import 'package:chopper/chopper.dart';

part "category_api_service.chopper.dart";

@ChopperApi()
abstract class CategoryApiService extends ChopperService {
  static CategoryApiService create([ChopperClient? client]) => _$CategoryApiService(client);

  @Get(path: "/jokes/categories")
  Future<Response> fetchCategories();

}
