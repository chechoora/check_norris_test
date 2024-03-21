import 'package:check_norris_test/domain/model/joke.dart';
import 'package:chopper/chopper.dart';

class JokeApiMapper {
  Joke mapRandomJoke(Response response) {
    final body = response.body;
    final id = body['id'] as String;
    final value = body['value'] as String;
    return Joke(
      id: id,
      text: value,
    );
  }

  List<Joke> mapFromSearchJokes(Response response) {
    final body = response.body;
    final results = body['result'] as List;
    return results.map((joke) {
      final id = joke['id'] as String;
      final value = joke['value'] as String;
      return Joke(
        id: id,
        text: value,
      );
    }).toList();
  }
}
