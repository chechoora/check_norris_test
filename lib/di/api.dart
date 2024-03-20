import 'package:check_norris_test/data/api/category/category_api_service.dart';
import 'package:chopper/chopper.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final apiClient = Provider<ChopperClient>((ref) {
  final apiClient = ChopperClient(
    baseUrl: Uri.parse('https://api.chucknorris.io'),
    services: [
      CategoryApiService.create(),
    ],
    converter: const JsonConverter(),
  );
  return apiClient;
});

final categoryApiService = Provider<CategoryApiService>((ref) {
  return ref.read(apiClient).getService<CategoryApiService>();
});
