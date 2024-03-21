class Joke {
  final String id;
  final String text;
  final int? localId;
  final bool isFavorite;

  Joke({
    required this.id,
    required this.text,
    this.localId,
    this.isFavorite = false,
  });

  bool get isStored => localId != null;
}
