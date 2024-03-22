import 'package:check_norris_test/di/db.dart';
import 'package:check_norris_test/di/source.dart';
import 'package:check_norris_test/domain/category/category_repository.dart';
import 'package:check_norris_test/domain/joke/joke_favorite_listener.dart';
import 'package:check_norris_test/domain/joke/joke_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final categoryRepository = Provider<CategoryRepository>((ref) {
  return CategoryRepository(
    categorySource: ref.read(categoryApiSource),
  );
});

final jokeRepository = Provider<JokeRepository>((ref) {
  return JokeRepository(
    jokeApiSource: ref.read(jokeApiSource),
    jokeDbSource: ref.read(jokeDbSource),
  );
});

final jokeFavoriteListener = Provider<JokeFavoriteListener>((ref) {
  return JokeFavoriteListener(
    databaseNotifier: ref.read(databaseNotifier),
  );
});
