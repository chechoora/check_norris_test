import 'package:chopper/chopper.dart';

part "joke_api_service.chopper.dart";

@ChopperApi()
abstract class JokeApiService extends ChopperService {
  static JokeApiService create([ChopperClient? client]) => _$JokeApiService(client);

  @Get(path: "/jokes/random")
  Future<Response> fetchRandomJoke(@Query("category") String category);

  @Get(path: "/jokes/search")
  Future<Response> searchJokes(@Query("query") String query);
}
