class JokeItem {
  final String serverId;
  final String text;
  final int? localId;

  JokeItem({
    required this.serverId,
    required this.text,
    this.localId,
  });

  bool get isStored => localId != null;
}
