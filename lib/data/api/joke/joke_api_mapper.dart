import 'package:check_norris_test/domain/model/random_joke.dart';
import 'package:chopper/chopper.dart';

class JokeApiMapper {
  RandomJoke mapRandomJoke(Response response) {
    final body = response.body;
    final id = body['id'] as String;
    final value = body['value'] as String;
    return RandomJoke(
      id: id,
      text: value,
    );
  }
}
