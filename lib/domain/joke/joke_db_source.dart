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

  Future<JokeItem> addToFavorite(JokeItem joke) async {
    final result = await jokeDbService.saveJoke(joke);
    return jokeDbMapper.mapJoke(await jokeDbService.fetchJokeByServerId(joke.serverId));
  }

  Future<JokeItem> removeFromFavorite(JokeItem joke) async {
    final localId = joke.localId;
    if (localId == null) {
      return joke;
    }
    // TODO add error
    final result = await jokeDbService.deleteJoke(localId);
    return JokeItem(
      serverId: joke.serverId,
      text: joke.text,
    );
  }
}
