import 'package:check_norris_test/data/api/joke/joke_api_mapper.dart';
import 'package:check_norris_test/data/api/joke/joke_api_service.dart';
import 'package:check_norris_test/domain/model/joke.dart';

class JokeRepository {
  final JokeApiService jokeApiService;
  final JokeApiMapper jokeApiMapper;

  JokeRepository({
    required this.jokeApiService,
    required this.jokeApiMapper,
  });

  Future<Joke> fetchRandomJokeByCategory(String category) async {
    final response = await jokeApiService.fetchRandomJoke(category);
    return jokeApiMapper.mapRandomJoke(response);
  }

  Future<List<Joke>> searchJokes(String text) async {
    final response = await jokeApiService.searchJokes(text);
    return jokeApiMapper.mapFromSearchJokes(response);
  }
}
