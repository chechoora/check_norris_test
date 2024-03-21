import 'package:check_norris_test/domain/model/joke_item.dart';
import 'package:chopper/chopper.dart';

class JokeApiMapper {
  JokeItem mapRandomJoke(Response response) {
    final body = response.body;
    final id = body['id'] as String;
    final value = body['value'] as String;
    return JokeItem(
      serverId: id,
      text: value,
    );
  }

  List<JokeItem> mapFromSearchJokes(Response response) {
    final body = response.body;
    final results = body['result'] as List;
    return results.map((joke) {
      final id = joke['id'] as String;
      final value = joke['value'] as String;
      return JokeItem(
        serverId: id,
        text: value,
      );
    }).toList();
  }
}
