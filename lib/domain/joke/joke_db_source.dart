import 'package:check_norris_test/data/database/joke/joke_db_mapper.dart';
import 'package:check_norris_test/data/database/joke/joke_db_service.dart';
import 'package:check_norris_test/domain/model/joke_item.dart';

class JokeDbSource {
  final JokeDbService jokeDbService;
  final JokeDbMapper jokeDbMapper;

  JokeDbSource({
    required this.jokeDbService,
    required this.jokeDbMapper,
  });

  Future<List<JokeItem>> fetchSavedJokes() async {
    final items = await jokeDbService.fetchSavedJokes();
    return jokeDbMapper.mapJokes(items);
  }
}
