import 'package:check_norris_test/data/database/database.dart';
import 'package:check_norris_test/domain/model/joke_item.dart';

class JokeDbService {
  final AppDatabase appDatabase;

  JokeDbService(this.appDatabase);

  Future<List<JokeTableData>> fetchSavedJokes() {
    return appDatabase.select(appDatabase.jokeTable).get();
  }

  Future<bool> saveJoke(JokeItem joke) async {
    final result = await appDatabase.into(appDatabase.jokeTable).insert(
          JokeTableCompanion.insert(
            serverId: joke.serverId,
            value: joke.text,
          ),
        );
    return result != -1;
  }

  Future<bool> deleteJoke(int id) async {
    final result = await (appDatabase.delete(appDatabase.jokeTable)
          ..where(
            (table) => table.id.isValue(
              id,
            ),
          ))
        .go();
    return result >= 0;
  }
}
