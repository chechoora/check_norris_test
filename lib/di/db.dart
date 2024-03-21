import 'package:check_norris_test/data/database/database.dart';
import 'package:check_norris_test/data/database/joke/joke_db_service.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final appDataBase = Provider<AppDatabase>((ref) {
  return AppDatabase();
});

final jokeDbService = Provider<JokeDbService>((ref) {
  return JokeDbService(ref.read(appDataBase));
});
