import 'package:check_norris_test/data/database/database.dart';
import 'package:check_norris_test/domain/model/joke_item.dart';

class JokeDbMapper {
  List<JokeItem> mapJokes(List<JokeTableData> jokeList) {
    return jokeList
        .map(
          (e) => JokeItem(
            serverId: e.serverId,
            text: e.value,
            localId: e.id,
          ),
        )
        .toList();
  }
}
