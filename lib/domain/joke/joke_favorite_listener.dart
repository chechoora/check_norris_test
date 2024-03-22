import 'package:check_norris_test/data/database/database_notifier.dart';
import 'package:check_norris_test/data/database/joke/joke_table.dart';
import 'package:flutter/material.dart';

class JokeFavoriteListener {
  JokeFavoriteListener({
    required this.databaseNotifier,
  });

  final DatabaseNotifier databaseNotifier;
  final map = <VoidCallback, ValueChanged<DatabaseOperationInfo>>{};

  void addListener(VoidCallback callback) {
    listener(value) {
      if (value.table == (JokeTable).toString()) {
        callback.call();
      }
    }
    map[callback] = listener;
    databaseNotifier.addListener(listener);
  }

  void removeListener(VoidCallback callback) {
    final listener = map[callback];
    if (listener != null) {
      databaseNotifier.removeListener(listener);
      map.remove(callback);
    }
  }
}
