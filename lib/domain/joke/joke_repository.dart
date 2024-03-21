import 'package:check_norris_test/data/api/joke/joke_api_mapper.dart';
import 'package:check_norris_test/data/api/joke/joke_api_service.dart';
import 'package:check_norris_test/domain/model/random_joke.dart';

class JokeRepository {
  final JokeApiService jokeApiService;
  final JokeApiMapper jokeApiMapper;

  JokeRepository({
    required this.jokeApiService,
    required this.jokeApiMapper,
  });

  Future<RandomJoke> fetchRandomJokeByCategory(String category) async {
    final response = await jokeApiService.fetchRandomJoke(category);
    return jokeApiMapper.mapRandomJoke(response);
  }
}
