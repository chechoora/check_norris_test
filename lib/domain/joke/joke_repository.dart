import 'package:check_norris_test/domain/joke/joke_api_source.dart';
import 'package:check_norris_test/domain/joke/joke_db_source.dart';
import 'package:check_norris_test/domain/model/joke_item.dart';
import 'package:check_norris_test/domain/model/result.dart';
import 'package:collection/collection.dart';

class JokeRepository {
  final JokeApiSource jokeApiSource;
  final JokeDbSource jokeDbSource;

  JokeRepository({
    required this.jokeApiSource,
    required this.jokeDbSource,
  });

  Future<Result<JokeItem>> fetchRandomJokeByCategory(String category) async {
    try {
      final storedJokes = await jokeDbSource.fetchSavedJokes();
      final serverJoke = await jokeApiSource.fetchRandomJokeByCategory(category);
      final storedJoke = storedJokes.firstWhereOrNull((joke) => joke.serverId == serverJoke.serverId);
      return DataResult(data: storedJoke ?? serverJoke);
    } on Exception catch (e) {
      return ErrorResult(message: e.toString());
    }
  }

  Future<Result<List<JokeItem>>> searchJokes(String text) async {
    try {
      final storedJokes = await jokeDbSource.fetchSavedJokes();
      final serverJokes = await jokeApiSource.searchJokes(text);
      final finalList = <JokeItem>[];
      for (var serverJoke in serverJokes) {
        final storedJoke = storedJokes.firstWhereOrNull((joke) => joke.serverId == serverJoke.serverId);
        finalList.add(storedJoke ?? serverJoke);
      }
      return DataResult(data: finalList);
    } on Exception catch (e) {
      return ErrorResult(message: e.toString());
    }
  }

  Future<List<JokeItem>> fetchStoredJokes() {
    return jokeDbSource.fetchSavedJokes();
  }

  Future<JokeItem> addToFavorite(JokeItem joke) {
    return jokeDbSource.addToFavorite(joke);
  }

  Future<JokeItem> removeFromFavorite(JokeItem joke) {
    return jokeDbSource.removeFromFavorite(joke);
  }
}
