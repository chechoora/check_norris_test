import 'package:check_norris_test/data/api/joke/joke_api_mapper.dart';
import 'package:check_norris_test/data/api/joke/joke_api_service.dart';
import 'package:check_norris_test/domain/model/joke_item.dart';

class JokeApiSource {
  final JokeApiService jokeApiService;
  final JokeApiMapper jokeApiMapper;

  JokeApiSource({
    required this.jokeApiService,
    required this.jokeApiMapper,
  });

  Future<JokeItem> fetchRandomJokeByCategory(String category) async {
    final response = await jokeApiService.fetchRandomJoke(category);
    return jokeApiMapper.mapRandomJoke(response);
  }

  Future<List<JokeItem>> searchJokes(String text) async {
    final response = await jokeApiService.searchJokes(text);
    return jokeApiMapper.mapFromSearchJokes(response);
  }
}
