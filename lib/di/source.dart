import 'package:check_norris_test/data/api/category/category_api_mapper.dart';
import 'package:check_norris_test/data/api/joke/joke_api_mapper.dart';
import 'package:check_norris_test/data/database/joke/joke_db_mapper.dart';
import 'package:check_norris_test/di/api.dart';
import 'package:check_norris_test/domain/category/category_api_source.dart';
import 'package:check_norris_test/domain/joke/joke_api_source.dart';
import 'package:check_norris_test/domain/joke/joke_db_source.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'db.dart';

final categoryApiSource = Provider<CategoryApiSource>((ref) {
  return CategoryApiSource(
    categoryApiService: ref.read(categoryApiService),
    categoryApiMapper: CategoryApiMapper(),
  );
});

final jokeApiSource = Provider<JokeApiSource>((ref) {
  return JokeApiSource(
    jokeApiService: ref.read(jokeApiService),
    jokeApiMapper: JokeApiMapper(),
  );
});

final jokeDbSource = Provider<JokeDbSource>((ref) {
  return JokeDbSource(
    jokeDbMapper: JokeDbMapper(),
    jokeDbService: ref.read(jokeDbService),
  );
});
