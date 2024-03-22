import 'dart:async';

import 'package:flutter/material.dart';

class DatabaseNotifier {
  final StreamController<DatabaseOperationInfo> _controller = StreamController.broadcast();
  final Map<ValueChanged<DatabaseOperationInfo>, StreamSubscription> _subscriptions = {};

  void addListener(ValueChanged<DatabaseOperationInfo> operationChangeListener) {
    _subscriptions[operationChangeListener] = _controller.stream.listen((event) {
      operationChangeListener.call(event);
    });
  }

  void removeListener(ValueChanged<DatabaseOperationInfo> operationChangeListener) {
    final subscription = _subscriptions[operationChangeListener];
    if (subscription != null) {
      subscription.cancel();
      _subscriptions.remove(operationChangeListener);
    }
  }

  void addOperation(DatabaseOperationInfo operation) {
    _controller.add(operation);
  }
}

class DatabaseOperationInfo {
  final String table;
  final DatabaseOperation operation;

  DatabaseOperationInfo({
    required this.table,
    required this.operation,
  });
}

enum DatabaseOperation { insert, delete, update }
