import 'package:check_norris_test/data/database/database.dart';
import 'package:check_norris_test/data/database/database_notifier.dart';
import 'package:check_norris_test/data/database/joke/joke_table.dart';
import 'package:check_norris_test/domain/model/joke_item.dart';

class JokeDbService {
  final AppDatabase appDatabase;
  final DatabaseNotifier databaseNotifier;

  JokeDbService(
    this.appDatabase,
    this.databaseNotifier,
  );

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
    databaseNotifier.addOperation(
      DatabaseOperationInfo(
        table: (JokeTable).toString(),
        operation: DatabaseOperation.insert,
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
    databaseNotifier.addOperation(
      DatabaseOperationInfo(
        table: (JokeTable).toString(),
        operation: DatabaseOperation.delete,
      ),
    );
    return result >= 0;
  }

  Future<JokeTableData> fetchJokeByServerId(String serverId) async {
    return (await (appDatabase.select(appDatabase.jokeTable)
              ..where(
                (table) {
                  return table.serverId.isValue(serverId);
                },
              ))
            .get())
        .first;
  }
}
